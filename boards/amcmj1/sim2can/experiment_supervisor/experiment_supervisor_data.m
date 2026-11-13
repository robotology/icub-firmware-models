%% Model initialisation data

% The following matrix defines the duration in seconds of the stepwise
% inputs and their amplitudes in mA
current_target_timetable = [2,   5,   5,   5,   5,   5,  2, 0; ...
                            0, 250, 400, 0, -250, -400, 0, 0];

% Used during FOC output strategy experiments
% current_target_timetable = [3, 5, 0, 0, 0, 0, 0, 0; ...
%                            0, -550, 0, 0, 0, 0, 0, 0];
