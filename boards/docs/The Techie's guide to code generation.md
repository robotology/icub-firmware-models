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
    - [Additional sections](#additional-sections)
      - [Code style](#code-style)
      - [Verification](#verification)
      - [Templates](#templates)
      - [Code placement](#code-placement)
      - [Data type replacement](#data-type-replacement)
  - [Modelling tips and suggestions](#modelling-tips-and-suggestions)
    - [Dictionaries and architectural data](#dictionaries-and-architectural-data)
    - [Simulink models](#simulink-models)
    - [System Composer](#system-composer)

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
- [ ] non-finite numbers -> check it if you expect signals to reach `inf`
- [ ] complex numbers
- [ ] variable-size signals -> check this if you need to dynamically allocate memory

**Code interface > Code interface packaging**:

The choice between these option is highly dependent on the desired code usage. Of course, *C++ class* will be available only if the target language is C++.

- *Nonreusable function* : generates code which entry point functions directly access the data structure; this option is suggested for top-level architectural models
- *Reusable function* : generates re-entrant multi-instance code; this option is needed for Simulink models that need to be referenced, especially if they need to be wrapped in special blocks (e.g. a For Each Subsystem)
- *C++ class* : generates a class with constructor, destructor, inputs setter and outputs getter

#### Code replacement libraries

Code replacement libraries (CRL) are sets of functions that can be used to replace native C/C++ operations, to leverage the target hardware or respect specific requirements.

When clicking on the Select button, the following window will pop up.

![](assets/par_crl.png)

On the left the available but unused libraries are listed, while on the right we can see the ones selected for usage, with decreasing priority order.

If the BSP for the Cortex-M was installed, it will appear here as available. Its CRL includes functions such as the trigonometric ones, squared root, even clark-parke transforms.

It is possible to define a custom CRL, such as the iCubTech one. The iCubTech library replaces native mutex calls with custom functions that trigger interrupts. More information on how to create a custom library can be found in the [Matlab documentation](https://it.mathworks.com/help/ecoder/ug/quick-start-library-development-sc.html).

### Additional sections

These sections contain settings which are not critical for code generation at the moment of writing this document. Nonetheless, they might be useful to fine-tune the final product in accordance to the style and rules of the existing codebase.

#### Code style

In this section, you can customize the style of the generated code. You can tune the amount of parenthesis level, the usage of std::array instead of Matlab Coder's array, and the readability of the code.

#### Verification

In this section you can leverage the code verification tools to check the tasks' execution times, enable SIL/PIL simulations, and enable code coverage analysis.

#### Templates

The *Templates* section allows to choose and custimize the template files used for code generation. You can also enable the creation of an example main file.

#### Code placement

In this section you can define where the custom storage classes should be placed, how it should be packaged and the naming rules.

#### Data type replacement

In here you can control the base data types used in the whole code generation process. 

Selecting data types as *coder typedefs* will generate types that conform to the C89 standard, while *C data types* will generate types according to the C99 standard.

## Modelling tips and suggestions

This chapter illustrates simple tips and advices to translate the typical coding patterns into effective Simulink components.

### Dictionaries and architectural data

The dictionary is a very useful feature Simulink. At its core, it's a file that contains parameters, types, bus definitions and model configurations. It can be linked to simulink models so they share  the above information, especially when referenced by a parent.

See for example the screenshot below: the model `motion_controller` uses the dictionary `embeddedboard_common.sldd` to reference design data, architectural data and configurations.

![](assets/dict_model_expl.png)

In the *Architectural data editor* window, you can define new interfaces, that will map as struct types in the code. Interfaces are called **Buses**, and can contain elements (variables) or other buses. 

It's always good practice to properly define and comment all elements in all their features, especially the unit of measurement. See an example below, in which the DC voltage supply measurement is an element of `SensorData > DriverSensors`:

![](assets/dict_arch_data_editor.png)

The archictectural data editor also shows tabs regarding enums and constants. Depending on your project, it is useful to define them here so they can be shared between models. Usually, it's good practice to define the sampling times of the tasks in the *Constants* tab.

### Simulink models

When designing Simulink models to translate an idea into an algorithm, we always have to keep in mind that the data flows sequentially from one block to another. It might be difficult to apply this way of thinking to our pre-existing programming habits, so this section will try to help with this transition.

Here are some basic suggestions:

- Just as with Matlab, Simulink is very powerful when it deals with matrix calculus, signal processing and feedback control: if you want to implement a control system for a robot part, a filter for a discrete signal, a motor simulator, you can rely on Simulink for effective and comprehensive results; do not be afraid to use it

- check if you desired algorithm is already implemented in an existing toolbox: chances are that the Simulink implementation is already slick and robust enough to be production ready, and can be integrated safely; just be careful with the license availability

- Decision logic can become janky very quickly: keep the usage of *If* and *If action subsystems* to a minimum, since they require "verbosity" and can complicate reading the system, see for example:

![](assets/sim_if.png)

for more compactness and maintainability, prefer Stateflow charts and properly assign the execution order:

![](assets/sim_if_chart.png)

- Use iteration blocks like *do-while* and *for-each* sparingly: they can be very useful when it is necessary to wrap complex logic and repeat the operations for each input element (e.g. multiple motion controller instances); in fact, most computational blocks support matrix operations, and can apply the operations to each input element automatically; just be careful about the dimension along which the operation is performed, or you might end up with unexpected results (see fro example the documentation on [Known for-each subsystem limitations](https://it.mathworks.com/help/simulink/ug/repeat-an-algorithm-using-a-for-each-subsystem.html#mw_76ab6d1d-3ef6-4c2e-9438-e226c070ddc0))

![](assets/sim_for.png)

- If you want to store a state within a Simulink model, you can you do so through *Data Store* blocks, pairing the *Read* with the *Write* and the *Memory*

![](assets/sim_data_store.png)

for more complex state management, consider using Stateflow charts. Note that states are created automatically depending on the structure of the model, especially if Delay blocks are involved.

### Stateflow

Stateflow is a toolbox that, in a way, breaks the conventional usage of Simulink, by introducting Finite State Machines (FSM). With it, you can develop complex logic controllers and handle the internal state of your system. 

![](assets/sim_fsm.png)

While the syntax can be daunting at first, a chart can be set up to use C language syntax instead of the Matlab one. That way, writing complex bitshift logic (for example) becomes much more manageable.

A Stateflow chart can also be used to schedule the call of function-enabled subsystems, by using events.

## System Composer

The Matlab System Composer is a toolbox that allows the creation of so-called *Architectural models* to support Model-Based System Engineering (MBSE) workflows. Within them, you can design Simulink models that embed project requirements, sequence diagrams, and so on.

The two main categories of architectures are:

- Architectural models
- Software architectural models

### Architectural models

Architectural models can be used to design physical, logical, and functional aspects of a physical system.

Usually, the physical architecture represents how each physical component is connected to the others, the functional architecture represents how the behaviours of the system interact with each other, and the physical architecture highlights the physical components involved.

See for example the physical architecture below. The controller is the model of which the code is generated

![](assets/arch.png)

The procedure for generating the code of an architectural model is the same as classic Simulink models. Therefore, converting the latter to the former does not change the structure of the generated code. Be careful though, not to add the simulated physics into the generated code!

Software architectures, instead, allow for additional features, such as client-server patterns (services), and initialization scheduling. See for example the picture below. Here, the `Logic` block uses service interfaces to call the execution of `ProcessSensors` and `Planner`, which therefore run asynchronously.

 ![](assets/arch_sw.png)

Be careful that software architectures don't automatically add data protection mechanisms (e.g. mutexes).
