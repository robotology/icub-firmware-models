% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

function update_motion_control_config

    initial_params_var_name = "InitConfParams";
    dictionary_name = 'amcbldc.sldd';

    % Get reference to design data
    dict = Simulink.data.dictionary.open(dictionary_name);
    dd = getSection(dict, 'Design Data');
    
    % Create a Simulink parameter with the initial configuration
    p = Simulink.Parameter;
    p.DataType = 'Bus: ActuatorConfiguration';
    p.CoderInfo.StorageClass = 'ExportedGlobal';
    p.CoderInfo.Identifier = initial_params_var_name;
    
    % Create the data structure MotionControlInitConf
    % The structure is an array of ActuatorConfiguration
    % The dimension of the array depends on the number of actuators
    motion_control_init_config;
    p.Value = MotionControlInitConf(1);
    
    % Set the parameter in the initial configuration and save the dictionary
    if(~dd.exist(initial_params_var_name))
        disp(initial_params_var_name + " does not exist in dictionary, creating it ...")
        dd.addEntry(initial_params_var_name, p);
    else
        initparams_entry = dd.getEntry(initial_params_var_name);
        initparams_entry.setValue(p);
    end
    saveChanges(dict);
    disp("Initial configuration of " + length(MotionControlInitConf) + ...
        " actuator/s was saved successfully to dictionary " + string(dictionary_name))
end
