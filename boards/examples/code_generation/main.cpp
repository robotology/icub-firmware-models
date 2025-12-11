// Copyright (C) 2025 Fondazione Istituto Italiano di Tecnologia (IIT)  
// All Rights Reserved.
// Authors: Mattia Fussi <mattia.fussi@iit.it>

#include "mbd/code_generation_example.h"

#include <yarp/os/all.h>

#include <iostream>
#include <memory>

using namespace yarp::os;


 /*
 External inputs of the generated code shared between threads. 
 As long as different threads write different struct members, 
 mutual exclusions between threads are not needed, provided
 hat mutexes are used inside the generated code to avoid read/write overlap
 */ 

ExtU mbd_inputs;

constrexpr double PI = 3.14152;

/*
A simple flag that controls printing
*/
std::atomic_flag is_printing = false;

// A simple function that prints an array of numbers with a prefix
void printer(const std::array<double, 16>& arr, std::string pre)
{
    std::string str;
   
    for (auto & o : arr)
        str += std::to_string(o) + " ";

    std::cout << pre << str << std::endl;
}

/* -----------------------------
        THREAD 1sec PERIOD
This thread calls the generated code periodically by using a reference to it.
The call is executed at each millisecond with the run() function. 
A yarp::os::periodicthread is used to handle periodic calls, and handle SIGINT
----------------------------- */

class fastThread : public PeriodicThread {
private:
    std::shared_ptr<code_generation_example> mbd_;

public:
    fastThread(double period, std::shared_ptr<code_generation_example> mbd) 
        : PeriodicThread(period), mbd_(std::move(mbd)) {}
    
    virtual ~fastThread() = default;

    bool threadInit() override { 

        for (size_t i = 0; i < mbd_inputs.In1_1s.size(); i++)
        {
            mbd_inputs.In1_1s[i] = PI + static_cast<double>(i);
        }
        return true;
    }

    void run() override {
        mbd_->setExternalInputs(&mbd_inputs);
        mbd_->step0();

        std::array<double, 16> outs1 = mbd_->getExternalOutputs().Out1_1s;

        is_printing.test_and_set();
        printer(outs1, "1S :: ");
    }

    void threadRelease() override {}
};


/* -----------------------------
        THREAD 2sec PERIOD
This thread calls the generated code periodically by using a reference to it.
The call is executed at each millisecond with the run() function. 
A yarp::os::periodicthread is used to handle periodic calls, and handle SIGINT
----------------------------- */

class slowThread : public PeriodicThread {
private:
    std::shared_ptr<code_generation_example> mbd_;

public:
    slowThread(double period, std::shared_ptr<code_generation_example> mbd) 
        : PeriodicThread(period), mbd_(std::move(mbd)) {}
    
    virtual ~slowThread() = default;

    bool threadInit() override { 
        for (auto & in1 : mbd_inputs.In2_2s) in1 = 77;
        return true;
    }

    void run() override {
        mbd_->setExternalInputs(&mbd_inputs);
        mbd_->step1();

        std::array<double, 16> outs2 = mbd_->getExternalOutputs().Out2_2s;

        is_printing.test_and_set();
        printer(outs2, "2S :: ");
    }

    void threadRelease() override {}
};

/* -----------------------------
        MODULE CLASS
yarp::os::RFModule is a class that instantiates a periodic thread at 1sec, which
is usually used as a health monitor for all the other threads that are spawned from it.
It also is a yarp::os::ResourceFinder, an object that is very useful for processing
command line arguments and configuration files.
----------------------------- */

class module : public RFModule {
private:
    std::unique_ptr<fastThread> thread_1_;
    std::unique_ptr<slowThread> thread_2_;
    std::shared_ptr<code_generation_example> mbd_;

public:
    module() {}
    
    virtual ~module() = default;

    bool configure(ResourceFinder& rf) override {

        // Instantiate a shared pointer to the code generation object.
        // The shared pointer is useful because it keeps a count of the references,
        // and deallocates the object when all its references are out of scope.
        mbd_ = std::make_shared<code_generation_example>();

        mbd_->initialize();

        // We instantiate two pointers to two different threads.
        // We pass a reference to the pointer so that the one instance of mbd code
        // can be used by both threads, keeping one single internal state
        thread_1_ = std::make_unique<fastThread>(1.0, mbd_);
        thread_2_ = std::make_unique<slowThread>(2.0, mbd_);

        if (!thread_1_->start()) return false;
        if (!thread_2_->start()) return false;

        return true;
    }

    bool updateModule() override {
        return (thread_1_->isRunning() && thread_2_->isRunning());
    }

    bool close() override {
        if (thread_1_->isRunning()) thread_1_->stop();
        if (thread_2_->isRunning()) thread_2_->stop();
        return true;
    }
};

/* -----------------------------
            MAIN
----------------------------- */

int main(int argc, char* argv[])
{
    ResourceFinder rf;
    rf.configure(argc, argv);
    module m;

    return m.runModule(rf);
}
