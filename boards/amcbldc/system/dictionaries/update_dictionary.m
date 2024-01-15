% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

% Updates the default configuration parameters within the dictionary
dictionary = Simulink.data.dictionary.open('EmbeddedBoardDD.sldd');
section = getSection(dictionary, 'Design Data');

exportToFile(section, 'export_dictionary.m');
export_dictionary;

id = 'InitConfParams';

p = Simulink.Parameter;
p.DataType = 'Bus: ConfigurationParameters';
p.CoderInfo.StorageClass = 'ExportedGlobal';
p.CoderInfo.Identifier = id;
p.Value = Simulink.Bus.createMATLABStruct('ConfigurationParameters');

p.Value.motorconfig.has_hall_sens = true;
p.Value.motorconfig.hall_sens_offset = single(30);
p.Value.motorconfig.has_quadrature_encoder = true;
p.Value.motorconfig.has_speed_quadrature_encoder = false;
p.Value.motorconfig.has_torque_sens = false;
p.Value.motorconfig.use_index = true;
p.Value.motorconfig.enable_verbosity = false;
p.Value.motorconfig.rotor_encoder_resolution = int16(16000);
p.Value.motorconfig.rotor_index_offset = int16(0);
p.Value.motorconfig.encoder_tolerance = uint8(0);
p.Value.motorconfig.pole_pairs = uint8(7);
p.Value.motorconfig.Vmax = single(24);
p.Value.motorconfig.resistance = single(25.9);
p.Value.motorconfig.inductance = single(271);
p.Value.motorconfig.thermal_resistance = single(16);
p.Value.motorconfig.thermal_time_constant = single(797.5);
p.Value.CurLoopPID.P = single(2);
p.Value.CurLoopPID.I = single(500);
p.Value.CurLoopPID.D = single(0);
p.Value.CurLoopPID.N = single(10);
p.Value.CurLoopPID.shift_factor = uint8(0);
p.Value.VelLoopPID.P = single(-3e-5);
p.Value.VelLoopPID.I = single(-3e-5);
p.Value.VelLoopPID.D = single(0);
p.Value.VelLoopPID.N = single(10);
p.Value.VelLoopPID.shift_factor = uint8(0);
p.Value.estimationconfig.velocity_mode = EstimationVelocityModes.MovingAverage;
p.Value.estimationconfig.current_rms_lambda = single(0.9995);
p.Value.thresholds.jntPosMin = single(1);
p.Value.thresholds.jntPosMax = single(359);
p.Value.thresholds.hardwareJntPosMin = single(0);
p.Value.thresholds.hardwareJntPosMax = single(360);
p.Value.thresholds.rotorPosMin = single(0);
p.Value.thresholds.rotorPosMax = single(0);
p.Value.thresholds.jntVelMax = single(40000);
p.Value.thresholds.velocityTimeout = uint32(10);
p.Value.thresholds.motorNominalCurrents = single(2);
p.Value.thresholds.motorPeakCurrents = single(5);
p.Value.thresholds.motorOverloadCurrents = single(10);
p.Value.thresholds.motorPwmLimit = uint32(32000);
p.Value.thresholds.motorCriticalTemperature = single(70);
p.Value.environment_temperature = single(25);

update_entry(section, id, p);

saveChanges(dictionary);
close(dictionary);

clear;
delete('export_dictionary.m');


function update_entry(section, name, val)

    entry = find(section, 'Name', name);
    if isempty(entry)
        addEntry(section, name, val);
    else
        setValue(entry, val);
    end

end
