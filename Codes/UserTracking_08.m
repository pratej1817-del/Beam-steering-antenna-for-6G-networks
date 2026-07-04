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

angles = 0:5:60;

saveFolder = fullfile('..','Figures','07_UserTracking');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

for k=1:length(angles)

    figure('Visible','off');

    weights = sv(fc,angles(k));

    pattern(array,...
        fc,...
        -180:180,...
        0,...
        'CoordinateSystem','polar',...
        'Weights',weights,...
        'PropagationSpeed',c);

    title(sprintf('User Position = %d°',angles(k)));

    exportgraphics(gcf,...
        fullfile(saveFolder,...
        sprintf('User_%02d.png',angles(k))),...
        'Resolution',300);

    close;

end