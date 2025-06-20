#include "mbd/code_generation_example.h"

#include <yarp/os/all.h>

#include <iostream>
#include <memory>

using namespace yarp::os;

ExtU gInputs;

std::atomic_flag is_printing = false;

void printer(const std::array<double, 16>& arr, std::string pre)
{
    std::string str;
   
    for (auto & o : arr)
        str += std::to_string(o) + " ";

    std::cout << pre << str << std::endl;
}

/* -----------------------------
        THREAD 1sec PERIOD
----------------------------- */

class fastThread : public PeriodicThread {
private:
    std::shared_ptr<code_generation_example> mbd_;

public:
    fastThread(double period, std::shared_ptr<code_generation_example> mbd) 
        : PeriodicThread(period), mbd_(std::move(mbd)) {}
    
    virtual ~fastThread() = default;

    bool threadInit() override { 

        for (size_t i = 0; i < gInputs.In1_1s.size(); i++)
        {
            gInputs.In1_1s[i] = 3.14152 + static_cast<double>(i);
        }
        return true;
    }

    void run() override {
        mbd_->setExternalInputs(&gInputs);
        mbd_->step0();

        std::array<double, 16> outs1 = mbd_->getExternalOutputs().Out1_1s;

        is_printing.test_and_set();
        printer(outs1, "1S :: ");
    }

    void threadRelease() override {}
};


/* -----------------------------
        THREAD 2sec PERIOD
----------------------------- */

class slowThread : public PeriodicThread {
private:
    std::shared_ptr<code_generation_example> mbd_;

public:
    slowThread(double period, std::shared_ptr<code_generation_example> mbd) 
        : PeriodicThread(period), mbd_(std::move(mbd)) {}
    
    virtual ~slowThread() = default;

    bool threadInit() override { 
        for (auto & in1 : gInputs.In2_2s) in1 = 77;
        return true;
    }

    void run() override {
        mbd_->setExternalInputs(&gInputs);
        mbd_->step1();

        std::array<double, 16> outs2 = mbd_->getExternalOutputs().Out2_2s;

        is_printing.test_and_set();
        printer(outs2, "2S :: ");
    }

    void threadRelease() override {}
};

/* -----------------------------
        MODULE CLASS
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
        mbd_ = std::make_shared<code_generation_example>();

        mbd_->initialize();

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
