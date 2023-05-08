% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
% select all messages with one or more specific ID(s)
function res = filterByID(T, IDs)
    k = ismember(T.ID, IDs);
    res = T(k, :);
end
