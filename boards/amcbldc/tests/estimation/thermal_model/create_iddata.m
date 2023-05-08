% Copyright (C) 2023 Fondazione Istituto Italiano di Tecnologia (IIT)
% All Rights Reserved.
function [idd] = create_iddata(camera, CAN, dataset_start_sample)

    % Initial values
    initial_temperature = 24.8; % C
    deltaT0 = 0; % C
    Rl = 25.9; % Ohm
    mId = 3;
    Ts = 0.1;
    
    camera_data = readtable(camera);
    camera_data.Properties.VariableNames = ["Time", "Temperature", "Frame"];
    
    CAN_data = load(CAN);
    P_rms = CAN_data.data.get("Power, W").Values;
    %% Preprocess data
    if(P_rms.Time(1) > 0.5)
        P_rms = timeseries(CAN_data.data.get("Power, W").Values.data, CAN_data.data.get("Power, W").Values.Time - CAN_data.data.get("Power, W").Values.Time(1));
    end
    
    temperature_ts = timeseries(camera_data.Temperature(:) - camera_data.Temperature(1), ...
                     ceil(camera_data.Time(:) / 1000));

    temperature_ts = resample(temperature_ts, P_rms.Time);
    temperature = rmmissing(temperature_ts.data);
    temperature = temperature(:) - temperature(dataset_start_sample);

    % Compute peak power
    %Iq_A = double(Iq.Data(dataset_start_sample:end, mId)) / 1000;
    %Id_A = double(Id.Data(dataset_start_sample:end, mId)) / 1000;
    %Pd_peak = Rl * (Iq_A.^2 + Id_A.^2);

    % Compute RMS power
    Pd_crop_rms = double(P_rms.data(1:end, mId));

    idd = iddata(temperature(dataset_start_sample:length(temperature)), Pd_crop_rms(dataset_start_sample:length(temperature)), Ts);

end

