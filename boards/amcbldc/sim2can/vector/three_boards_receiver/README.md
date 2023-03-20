Three Boards Recevier
=====================

In this folder you can find the Simulink model to use for reading data coming from three AMCBLDC boards.
The boards are assumed to have CAN ID 1, 2, 3.

**Note:** The PC running this model must be connected to the AMCBLDC through a Vector transceiver, in order to take advantage of the *Vehicle Network toolbox*.

**Requirements**
 - MATLAB and Simulink
 - Vehicle Network Toolbox
 - Simulink Desktop Real-Time

### Running the model with the real-time kernel
Matlab provides the option to run a Simulink model on the desktop with a real-time kernel. 
To do so, you need to install the toolbox `Simulink Desktop Real-time`.

**Instructions**
1. Install the Simulink desktop real-time toolbox
2. If it is the first time you are launching a real-time model, type in the command window `sldrtkernel -setup` and press `y`
3. Open the model `three_boards_receiver.slx`
4. Click on the tab Apps, then on _Simulink Desktop Real-time_
5. Select _Connected IO_ mode on the top left in the tab Desktop Real time

For reference: [Real-Time Execution in Run in Connected IO Mode](https://it.mathworks.com/help/sldrt/ug/simulink-real-time-connected-io-mode.html)
