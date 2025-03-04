% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

function update_initial_actuators_config(dictionary, init_conf_dictionary_name, init_conf_data)

    % Get reference to design data
    dict = Simulink.data.dictionary.open(dictionary);
    dd = getSection(dict, 'Design Data');

    numOfActuators = 1;

    % find desired number of actuators
    if(exist(dd,'numberOfActuators'))
        numOfActuators = dd.getEntry('numberOfActuators').getValue;
    else
        disp("numberOfActuators was not found in the dictionary '" + ...
            dictionary + "', setting it to 1")
    end

    % Create a Simulink parameter with the initial configuration
    p = Simulink.Parameter;
    p.DataType = 'Bus: ActuatorConfiguration';
    p.CoderInfo.StorageClass = 'ExportedGlobal';
    p.CoderInfo.Identifier = init_conf_dictionary_name;
    
    % Create the data structure ActuatorInitConfMultiple
    % The structure is an array of ActuatorConfiguration
    % The dimension of the array depends on the number of actuators
    if(length(init_conf_data) ~= numOfActuators)
        throw("numberOfActuators does not match the size of " + ...
            init_conf_data)
    end

    % Set the parameter in the initial configuration and save the dictionary
    p.Value = init_conf_data;

    if(~dd.exist(init_conf_dictionary_name))
        disp(init_conf_dictionary_name + " does not exist, creating it ...")
        dd.addEntry(init_conf_dictionary_name, p);
    else
        initparams_entry = dd.getEntry(init_conf_dictionary_name);
        initparams_entry.setValue(p);
    end
    saveChanges(dict);
    disp("Initial configuration of " + numOfActuators + " actuator(s) called " + ...
        init_conf_dictionary_name + " was saved successfully to dictionary")
end

