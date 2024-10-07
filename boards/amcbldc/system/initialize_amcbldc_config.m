%% ------------------------------------------------------------------
%  You can modify the values of the fields in ActuatorInitConfMultiple
%  and evaluate this cell to create/update this structure
%  in the MATLAB base workspace.
% -------------------------------------------------------------------

%% CONFIGURATION FOR FIRST MOTOR
function initialize_amcbldc_config
AmcbldcInitConf(1).thresholds = struct;
AmcbldcInitConf(1).thresholds.jntVelMax = single(40000);
AmcbldcInitConf(1).thresholds.motorNominalCurrents = single(0.35);
AmcbldcInitConf(1).thresholds.motorPeakCurrents = single(0.7);
AmcbldcInitConf(1).thresholds.motorOverloadCurrents = single(1);
AmcbldcInitConf(1).thresholds.motorPwmLimit = uint32(32000);
AmcbldcInitConf(1).thresholds.motorCriticalTemperature = single(0);
AmcbldcInitConf(1).pids = struct;
AmcbldcInitConf(1).pids.currentPID = struct;
AmcbldcInitConf(1).pids.currentPID.type = ControlModes.Current;
AmcbldcInitConf(1).pids.currentPID.OutMax = single(0);
AmcbldcInitConf(1).pids.currentPID.OutMin = single(0);
AmcbldcInitConf(1).pids.currentPID.P = single(2);
AmcbldcInitConf(1).pids.currentPID.I = single(500);
AmcbldcInitConf(1).pids.currentPID.D = single(0);
AmcbldcInitConf(1).pids.currentPID.N = single(10);
AmcbldcInitConf(1).pids.currentPID.I0 = single(0);
AmcbldcInitConf(1).pids.currentPID.D0 = single(0);
AmcbldcInitConf(1).pids.currentPID.shift_factor = uint8(0);
AmcbldcInitConf(1).pids.velocityPID = struct;
AmcbldcInitConf(1).pids.velocityPID.type = ControlModes.Velocity;
AmcbldcInitConf(1).pids.velocityPID.OutMax = single(0);
AmcbldcInitConf(1).pids.velocityPID.OutMin = single(0);
AmcbldcInitConf(1).pids.velocityPID.P = single(-20);
AmcbldcInitConf(1).pids.velocityPID.I = single(-20);
AmcbldcInitConf(1).pids.velocityPID.D = single(0);
AmcbldcInitConf(1).pids.velocityPID.N = single(100);
AmcbldcInitConf(1).pids.velocityPID.I0 = single(0);
AmcbldcInitConf(1).pids.velocityPID.D0 = single(0);
AmcbldcInitConf(1).pids.velocityPID.shift_factor = uint8(10);
AmcbldcInitConf(1).pids.positionPID = struct;
AmcbldcInitConf(1).pids.positionPID.type = ControlModes.Position;
AmcbldcInitConf(1).pids.positionPID.OutMax = single(0);
AmcbldcInitConf(1).pids.positionPID.OutMin = single(0);
AmcbldcInitConf(1).pids.positionPID.P = single(0);
AmcbldcInitConf(1).pids.positionPID.I = single(0);
AmcbldcInitConf(1).pids.positionPID.D = single(0);
AmcbldcInitConf(1).pids.positionPID.N = single(0);
AmcbldcInitConf(1).pids.positionPID.I0 = single(0);
AmcbldcInitConf(1).pids.positionPID.D0 = single(0);
AmcbldcInitConf(1).pids.positionPID.shift_factor = uint8(0);
AmcbldcInitConf(1).motor = struct;
AmcbldcInitConf(1).motor.externals = struct;
AmcbldcInitConf(1).motor.externals.enable_verbosity = false;
AmcbldcInitConf(1).motor.externals.has_hall_sens = true;
AmcbldcInitConf(1).motor.externals.has_quadrature_encoder = false;
AmcbldcInitConf(1).motor.externals.has_speed_quadrature_encoder = false;
AmcbldcInitConf(1).motor.externals.has_temperature_sens = false;
AmcbldcInitConf(1).motor.externals.encoder_tolerance = uint8(0);
AmcbldcInitConf(1).motor.externals.pole_pairs = uint8(7);
AmcbldcInitConf(1).motor.externals.rotor_encoder_resolution = int16(0);
AmcbldcInitConf(1).motor.externals.rotor_index_offset = int16(0);
AmcbldcInitConf(1).motor.externals.use_index = false;
AmcbldcInitConf(1).motor.Kbemf = single(0);
AmcbldcInitConf(1).motor.Rphase = single(0);
AmcbldcInitConf(1).motor.Imin = single(0);
AmcbldcInitConf(1).motor.Imax = single(0);
AmcbldcInitConf(1).motor.Vmax = single(24);
AmcbldcInitConf(1).motor.resistance = single(25.9);
AmcbldcInitConf(1).motor.inductance = single(271);
AmcbldcInitConf(1).motor.thermal_resistance = single(16);
AmcbldcInitConf(1).motor.thermal_time_constant = single(797.5);
AmcbldcInitConf(1).motor.hall_sensors_offset = single(30);

update_initial_actuators_config("amcbldc.sldd", "AmcbldcInitConf", AmcbldcInitConf);
