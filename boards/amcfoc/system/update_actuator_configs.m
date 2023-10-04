% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

% Get reference to design data
dict = Simulink.data.dictionary.open('amcfoc.sldd');
dd = getSection(dict, 'Design Data');

% Create a Simulink parameter with the initial configuration
p = Simulink.Parameter;
p.DataType = 'Bus: ActuatorConfiguration';
p.CoderInfo.StorageClass = 'ExportedGlobal';
p.CoderInfo.Identifier = "InitConfParams";

% Create the data structure ActuatorInitConfMultiple
% The structure is an array of ActuatorConfiguration
% The dimension of the array depends on the number of actuators
create_actuators_initial_conf;
p.Value = ActuatorInitConfMultiple;

% Set the parameter in the initial configuration and save the dictionary
initparams_entry = dd.getEntry("InitConfParams");
initparams_entry.setValue(p);
saveChanges(dict);

% clean up data
clear initparams_entry dict dd p ActuatorInitConfMultiple;