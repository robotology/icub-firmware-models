% Copyright (C) 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function res = filterByByte(T, byte_number, value)
% select all messages with a specific value in a specific byte
    indices = [];
    k = 1;
    for i=1:length(T.Data)
        p = T.Data{i};
        size = T.Length(i);
        % if the row is empty, then skip
        if isempty(p) || size < byte_number
            continue
        end
        % if the payload meets the requirement, then collect it
        if p(byte_number) == value
            indices(k) = i;
            k = k + 1;
        end
    end
    res = T(indices, :);
end
