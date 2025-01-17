%% ------------------------------------------------------------------
%  You can modify the values of the fields in AmcfocInitConf
%  and evaluate this cell to create/update this structure
%  in the MATLAB base workspace.
% -------------------------------------------------------------------

%% CONFIGURATION FOR FIRST MOTOR

function initialize_amcfoc_config
AmcfocInitConf(1) = struct;
AmcfocInitConf(1).thresholds = struct;
AmcfocInitConf(1).thresholds.jntVelMax = single(60000);
AmcfocInitConf(1).thresholds.motorNominalCurrents = single(1);
AmcfocInitConf(1).thresholds.motorPeakCurrents = single(2);
AmcfocInitConf(1).thresholds.motorOverloadCurrents = single(3);
AmcfocInitConf(1).thresholds.motorPwmLimit = uint32(32000);
AmcfocInitConf(1).thresholds.motorCriticalTemperature = single(60);
AmcfocInitConf(1).pids = struct;
AmcfocInitConf(1).pids.currentPID = struct;
AmcfocInitConf(1).pids.currentPID.type = ControlModes.Current;
AmcfocInitConf(1).pids.currentPID.OutMax = single(100);
AmcfocInitConf(1).pids.currentPID.OutMin = single(-100);
AmcfocInitConf(1).pids.currentPID.P = single(2);
AmcfocInitConf(1).pids.currentPID.I = single(500);
AmcfocInitConf(1).pids.currentPID.D = single(0);
AmcfocInitConf(1).pids.currentPID.N = single(0);
AmcfocInitConf(1).pids.currentPID.I0 = single(0);
AmcfocInitConf(1).pids.currentPID.D0 = single(0);
AmcfocInitConf(1).pids.currentPID.shift_factor = uint8(0);
AmcfocInitConf(1).pids.velocityPID = struct;
AmcfocInitConf(1).pids.velocityPID.type = ControlModes.Velocity;
AmcfocInitConf(1).pids.velocityPID.OutMax = single(3);
AmcfocInitConf(1).pids.velocityPID.OutMin = single(-3);
AmcfocInitConf(1).pids.velocityPID.P = single(10);
AmcfocInitConf(1).pids.velocityPID.I = single(10);
AmcfocInitConf(1).pids.velocityPID.D = single(0);
AmcfocInitConf(1).pids.velocityPID.N = single(0);
AmcfocInitConf(1).pids.velocityPID.I0 = single(0);
AmcfocInitConf(1).pids.velocityPID.D0 = single(0);
AmcfocInitConf(1).pids.velocityPID.shift_factor = uint8(0);
AmcfocInitConf(1).pids.positionPID = struct;
AmcfocInitConf(1).pids.positionPID.type = ControlModes.Position;
AmcfocInitConf(1).pids.positionPID.OutMax = single(0);
AmcfocInitConf(1).pids.positionPID.OutMin = single(0);
AmcfocInitConf(1).pids.positionPID.P = single(0);
AmcfocInitConf(1).pids.positionPID.I = single(0);
AmcfocInitConf(1).pids.positionPID.D = single(0);
AmcfocInitConf(1).pids.positionPID.N = single(0);
AmcfocInitConf(1).pids.positionPID.I0 = single(0);
AmcfocInitConf(1).pids.positionPID.D0 = single(0);
AmcfocInitConf(1).pids.positionPID.shift_factor = uint8(0);
AmcfocInitConf(1).motor = struct;
AmcfocInitConf(1).motor.externals = struct;
AmcfocInitConf(1).motor.externals.enable_verbosity = false;
AmcfocInitConf(1).motor.externals.has_hall_sens = true;
AmcfocInitConf(1).motor.externals.has_quadrature_encoder = false;
AmcfocInitConf(1).motor.externals.has_speed_quadrature_encoder = false;
AmcfocInitConf(1).motor.externals.has_temperature_sens = false;
AmcfocInitConf(1).motor.externals.encoder_tolerance = uint8(0);
AmcfocInitConf(1).motor.externals.pole_pairs = uint8(7);
AmcfocInitConf(1).motor.externals.rotor_encoder_resolution = int16(0);
AmcfocInitConf(1).motor.externals.rotor_index_offset = int16(0);
AmcfocInitConf(1).motor.externals.use_index = false;
AmcfocInitConf(1).motor.Kbemf = single(3.37);
AmcfocInitConf(1).motor.Rphase = single(25.6);
AmcfocInitConf(1).motor.Imin = single(-3);
AmcfocInitConf(1).motor.Imax = single(3);
AmcfocInitConf(1).motor.Vmax = single(24);
AmcfocInitConf(1).motor.resistance = single(25.6);
AmcfocInitConf(1).motor.inductance = single(1000);
AmcfocInitConf(1).motor.thermal_resistance = single(0);
AmcfocInitConf(1).motor.thermal_time_constant = single(0);
AmcfocInitConf(1).motor.hall_sensors_offset = single(0);

AmcfocInitConf(2) = AmcfocInitConf(1);

update_initial_actuators_config("amcfoc.sldd", "AmcfocInitConf", AmcfocInitConf);
