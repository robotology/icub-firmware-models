% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%
% Author: Simone Girardi <simone.girardi@iit.it>
final_table = removeUnnecessaryVariables(canExplorerMsgs);

final_table.ID = dec2hex(final_table.ID);
final_table = filterByTime(final_table, 6, 7);
final_table_board_1 = filterByID(final_table, "001");
final_table_board_2 = filterByID(final_table, "002");
final_table_board_3 = filterByID(final_table, "003");

% make the final tables more readable
final_table_board_1 = replaceID(final_table_board_1, '110', "FOC");
final_table_board_1 = replaceID(final_table_board_1, '113', "STA");
final_table_board_1 = replaceID(final_table_board_1, '001', "EMS");
final_table_board_1 = replaceID(final_table_board_1, '10F', "TGT");
final_table_board_2 = replaceID(final_table_board_2, '120', "FOC");
final_table_board_2 = replaceID(final_table_board_2, '123', "STA");
final_table_board_2 = replaceID(final_table_board_2, '002', "EMS");
final_table_board_3 = replaceID(final_table_board_3, '130', "FOC");
final_table_board_3 = replaceID(final_table_board_3, '133', "STA");
final_table_board_3 = replaceID(final_table_board_3, '003', "EMS");

%% Unpack payloads

unique_ids = unique(final_table.ID);
unique_ids_hex = dec2hex(unique(final_table.ID));

% timetables_collection is a cell array whose length equals the number of unique messages;
% each element of the cell array is a timetable of each CAN message with
% that specific CAN ID, with payload separated by columns for each byte
timetables_collection = cell(length(unique_ids), 1);

% get only payload
for i=1:length(unique_ids_hex)
    timetables_collection{i} = final_table(final_table.ID == unique_ids(i), :);
    timetables_collection{i} = timetables_collection{i}(:, 4);
end

% create timetable for each ID, pad payload with NaN if smaller than 8
% bytes
for k=1:length(timetables_collection)
    disp(unique_ids_hex(k, :))
    timetables_collection{k} = unpack_timetable_payload(timetables_collection{k}, 8);
end

%% Plot payloads

tiledlayout(10, 1, 'tilespacing', 'tight')
for i=1:length(unique_ids)
    h(i) = nexttile;
    if i>=1 && i<=3
        plot(timetables_collection{i}.Time, timetables_collection{i}.d2, 'o-', 'LineWidth', 1.3, 'MarkerSize', 7); 
        grid minor
        ylim([0, max(timetables_collection{i}.d2) * 1.2]);
    else
        stairs(timetables_collection{i}.Time, timetables_collection{i}.d1, '.', 'LineWidth', 1.3); 
        grid minor
        ylim([0, max(timetables_collection{i}.d1) * 1.2]);
    end
end

linkaxes(h, 'x');