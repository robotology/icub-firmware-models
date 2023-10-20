% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

function update_actuators_config

    % Get reference to design data
    dict = Simulink.data.dictionary.open('amcfoc.sldd');
    dd = getSection(dict, 'Design Data');

     % find desired number of actuators
    numOfActuators = dd.getEntry("numberOfActuators").getValue;
    
    % Create a Simulink parameter with the initial configuration
    p = Simulink.Parameter;
    p.DataType = 'Bus: ActuatorConfiguration';
    p.CoderInfo.StorageClass = 'ExportedGlobal';
    p.CoderInfo.Identifier = "InitConfParams";
    
    % Create the data structure ActuatorInitConfMultiple
    % The structure is an array of ActuatorConfiguration
    % The dimension of the array depends on the number of actuators
    configure_actuators;
    p.Value = ActuatorInitConfMultiple(1:numOfActuators);
    
    % Set the parameter in the initial configuration and save the dictionary
    initparams_entry = dd.getEntry("InitConfParams");
    initparams_entry.setValue(p);
    saveChanges(dict);
    disp("Initial configuration of " + numOfActuators + " actuators was saved successfully to dictionary")
end
