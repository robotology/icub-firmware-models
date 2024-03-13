%% ------------------------------------------------------------------
%  You can modify the values of the fields in ActuatorInitConfMultiple
%  and evaluate this cell to create/update this structure
%  in the MATLAB base workspace.
% -------------------------------------------------------------------

%% CONFIGURATION FOR FIRST MOTOR

MotionControlInitConf(1).thresholds = struct;
MotionControlInitConf(1).thresholds.jntVelMax = single(40000);
MotionControlInitConf(1).thresholds.motorNominalCurrents = single(0.35);
MotionControlInitConf(1).thresholds.motorPeakCurrents = single(0.7);
MotionControlInitConf(1).thresholds.motorOverloadCurrents = single(1);
MotionControlInitConf(1).thresholds.motorPwmLimit = uint32(32000);
MotionControlInitConf(1).thresholds.motorCriticalTemperature = single(0);
MotionControlInitConf(1).pids = struct;
MotionControlInitConf(1).pids.currentPID = struct;
MotionControlInitConf(1).pids.currentPID.type = ControlModes.Current;
MotionControlInitConf(1).pids.currentPID.OutMax = single(0);
MotionControlInitConf(1).pids.currentPID.OutMin = single(0);
MotionControlInitConf(1).pids.currentPID.P = single(2);
MotionControlInitConf(1).pids.currentPID.I = single(500);
MotionControlInitConf(1).pids.currentPID.D = single(0);
MotionControlInitConf(1).pids.currentPID.N = single(10);
MotionControlInitConf(1).pids.currentPID.I0 = single(0);
MotionControlInitConf(1).pids.currentPID.D0 = single(0);
MotionControlInitConf(1).pids.currentPID.shift_factor = uint8(0);
MotionControlInitConf(1).pids.velocityPID = struct;
MotionControlInitConf(1).pids.velocityPID.type = ControlModes.Velocity;
MotionControlInitConf(1).pids.velocityPID.OutMax = single(0);
MotionControlInitConf(1).pids.velocityPID.OutMin = single(0);
MotionControlInitConf(1).pids.velocityPID.P = single(-3e-5);
MotionControlInitConf(1).pids.velocityPID.I = single(-3e-5);
MotionControlInitConf(1).pids.velocityPID.D = single(0);
MotionControlInitConf(1).pids.velocityPID.N = single(10);
MotionControlInitConf(1).pids.velocityPID.I0 = single(0);
MotionControlInitConf(1).pids.velocityPID.D0 = single(0);
MotionControlInitConf(1).pids.velocityPID.shift_factor = uint8(0);
MotionControlInitConf(1).pids.positionPID = struct;
MotionControlInitConf(1).pids.positionPID.type = ControlModes.Position;
MotionControlInitConf(1).pids.positionPID.OutMax = single(0);
MotionControlInitConf(1).pids.positionPID.OutMin = single(0);
MotionControlInitConf(1).pids.positionPID.P = single(0);
MotionControlInitConf(1).pids.positionPID.I = single(0);
MotionControlInitConf(1).pids.positionPID.D = single(0);
MotionControlInitConf(1).pids.positionPID.N = single(0);
MotionControlInitConf(1).pids.positionPID.I0 = single(0);
MotionControlInitConf(1).pids.positionPID.D0 = single(0);
MotionControlInitConf(1).pids.positionPID.shift_factor = uint8(0);
MotionControlInitConf(1).motor = struct;
MotionControlInitConf(1).motor.externals = struct;
MotionControlInitConf(1).motor.externals.enable_verbosity = false;
MotionControlInitConf(1).motor.externals.has_hall_sens = true;
MotionControlInitConf(1).motor.externals.has_quadrature_encoder = false;
MotionControlInitConf(1).motor.externals.has_speed_quadrature_encoder = false;
MotionControlInitConf(1).motor.externals.has_torque_sens = false;
MotionControlInitConf(1).motor.externals.encoder_tolerance = uint8(0);
MotionControlInitConf(1).motor.externals.pole_pairs = uint8(7);
MotionControlInitConf(1).motor.externals.rotor_encoder_resolution = int16(16000);
MotionControlInitConf(1).motor.externals.rotor_index_offset = int16(0);
MotionControlInitConf(1).motor.externals.use_index = false;
MotionControlInitConf(1).motor.Kbemf = single(0);
MotionControlInitConf(1).motor.Rphase = single(0);
MotionControlInitConf(1).motor.Imin = single(0);
MotionControlInitConf(1).motor.Imax = single(0);
MotionControlInitConf(1).motor.Vmax = single(24);
MotionControlInitConf(1).motor.resistance = single(25.9);
MotionControlInitConf(1).motor.inductance = single(271);
MotionControlInitConf(1).motor.thermal_resistance = single(16);
MotionControlInitConf(1).motor.thermal_time_constant = single(797.5);
MotionControlInitConf(1).motor.hall_sensors_offset = single(30);
