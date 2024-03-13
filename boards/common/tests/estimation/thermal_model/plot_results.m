% Copyright (C) 2023 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
function [rmse,h] = plot_results(model, idd_training, idd_validations, n_validation_sets, training_Ts, validation_Ts)
    h = figure;
    subplot(2,1,1)
    timevec = 0:training_Ts:((length(idd_training.InputData)-1)*training_Ts);
    [y_out, time] = lsim(model, idd_training.InputData, timevec);
    plot(time, y_out, "LineWidth", 1.5)
    hold on
    plot(timevec, idd_training.OutputData, "LineWidth", 1.5);
    ylabel("\Delta T (C)")
    legend({"model", "camera"}, 'location', 'northwest')
    title("Training data")
    h1 = gca;
    
    subplot(2,1,2)
    
    rmse(n_validation_sets, 1) = struct;

    colors = {"r", "b", "m", "k", "g"};
    for i=1:n_validation_sets
        timevec = 0:validation_Ts:((length(idd_validations{i}.InputData)-1)*validation_Ts);
        [y_out, time] = lsim(model, idd_validations{i}.InputData(1:end), timevec(1:end));
        plot(time, y_out, "-", "Color", colors{i}, "LineWidth", 1.5)
        ylabel("\Delta T (C)")
        xlabel("Time (sec)")
        hold on
        plot(timevec(1:end), idd_validations{i}.OutputData(1:end), "--", "Color", colors{i},  "LineWidth", 1.5);
        title("Validation data")
        h2 = gca;
        
        linkaxes([h1, h2], 'x')
        
        rmse(i).name = "Validation set " + string(n_validation_sets) + " result";
        rmse(i).value = rms(y_out - idd_validations{i}.OutputData);
    end
    
    legend({"model est val set 1", "meas val set 1", "model est val set 2", "meas val set 2", "model est val set 3", "meas val set 3"});
end

