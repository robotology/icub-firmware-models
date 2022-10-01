% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
% select all messages between two times (in seconds)
function res = filterByTime(T, time_beginning, time_end)
    k = seconds(T.Time) > time_beginning & seconds(T.Time) < time_end;
    res = T(k,:);
end