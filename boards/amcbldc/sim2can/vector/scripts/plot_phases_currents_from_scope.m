% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%
% Author: Simone Girardi <simone.girardi@iit.it>

%% Plot [Va,Vb] and [Ia,Ib] data from csv file exported by the oscilloscope

% 1. First import the csv file (TODO: fix the number of lines to skip)
tek0001ALL400 = readtable('myfile.csv','NumHeaderLines',3);  % skips the first three rows of data

tiledlayout(5,1);
tiled = tiledlayout(4,1);
plotaxes(end+1) = nexttile;
plot(tek0001ALL400.i1(1:100000))
ylabel('Ampere')
xlabel('samples (1 sample = 200ns)')
grid minor
plotaxes(end+1) = nexttile;
plot(tek0001ALL400.i2(1:100000))
ylabel('Ampere')
xlabel('samples (1 sample = 200ns)')
grid minor
i3 = tek0001ALL400.i1 - tek0001ALL400.i2;
plotaxes(end+1) = nexttile;
plot(i3(1:100000))
ylabel('Ampere');
xlabel('samples (1 sample = 200ns)');
plotaxes(end+1) = nexttile;
plot(lowpass(vdiff((1:100000),:),10000,fs))
ylabel('Volt');
xlabel('samples (1 sample = 200ns)');
linkaxes(plotaxes, 'x')
sgtitle(['Polarization strategy comparison test',' with MIN and with 5% offset'], 'FontSize', 18)
tiled.Padding = 'compact';
print -clipboard -dbitmap