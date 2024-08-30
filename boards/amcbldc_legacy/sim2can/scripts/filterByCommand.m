% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function res = filterByCommand(T, command)
    res = filterByByte(T, 1, command);
end