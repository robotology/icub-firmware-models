% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function result_timetable = unpackTimetablePayload(can_timetable,can_payload_length)

    result_timetable = can_timetable;

    % preallocate
    datamatrix = zeros(height(result_timetable), can_payload_length);

    for i=1:height(result_timetable)
        payload = double(result_timetable(i,"Data").Data{1});
        datamatrix(i, :) = [payload, nan(1, can_payload_length - length(payload))];
    end

    for i=1:can_payload_length
        result_timetable = addvars(result_timetable, datamatrix(:,i), 'NewVariableNames', 'd'+string(i));
    end
end

