% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function res = removeUnnecessaryVariables(T)
    res = removevars(T, {'Extended','Name','Signals','Error','Remote'});
end