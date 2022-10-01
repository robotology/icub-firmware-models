Experiment Supervisor
=====================

In this folder you can find the Simulink model to use for sending different current targets to AMCBLDC.
The model can be used to send current targets to a AMC_BLDC board and receive the corresponding measured value. 
An interactive interface is provided to set the current reference and start the transmission.

**Note:** The PC running this model must be connected to the AMCBLDC through a Vector transceiver, in order to take advantage of the *Vehicle Network toolbox*.

**Requirements**
 - MATLAB and Simulink
 - Vehicle Network Toolbox
 - Simulink Desktop Real-Time

**Usage**
The file `experiment_supervisor_data.m` contains the timetable used to send the current setpoints.
Open the model `experiment_supervisor.slx` and verify that all the blocks related to CAN configuration are using the `Vector VN1610` setting.
Then:
1. Run the model `experiment_supervisor_user.slx` by clicking on the `Run` button on the Simulink interface
2. Start the communication by clicking on the `Start` button
3. Stop the communication by clicking on the `Idle` or `Reset` buttons

Upon starting, the model will first set the appropriate control mode (called "Current") and the current limits. Then, the setpoint will be sent to the board if it is within the limits. 
The measured current value is then plotted in Simulink's Data Inspector.

### Running the model with the real-time kernel
Matlab provides the option to run a Simulink model on the desktop with a real-time kernel. 
To do so, you need to install the toolbox `Simulink Desktop Real-time`.

**Instructions**
1. Install the Simulink desktop real-time toolbox
2. If it is the first time you are launching a real-time model, type in the command window `sldrtkernel -setup` and press `y`
3. Open the model `experiment_supervisor_user.slx`
4. Click on the tab Apps, then on _Simulink Desktop Real-time_
5. Select _Connected IO_ mode on the top left in the tab Desktop Real time

For reference: [Real-Time Execution in Run in Connected IO Mode](https://it.mathworks.com/help/sldrt/ug/simulink-real-time-connected-io-mode.html)
