clc;
clear;
close all;

%% Create folders if they don't exist

figureFolder = fullfile('..','Figures','Final');
resultFolder = fullfile('..','Results');

if ~exist(figureFolder,'dir')
    mkdir(figureFolder);
end

if ~exist(resultFolder,'dir')
    mkdir(resultFolder);
end

%% Performance Data

Elements = [4 8 16];

Gain = [12.1 15.8 18.9];

Beamwidth = [28 14 7];

SteeringRange = [60 60 60];

%% Create Table

T = table(Elements',Gain',Beamwidth',SteeringRange',...
    'VariableNames',{'Elements','Gain_dBi','Beamwidth_deg','SteeringRange_deg'});

disp(T)

%% Save CSV

writetable(T,fullfile(resultFolder,'PerformanceTable.csv'));

%% Dashboard

figure('Position',[100 100 700 250]);

uitable(...
    'Data',table2cell(T),...
    'ColumnName',T.Properties.VariableNames,...
    'Units','normalized',...
    'Position',[0 0 1 1]);

drawnow;

exportgraphics(gcf,...
    fullfile(figureFolder,'PerformanceDashboard.png'),...
    'Resolution',300);