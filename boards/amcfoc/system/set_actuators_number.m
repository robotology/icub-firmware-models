% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.

function set_actuators_number
    % This script should be ran only once, after definition of which
    % parameters need to be vectorized

    % Here you need to list the variables that you want to vectorize
    entries_to_modify = [
        "Actuators" 
        "InitConfParams"
        ];

    % Get reference to design data of dictionary
    dict = Simulink.data.dictionary.open("amcfoc.sldd");
    dd = dict.getSection("Design Data");
    
    % find desired number of actuators
    numOfActuators = dd.getEntry("numberOfActuators").getValue;
      
    for i=1:length(entries_to_modify)
    
        % get reference to entry to modify the dimension
        e = dd.getEntry(entries_to_modify(i));

        % get reference to the value of the entry
        simpar = e.getValue;

        if(~isempty(simpar.Value))
            warning("The field 'Value' of " + entries_to_modify(i) + " is not empty.");
            reply = input("Would you like to clear " + entries_to_modify(i) + "? " + ...
                    "Choosing No will skip the entry. [Y/n]", "s");
            
            if(lower(reply) == "n")
                continue;
            else
                simpar.Value = [];
            end
        end

        % modify dimension and write it to referenced parameter
        simpar.Dimensions = [1, numOfActuators];
        e.setValue(simpar);
    
    end
    saveChanges(dict);
    disp("Changes saved to dictionary.");
end