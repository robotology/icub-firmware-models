# The Techie's guide to code generation in Simulink

This document is intended as a collection of guidelines and instructions on how to effectively generate code from Matlab/Simulink, more specifically the second. It does not contain strict rules to follow, but aims to be a collection of suggested practices learned in the years in iCub Tech.

The document targets the **AMCx family** of embedded boards.

-----

**Table of contents**

- [The Techie's guide to code generation in Simulink](#the-techies-guide-to-code-generation-in-simulink)
  - [Setup](#setup)
    - [Requirements](#requirements)
      - [Matlab Toolboxes](#matlab-toolboxes)
      - [Board support packages](#board-support-packages)
    - [Operating System](#operating-system)
    - [Compiler](#compiler)
  - [Understanding model configuration parameters](#understanding-model-configuration-parameters)
    - [Solver](#solver)
    - [Math and Data Types](#math-and-data-types)
    - [Hardware Implementation](#hardware-implementation)
    - [Model Referencing](#model-referencing)
    - [Simulation Target](#simulation-target)
    - [Code Generation](#code-generation)
    - [Optimization](#optimization)
    - [Report](#report)
    - [Custom Code](#custom-code)
    - [Interface](#interface)
      - [Code replacement libraries](#code-replacement-libraries)
  - [Modelling guidelines](#modelling-guidelines)
    - [Simulink models](#simulink-models)
    - [Stateflow charts](#stateflow-charts)
    - [Simscape ???](#simscape-)

-----

## Setup

### Requirements

#### Matlab Toolboxes

The generation of code starts from Matlab and Simulink.
The minimum requirements are the following toolboxes:

- Matlab Coder
- Simulink Coder
- Embedded Coder

The Embedded Coder is special, since it allows to generate production code that can be deployment on the boards, and leverage board support packages/CMSIS.

System Composer is a nice addition, since it allows to create complex architectural models with embedded tests and requirements.

Other toolboxes are needed depending on the software to implement:

- Control System Toolbox, for controllers such as PIDs
- DSP Toolbox for filters

and so on.

#### Board support packages

Board support packages (BSPs) are add-ons that contain features targeted for specific microcontrollers. With them the developer can leverage native uC features, such as ARM instructions (CMSIS), blocks that implement communication protocols and so on.

The AMCx boards have ARM Cortex M processors, which BSP can be found here: [click](https://it.mathworks.com/matlabcentral/fileexchange/43095-embedded-coder-support-package-for-arm-cortex-m-processors).

### Operating System

The operating system (OS) in which Matlab is installed can affect the code generation, depending on the target system.
Since we are targeting a specific microcontroller architecture with proper BSP, we won't be affected.

However, if a developer wants to target a Linux platform, it is not suggested to do so on a Windows host. This is because the Embedded Coder will search for the host OS libraries instead of the target ones by default, when using features like mutexes.

### Compiler

TBD

## Understanding model configuration parameters

The model configuration parameters window contains most settings available to Simulink models.

To open the window, open the Simulink model of your choice, and type Ctrl+E.

This will open:
![](assets/modelparams.png)

Next, we will go through the most relevant parts of the configuration parameters for the AMCx boards.

### Solver

![](assets/modelparams.png)

Solver parameters influence both the code generation and the simulation environment.

**Solver selection**: The solver type must be `Fixed step` with `discrete` method. In this way, generation of code for continuous states can be avoided.

**Solver details > Fixed step size**: The step size can be set to:

- a value that is the least common denominator (LCD) between all the sample times of the application
- `auto` to let Simulink find the LCD step size; note that if the rates are not integer multiples, an `step()` function with the LCD will be generated in the code

**Tasking and sample time options**:

- [x] *Allow tasks to execute concurrently*: this setting is very important, since it allows to generate code with different sampling times, and unlocks the full scheduling capabilities of Simulink through the *Configure Tasks...* button
- [x] *Automatically handle rate transition*: This settings is useful to let simulink insert the proper rate transition block between blocks that run at different rates; the data transfer can be set as always deterministic, if the application can allow significant delays; we use `Never` to minimize delay and insert the rate transition blocks manually

### Math and Data Types

![](assets/par_math.png)

**Data Types > Default for underspecified data type**: `single` because the processor of the AMCx boards does not support double precision. Nonetheless, it is always good practice to specify the smallest possible type for each variable.

### Hardware Implementation

![](assets/par_hw.png)

The *Hardware Implementation* tab is used to set the target architecture and specific BSP.
For our use case, we don't target a specific hardware board.

**Code Generation system target file**: `ert.tlc`, to use the Embedded Coder generation rules.

**Device vendor:** ARM Compatible, since the AMCx boards use ARM processors.

**Device type:** ARM Cortex-M, the type of ARM processor. Note that this setting is available only if the proper BSP for the Embedded Coder is installed.


### Model Referencing

![](assets/par_mod.png)

**Options for referenced models > Rebuild:**: set to *Always* to make sure to rebuild all referenced models at every Simulink compilation step. Useful before deployment. For development and quick iterations, *If changes in known dependencies are detected* can be used.

**Options for referencing this model > Total number of instances allowed per top model**: this setting is useful to constrain model referencing. Set it to *One* if you want to treat the current model as a singleton, or *Multiple* if you want to let this model be used in multiple places.

### Simulation Target

![](assets/par_sim.png)


**Custom code**: in this form you can specify header and source files with functions that can be called in Simulink. Setting them in this section allows running both simulation and code generation without errors.

**Advanced parameters > Compiler optimization level**: this setting is not dedicated to code generation, but setting *Optimizations on* can significantly speed up simulations.

### Code Generation

![](assets/par_code.png)

**Target selection > System target file**: `ert.tlc`, to use the Embedded Coder generation rules.
**Shared coder dictionary**: It could be useful to use a Simulink dictonary to store codegen configurations, though not mandatory.
**Language/Language Standard**: at the moment of writing this document, the language standard used for code generation is C++03, in accordance to the available features of the ARMCLANG compiler.

  - [x] **Generate code only**: ticked to avoid the compilation step by Makefile execution. Compilation occurs in the ARM Keil IDE.

**Build process > Toolchain**: Selecting a specific toolchain allows usage of compiler-specific language features, and compilation parameters. At the time of writing this document, no analyses have been performed so any installed compiler can be used. The Visual Studio compiler and ARMCLANG are usually used during development.

**Build process > Build Configuration**: Set it to *Faster Runs* to select the available optimization options of the selected compiler.

### Optimization

![](assets/par_opt.png)

**Default parameter behavior**: Set it to *Inlined* to allow parameters to be replaced by their respective constant values, so that the compiler will be able to perform optimizations. The *Tunable* setting will add more flexibility of the generated code, sacrificing performance.

**Pass reusable subsystem outputs as**: *Structure reference* to make the code more readable.

- [x] **Data initialization > Remove...**: You can tick both options to remove the zero initialization of both internal variables and IO ports.
  
**Optimization levels > Level**: Maximum to apply all the possible optimizations.
**Optimization levels > Priority**: *Maximize execution speed*.


### Report

![](assets/par_rep.png)

It is very useful to generate a summary report of the code generation process, especially for checking which functions triggered a code replacement.

To do so, tick *Create code generation report*, and *Summarize which block triggered code replacement*.


### Custom Code

![](assets/par_cust.png)

In this section, it is useful to tick the setting *Use the same custom code settings as Simulation Target*.

### Interface

![](assets/par_iface.png)

**Support**:

- [x] floating-point numbers
- [x] absolute time
- [ ] non-finite numbers -> add it if you expect signals to reach `inf`
- [ ] complex numbers
- [ ] variable-size signals

**Code interface > Code interface packaging**:

- *Nonreusable function*
- *Reusable function*
- *C++ class*

#### Code replacement libraries

## Modelling guidelines

### Simulink models

### Stateflow charts

### Simscape ???
