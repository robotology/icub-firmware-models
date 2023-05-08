% Copyright (C) 2023 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%

close all

training_measurements = "4.xlsx";
training_input = "n4.mat";
training_start_time_offset = 827;

validation_measurements = "1.xlsx";
validation_input = "n1.mat";
validation_start_time_offset = 1;

[idd_training] = create_iddata(training_measurements, training_input, training_start_time_offset);
[idd_validation] = create_iddata(validation_measurements, validation_input, validation_start_time_offset);
idd_training.Name = "training";
idd_validation.Name = "validation";
figure
tiledlayout(2,2, "TileSpacing","tight","TileIndexing","columnmajor")
h1 = nexttile;
plot(idd_training.InputData, "LineWidth", 1.5)
ylabel("Training input (W)")
h2 = nexttile;
plot(idd_training.OutputData)
ylabel("Training Output (C)")
linkaxes([h1 h2], 'x')
h1 = nexttile;
plot(idd_validation.InputData, "LineWidth", 1.5)
ylabel("Validation input (W)")
h2 = nexttile;
plot(idd_validation.OutputData)
ylabel("Validation Output (C)")
linkaxes([h1 h2], 'x')

%% Run estimation: continuous LTI model with 1 pole

opt = procestOptions;
opt.InitialCondition =  "zero";
model = procest(idd_training, "P1", opt);

%% Plot result

figure
subplot(2,1,1)
timevec = 0:0.1:((length(idd_training.InputData)-1)/10);
[y_out, time] = lsim(model, idd_training.InputData, timevec);
plot(time, y_out, "LineWidth", 1.5)
hold on
plot(timevec, idd_training.OutputData, "LineWidth", 1.5);
ylabel("\Delta T (C)")
legend({"model", "camera"})
title("Training data")
h1 = gca;

subplot(2,1,2)
timevec = 0:0.1:((length(idd_validation.InputData)-1)/10);
[y_out, time] = lsim(model, idd_validation.InputData(1:end), timevec(1:end));
plot(time, y_out, "LineWidth", 1.5)
ylabel("\Delta T (C)")
xlabel("Time (sec)")
hold on
plot(timevec(1:end), idd_validation.OutputData(1:end), "LineWidth", 1.5);
title("Validation data")
h2 = gca;

linkaxes([h1, h2], 'x')
sgtitle("1Kg - training with no motion, validation with motion")
rmse = sqrt(mean((y_out - idd_validation.OutputData).^2))

% exportgraphics(gcf, "1.5kg-1Kgno.png")
% print -clipboard -dbitmap
