% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%
% Author: Simone Girardi <simone.girardi@iit.it>

%% Plot [Va,Vb,Vc] and [Ia,Ib,Ic] data from printf in mbdagent_innerloop

% Setup constants
PATH = '<path-to-your-data.txt>';
FILENAME = 'run1.txt';
SAMPLE_INDEX = 851;

% Read Data
t = readtable(strcat(PATH,FILENAME));

% Preprocessing
t.Properties.VariableNames = {'Va','Vb','Vc','Ia', 'Ib', 'Ic'};

% scale Voltages to percentage
t.Va = t.Va / 163.83;
t.Vb = t.Vb / 163.83;
t.Vc = t.Vc / 163.83;

% Plots
plotaxes = [];
layout = tiledlayout(3,2);
plotaxes(end+1) = nexttile;
sgtitle(['Polarization strategy comparison test',' without MIN and with 50% offset'], 'FontSize', 18)
layout.Padding = 'compact';

datatip(plot(t.Va, 'o-', 'MarkerEdgeColor','red','MarkerIndices',SAMPLE_INDEX),'DataIndex',SAMPLE_INDEX);
ylabel('Va [%]')
xlabel('samples')
grid minor

plotaxes(end+1) = nexttile;
datatip(plot(t.Ia, 'o-', 'MarkerEdgeColor','red','MarkerIndices',SAMPLE_INDEX),'DataIndex',SAMPLE_INDEX);
ylabel('Ia [A]')
xlabel('samples')
grid minor

plotaxes(end+1) = nexttile;
datatip(plot(t.Vb, 'o-', 'MarkerEdgeColor','red','MarkerIndices',SAMPLE_INDEX),'DataIndex',SAMPLE_INDEX);
ylabel('Vb [%]')
xlabel('samples')
grid minor

plotaxes(end+1) = nexttile;
datatip(plot(t.Ib, 'o-', 'MarkerEdgeColor','red','MarkerIndices',SAMPLE_INDEX),'DataIndex',SAMPLE_INDEX);
ylabel('Ib [A]')
xlabel('samples')
grid minor

plotaxes(end+1) = nexttile;
datatip(plot(t.Vc, 'o-', 'MarkerEdgeColor','red','MarkerIndices',SAMPLE_INDEX),'DataIndex',SAMPLE_INDEX);
ylabel('Vc [%]')
xlabel('samples')
grid minor

plotaxes(end+1) = nexttile;
datatip(plot(t.Ic, 'o-', 'MarkerEdgeColor','red','MarkerIndices',SAMPLE_INDEX),'DataIndex',SAMPLE_INDEX);
ylabel('Ic [A]')
xlabel('samples')
grid minor

% link all Plots to zoom them together
linkaxes(plotaxes, 'x')
xlim([700 900])
% yline(0.4, 'r--', 'linewidth', 1.2)

% Export Plots for sharing
%exportgraphics(gcf, 'run1fw.png','Resolution',600)

% copy to clipboard
print -clipboard -dbitmap