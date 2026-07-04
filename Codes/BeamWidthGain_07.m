clc;
clear;
close all;

Elements = [4 8 16];

Gain = [12.1 15.8 18.9];

Beamwidth = [28 14 7];

saveFolder = fullfile('..','Figures','07_GainBeamwidth');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder)
end



figure;

plot(Elements,Gain,'-o','LineWidth',2)

grid on

xlabel('Number of Elements')

ylabel('Gain (dBi)')

title('Gain vs Number of Elements')

exportgraphics(gcf,...
    fullfile(saveFolder,'GainComparison.png'),...
    'Resolution',300);



figure;

plot(Elements,Beamwidth,'-s','LineWidth',2)

grid on

xlabel('Number of Elements')

ylabel('Beamwidth (Degrees)')

title('Beamwidth vs Number of Elements')

exportgraphics(gcf,...
    fullfile(saveFolder,'BeamwidthComparison.png'),...
    'Resolution',300);