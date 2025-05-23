Wrist Mk2.1
=========

![joint](assets/Joint.png)

# The Mathematics of the spherical joint
To find out more about the underlying equations, please visit our [official documentation](https://icub-tech-iit.github.io/documentation/wrists/wrist_mk2/).

# Embedded firmware generation
The coupling/decoupling subsystem is already configured for embedded software generation. 

![decoupler](assets/Decoupler.png)

Its internal structure, reflecting the direct/inverse geometric problems data flow, is:

![internal](assets/Internal.png)

Now the geometry of the wrist is provided to the `wrist_decoupler` as input, so that it is now configurable at runtime without re-generating the source code:

![configuration](assets/Config.png) 

The source code is generated by right clicking on the `wrist_decoupler` subsystem, and choosing `C/C++ Code > Build This Subsystem`, in this way:

![code generation](assets/Generation.png)

Once this is done, the .h and .cpp files contained in the WristDecoupler.zip generated in the main folder must be properly placed into the board firmware project. For example, with the EMS board:

![project](assets/Project.png)

that corresponds to the folder `icub-firmware/emBODY/eBcode/arch-arm/embobj/plus/mc`

![folder](assets/Folder.png)

# March 2025 - Update

The Wrist Mk2.1 model needed an update due to the following differences with the current implementation.

<img src="https://github.com/user-attachments/assets/4887bead-7c68-41d5-918d-5daa5f8f57fb" width="500">

The model was then updated together with some measures to eliminate certain warnings concerning the occurrence of instances of unbreakable algebraic loops.

<img src="https://github.com/user-attachments/assets/66903ac7-0274-47d1-ad32-fbed6a6b3057" width="500">

