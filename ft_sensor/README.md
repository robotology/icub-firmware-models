# 1. Introduction

This folder contains the Simulink model for the Force-Torque sensor firmware.
<img src="img/model001.png" width="600px">

The model is to be used for code generation see above.

# 2. Version

| Application | version |
| ----------- | ------- |
| Matlab      |2021a         |
| Simulink    |2021a         |
| c++         |c++11         |
| Model       |v.1.0         |

# 3. The model

The model implements the transformation from ADC raw values to Force-Torque values in the Strain2 sensor.

## 3.1. Input

ADC raw value array of 6 values, 16 bit each type: **unsigned**.

## 3.2. Output

Force-Torque value array of 6 values, 16 bit each type: **Q15**.  
The output is back-compatible with the current Yarp implementation.

## 3.3. Parameters

- Conversion matrix dimensions 6x6, 16 bit each type: **integer**.
- Offset dimensions 6x1, 16 bit each type: **unsigned**.

# 4. Code generation

In order to generte the c++ code open the `Embedded Coder` application on Simulink tab.
<br><br>
<img src="img/embedded-coder.png" width="600px">  
<br>
Set the correct parameters in `c/c++ Settings->Code generation settings->Solver`

<img src="img/solver.png" width="600px">

Finally, use the `Generate code` button

# 5. Note

## 5.1. Public parameters

The parameters as described in [Parameters cap.](##3.3.-parameters) are generated as public.  
See in ```Code interface``` button, ```Model parameters``` line.  

<img src="img/public-parameters.png" width="600px">