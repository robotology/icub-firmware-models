# 1. Introduction
This folder contains the Simulink model for the Force-Torque sensor firmware.

<img src="assets/model001.png" width="600px">

The model is used for code generation.

# 2. Version

| Application | version |
| ----------- | ------- |
| MATLAB      |2021a         |
| Simulink    |2021a         |
| C++         |C++11         |
| Model       |v1.0.0        |

# 3. The model
The model implements the conversion from ADC raw values to Force-Torque values in the Strain2 sensor.

## 3.1. Input
ADC raw values are an array of 6 values, 16 bit each, type: **unsigned**.

## 3.2. Output
Force-Torque values are an array of 6 values, 16 bit each, type: **Q15**.  
The output is back-compatible with the current YARP implementation.

## 3.3. Parameters
- Conversion matrix dimensions 6x6, 16 bit each, type: **integer**.
- Offset dimensions 6x1, 16 bit each, type: **unsigned**.

# 4. Code generation

## 4.1. Base operations
In order to generate the C++ code, open the `Embedded Coder` application on Simulink tab.

<br><br>
<img src="assets/embedded-coder.png" width="600px">  
<br>

Set the correct parameters in `C/C++ Settings --> Code generation settings --> Solver`.

<img src="assets/solver.png" width="600px">

Finally, use the `Generate code` button.

## 4.2. Advanced operations settings

### 4.2.1. Matrix calculation for rows
This setting in essential for the correct code generation for matrix multiplication.
In the firmware memory at the moment the matrix is stored as a raws array.

Select the following options:

From *c++CODE->Settings*

<img src="assets/matrix002.png" width="600px">  


From *Code Generation->Interface*, select ```Row-major``` in **array layout**

<img src="assets/matrix001.png" width="600px">

From *Math and data Types->Interface*, select ```Use algorithms optimized ...```

<img src="assets/matrix003.png" width="600px">

### 4.2.2. Disable optimization for cast problems
Select the following options:

From *c++CODE->Settings*
From *Code Generation->Optimization*, select ```Minimum (debugging)``` in **Level**

<img src="assets/optimization001.png" width="600px">

# 5. Note

## 5.1. Public parameters
The parameters needs to have public access.
To specify that, click on the `Code Interface` button of tha App and then the `Model parameters` option.  

<img src="assets/public-parameters.png" width="600px">
