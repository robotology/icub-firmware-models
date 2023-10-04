
% This script should be ran only once, after definition of which
% parameters need to be vectorized

% Get reference to design data of dictionary
dict = Simulink.data.dictionary.open("dictionaries/amcfoc.sldd");
dd = dict.getSection("Design Data");

% find desired number of actuators
numOfActuators = dd.getEntry("numberOfActuators").getValue;

entries_to_modify = ["Actuators", "InitConfParams"];

for i=1:length(entries_to_modify)

    % get reference to entry to modify the dimension
    e = dd.getEntry(entries_to_modify(i));
    % modify dimension and write it to referenced parameter
    simpar = e.getValue;
    simpar.Dimensions = [1, numOfActuators];
    e.setValue(simpar);

end
dict.saveChanges;