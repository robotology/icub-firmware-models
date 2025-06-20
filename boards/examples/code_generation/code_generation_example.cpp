//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// File: code_generation_example.cpp
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
#include "code_generation_example.h"
#include <atomic>
#include <immintrin.h>
#include <stdint.h>
#include <array>

// Model step function for TID0
void code_generation_example::step0()          // Sample time: [1.0s, 0.0s]
{
  __m256d tmp;
  std::array<double, 16> rtb_RateTransition;
  int32_t i;
  int32_t i_0;
  int8_t tmpBufIdx;

  // RateTransition: '<Root>/Rate Transition'
  rtDW.RateTransition_WrLock = 0;
  rtDW.RateTransition_RdLock = 0;
  tmpBufIdx = rtDW.RateTransition_LstBufWR;
  rtDW.RateTransition_LstWrLatchAtWr = tmpBufIdx;
  if (!rtDW.RateTransition_RdLock.exchange(true, std::memory_order_seq_cst)) {
    tmpBufIdx = rtDW.RateTransition_LstWrLatchAtWr;
  } else {
    tmpBufIdx = rtDW.RateTransition_LstWrLatchAtRd;
  }

  i = tmpBufIdx << 4;
  for (i_0 = 0; i_0 < 16; i_0++) {
    rtb_RateTransition[i_0] = rtDW.RateTransition_Buf[i_0 + i];
  }

  // End of RateTransition: '<Root>/Rate Transition'

  // Outport: '<Root>/Out1_1s' incorporates:
  //   Inport: '<Root>/In1_1s'
  //   Sum: '<Root>/Sum'

  for (i = 0; i <= 12; i += 4) {
    // Sum: '<Root>/Sum'
    tmp = _mm256_loadu_pd(&rtb_RateTransition[i]);
    _mm256_storeu_pd(&rtY.Out1_1s[i], _mm256_add_pd(_mm256_loadu_pd
      (&rtU.In1_1s[i]), tmp));
  }

  // End of Outport: '<Root>/Out1_1s'
}

// Model step function for TID1
void code_generation_example::step1()          // Sample time: [2.0s, 0.0s]
{
  int32_t i;
  int8_t tmpBufIdx;
  int8_t wrBuf;

  // Outport: '<Root>/Out2_2s' incorporates:
  //   Gain: '<Root>/Gain1'
  //   Inport: '<Root>/In2_2s'

  for (i = 0; i <= 12; i += 4) {
    _mm256_storeu_pd(&rtY.Out2_2s[i], _mm256_mul_pd(_mm256_set1_pd(5.0),
      _mm256_loadu_pd(&rtU.In2_2s[i])));
  }

  // End of Outport: '<Root>/Out2_2s'

  // Update for RateTransition: '<Root>/Rate Transition' incorporates:
  //   Inport: '<Root>/In2_2s'

  wrBuf = 0;
  if (rtDW.RateTransition_WrLock != 0) {
    tmpBufIdx = rtDW.RateTransition_PreBufRd;
  } else {
    tmpBufIdx = rtDW.RateTransition_LstBufWR;
    rtDW.RateTransition_LstWrLatchAtRd = tmpBufIdx;
    rtDW.RateTransition_WrLock = 1;
    if (!rtDW.RateTransition_RdLock.exchange(true, std::memory_order_seq_cst)) {
      tmpBufIdx = rtDW.RateTransition_LstWrLatchAtRd;
    } else {
      tmpBufIdx = rtDW.RateTransition_LstWrLatchAtWr;
    }

    rtDW.RateTransition_PreBufRd = tmpBufIdx;
  }

  i = 0;
  while (i < 3) {
    if ((rtDW.RateTransition_LstBufWR != i) && (tmpBufIdx != i)) {
      wrBuf = static_cast<int8_t>(i);
      i = 3;
    }

    i++;
  }

  for (i = 0; i < 16; i++) {
    rtDW.RateTransition_Buf[i + (wrBuf << 4)] = rtU.In2_2s[i];
  }

  rtDW.RateTransition_LstBufWR = wrBuf;

  // End of Update for RateTransition: '<Root>/Rate Transition'
}

// Model initialize function
void code_generation_example::initialize()
{
  // Registration code

  // Set task counter limit used by the static main program
  ((&rtM))->Timing.TaskCounters.cLimit[0] = 1;
  ((&rtM))->Timing.TaskCounters.cLimit[1] = 2;
}

// Constructor
code_generation_example::code_generation_example() :
  rtU(),
  rtY(),
  rtDW(),
  rtM()
{
  // Currently there is no constructor body generated.
}

// Destructor
// Currently there is no destructor body generated.
code_generation_example::~code_generation_example() = default;

// Real-Time Model get method
RT_MODEL * code_generation_example::getRTM()
{
  return (&rtM);
}

uint8_t &RT_MODEL::TaskCounter(int32_t idx)
{
  return (Timing.TaskCounters.TID[(idx)]);
}

bool RT_MODEL::StepTask(int32_t idx) const
{
  return (Timing.TaskCounters.TID[(idx)] == 0);
}

uint8_t &RT_MODEL::CounterLimit(int32_t idx)
{
  return (Timing.TaskCounters.cLimit[(idx)]);
}

//
// File trailer for generated code.
//
// [EOF]
//
