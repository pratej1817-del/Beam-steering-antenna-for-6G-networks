clc;
clear;
close all;



fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

N = 8;

array = phased.ULA( ...
    'NumElements',N,...
    'ElementSpacing',lambda/2);

sv = phased.SteeringVector( ...
    'SensorArray',array,...
    'PropagationSpeed',c);

angles = [0 15 30 45 60];

saveFolder = fullfile('..','Figures','04_MultiAngle');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder)
end

for k = 1:length(angles)

    figure;

    weights = sv(fc,angles(k));

    pattern(array,...
        fc,...
        -180:180,...
        0,...
        'CoordinateSystem','polar',...
        'Weights',weights,...
        'PropagationSpeed',c);

    title(sprintf('Beam Steering %d Degrees',angles(k)));

    exportgraphics(gcf,...
        fullfile(saveFolder,...
        sprintf('Beam_%ddeg.png',angles(k))),...
        'Resolution',300);

end