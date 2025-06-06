% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function result_timetable = unpackTimetablePayload(can_timetable,can_payload_length, id_in_hex)

    arguments
        can_timetable timetable
        can_payload_length {mustBeBetween(can_payload_length, 0, 8)} = 8
        id_in_hex (1,1) = true
    end

    result_timetable = can_timetable;

    % preallocate matrix of payloads
    datamatrix = zeros(height(result_timetable), can_payload_length);

    for i=1:height(result_timetable)
        payload = double(result_timetable(i,"Data").Data{1});

        % Fill nonexistent bytes with nan
        datamatrix(i, :) = [payload, nan(1, can_payload_length - length(payload))];
    end

    for i=1:can_payload_length
        result_timetable = addvars(result_timetable, datamatrix(:,i), 'NewVariableNames', 'd'+string(i));
    end

    if(id_in_hex)
        result_timetable.ID = dec2hex(result_timetable.ID);
    end
end

