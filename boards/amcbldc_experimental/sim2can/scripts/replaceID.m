% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function res = replaceID(T, original_ID, new_ID)
    for i=1:length(T.Data)
        if T.ID(i,:) == original_ID
            T.ID(i,:) = new_ID;
        end
    end
    res = T;
end