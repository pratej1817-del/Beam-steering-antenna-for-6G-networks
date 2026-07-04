clc;
clear;
close all;

fc = 28e9;              
c = physconst('LightSpeed');
lambda = c/fc;

N = 4;

array = phased.ULA( ...
    'NumElements',N,...
    'ElementSpacing',lambda/2);


steeringAngle = 30;

sv = phased.SteeringVector( ...
    'SensorArray',array,...
    'PropagationSpeed',c);

weights = sv(fc,steeringAngle);

figure;

pattern(array,...
    fc,...
    -180:180,...
    0,...
    'PropagationSpeed',c,...
    'Weights',weights);

title(['Beam Steering at ',num2str(steeringAngle),' Degrees']);