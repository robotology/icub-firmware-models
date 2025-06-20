//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// File: code_generation_example.h
//
// Code generated for Simulink model 'code_generation_example'.
//
// Model version                  : 1.7
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Tue Jun 17 18:12:03 2025
//
// Target selection: ert.tlc
// Embedded hardware selection: Intel->x86-64 (Linux 64)
// Code generation objectives:
//    1. Execution efficiency
//    2. Traceability
// Validation result: Not run
//
#ifndef code_generation_example_h_
#define code_generation_example_h_
#include <stdbool.h>
#include <stdint.h>
#include <array>
#include <atomic>
#define code_generation_example_M              (rtM)

// Forward declaration for rtModel
typedef struct tag_RTM RT_MODEL;

// Block signals and states (default storage) for system '<Root>'
struct DW {
  std::atomic<bool> RateTransition_RdLock;// '<Root>/Rate Transition'
  std::array<double, 48> RateTransition_Buf;// '<Root>/Rate Transition'
  int8_t RateTransition_LstBufWR;      // '<Root>/Rate Transition'
  int8_t RateTransition_PreBufRd;      // '<Root>/Rate Transition'
  int8_t RateTransition_WrLock;        // '<Root>/Rate Transition'
  int8_t RateTransition_LstWrLatchAtWr;// '<Root>/Rate Transition'
  int8_t RateTransition_LstWrLatchAtRd;// '<Root>/Rate Transition'
};

// External inputs (root inport signals with default storage)
struct ExtU {
  std::array<double, 16> In1_1s;       // '<Root>/In1_1s'
  std::array<double, 16> In2_2s;       // '<Root>/In2_2s'
};

// External outputs (root outports fed by signals with default storage)
struct ExtY {
  std::array<double, 16> Out1_1s;      // '<Root>/Out1_1s'
  std::array<double, 16> Out2_2s;      // '<Root>/Out2_2s'
};

// Real-time Model Data Structure
struct tag_RTM {
  //
  //  Timing:
  //  The following substructure contains information regarding
  //  the timing information for the model.

  struct {
    struct {
      uint8_t TID[2];
      uint8_t cLimit[2];
    } TaskCounters;
  } Timing;

  uint8_t &TaskCounter(int32_t idx);
  bool StepTask(int32_t idx) const;
  uint8_t &CounterLimit(int32_t idx);
};

// Class declaration for model code_generation_example
class code_generation_example final
{
  // public data and function members
 public:
  // Copy Constructor
  code_generation_example(code_generation_example const&) = delete;

  // Assignment Operator
  code_generation_example& operator= (code_generation_example const&) & = delete;

  // Move Constructor
  code_generation_example(code_generation_example &&) = delete;

  // Move Assignment Operator
  code_generation_example& operator= (code_generation_example &&) = delete;

  // Real-Time Model get method
  RT_MODEL * getRTM();

  // Root inports set method
  void setExternalInputs(const ExtU *pExtU)
  {
    rtU = *pExtU;
  }

  // Root outports get method
  const ExtY &getExternalOutputs() const
  {
    return rtY;
  }

  // model initialize function
  void initialize();

  // model step function
  void step0();

  // model step function
  void step1();

  // Constructor
  code_generation_example();

  // Destructor
  ~code_generation_example();

  // private data and function members
 private:
  // External inputs
  ExtU rtU;

  // External outputs
  ExtY rtY;

  // Block states
  DW rtDW;

  // Real-Time Model
  RT_MODEL rtM;
};

//-
//  The generated code includes comments that allow you to trace directly
//  back to the appropriate location in the model.  The basic format
//  is <system>/block_name, where system is the system number (uniquely
//  assigned by Simulink) and block_name is the name of the block.
//
//  Use the MATLAB hilite_system command to trace the generated code back
//  to the model.  For example,
//
//  hilite_system('<S3>')    - opens system 3
//  hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
//
//  Here is the system hierarchy for this model
//
//  '<Root>' : 'code_generation_example'


//-
//  Requirements for '<Root>': code_generation_example


#endif                                 // code_generation_example_h_

//
// File trailer for generated code.
//
// [EOF]
//
