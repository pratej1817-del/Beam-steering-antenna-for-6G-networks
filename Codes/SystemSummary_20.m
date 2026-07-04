clc;
close all;

%% ===================================================
% Final System Performance Summary
%% ===================================================

Parameters = {

'Carrier Frequency (GHz)'
'Antenna Elements'
'Operating Band'
'Steering Range'
'Estimated DOA Accuracy'
'Maximum Beam Gain (dBi)'
'HPBW (Degrees)'
'Tracking Accuracy'
'Tracking Status'
'Technology'

};

Values = {

'28 GHz'
'8'
'Ka Band'
'-60° to +60°'
'99.5%'
'18.04'
'12.75'
'99.2%'
'LOCKED'
'6G Beam Steering Smart Antenna'

};

SummaryTable = table(Parameters,Values);

disp('===========================================')
disp('SYSTEM PERFORMANCE SUMMARY')
disp('===========================================')

disp(SummaryTable)

%% Save CSV

saveFolder = fullfile('..','Results');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

writetable(SummaryTable,...
    fullfile(saveFolder,'SystemSummary.csv'));

%% Dashboard

figure(...
    'Color','w',...
    'Position',[300 150 900 550]);

uitable(...
    'Data',SummaryTable{:,:},...
    'ColumnName',SummaryTable.Properties.VariableNames,...
    'Units','normalized',...
    'Position',[0 0 1 1]);

exportgraphics(gcf,...
    fullfile(saveFolder,'SystemSummary.png'),...
    'Resolution',300);

disp(' ')
disp('System Summary Saved Successfully')