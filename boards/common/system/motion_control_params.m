%% ------------------------------------------------------------------
%  You can modify the values of the fields in ActuatorInitConfMultiple
%  and evaluate this cell to create/update this structure
%  in the MATLAB base workspace.
% -------------------------------------------------------------------

%% CONFIGURATION FOR FIRST MOTOR

MotionControlInitConf.thresholds = struct;
MotionControlInitConf.thresholds.jntVelMax = single(40000);
MotionControlInitConf.thresholds.motorNominalCurrents = single(0.35);
MotionControlInitConf.thresholds.motorPeakCurrents = single(0.7);
MotionControlInitConf.thresholds.motorOverloadCurrents = single(1);
MotionControlInitConf.thresholds.motorPwmLimit = uint32(0);
MotionControlInitConf.thresholds.motorCriticalTemperature = single(0);
MotionControlInitConf.pids = struct;
MotionControlInitConf.pids.currentPID = struct;
MotionControlInitConf.pids.currentPID.type = ControlModes.Current;
MotionControlInitConf.pids.currentPID.OutMax = single(0);
MotionControlInitConf.pids.currentPID.OutMin = single(0);
MotionControlInitConf.pids.currentPID.P = single(2);
MotionControlInitConf.pids.currentPID.I = single(500);
MotionControlInitConf.pids.currentPID.D = single(0);
MotionControlInitConf.pids.currentPID.N = single(10);
MotionControlInitConf.pids.currentPID.I0 = single(0);
MotionControlInitConf.pids.currentPID.D0 = single(0);
MotionControlInitConf.pids.currentPID.shift_factor = uint8(0);
MotionControlInitConf.pids.velocityPID = struct;
MotionControlInitConf.pids.velocityPID.type = ControlModes.Velocity;
MotionControlInitConf.pids.velocityPID.OutMax = single(0);
MotionControlInitConf.pids.velocityPID.OutMin = single(0);
MotionControlInitConf.pids.velocityPID.P = single(-3e-5);
MotionControlInitConf.pids.velocityPID.I = single(-3e-5);
MotionControlInitConf.pids.velocityPID.D = single(0);
MotionControlInitConf.pids.velocityPID.N = single(10);
MotionControlInitConf.pids.velocityPID.I0 = single(0);
MotionControlInitConf.pids.velocityPID.D0 = single(0);
MotionControlInitConf.pids.velocityPID.shift_factor = uint8(0);
MotionControlInitConf.pids.positionPID = struct;
MotionControlInitConf.pids.positionPID.type = ControlModes.Position;
MotionControlInitConf.pids.positionPID.OutMax = single(0);
MotionControlInitConf.pids.positionPID.OutMin = single(0);
MotionControlInitConf.pids.positionPID.P = single(0);
MotionControlInitConf.pids.positionPID.I = single(0);
MotionControlInitConf.pids.positionPID.D = single(0);
MotionControlInitConf.pids.positionPID.N = single(0);
MotionControlInitConf.pids.positionPID.I0 = single(0);
MotionControlInitConf.pids.positionPID.D0 = single(0);
MotionControlInitConf.pids.positionPID.shift_factor = uint8(0);
MotionControlInitConf.motor = struct;
MotionControlInitConf.motor.has_hall_sens = true;
MotionControlInitConf.motor.has_quadrature_encoder = false;
MotionControlInitConf.motor.has_speed_quadrature_encoder = false;
MotionControlInitConf.motor.has_torque_sens = false;
MotionControlInitConf.motor.use_index = false;
MotionControlInitConf.motor.enable_verbosity = false;
MotionControlInitConf.motor.hall_sensors_offset = single(30);
MotionControlInitConf.motor.rotor_encoder_resolution = int16(0);
MotionControlInitConf.motor.rotor_index_offset = int16(0);
MotionControlInitConf.motor.encoder_tolerance = uint8(0);
MotionControlInitConf.motor.pole_pairs = uint8(7);
MotionControlInitConf.motor.Kbemf = single(0);
MotionControlInitConf.motor.Rphase = single(0);
MotionControlInitConf.motor.Imin = single(0);
MotionControlInitConf.motor.Imax = single(0);
MotionControlInitConf.motor.Vmax = single(24);
MotionControlInitConf.motor.resistance = single(25.9);
MotionControlInitConf.motor.inductance = single(271);
MotionControlInitConf.motor.thermal_resistance = single(16);
MotionControlInitConf.motor.thermal_time_constant = single(797.5);
