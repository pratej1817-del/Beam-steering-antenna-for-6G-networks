clc;
clear;
close all;

%% ==========================================================
% DOA Estimation using MUSIC
% Beam Steering Smart Antenna for 6G Networks
%% ==========================================================

fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

%% Antenna Array

array = phased.ULA( ...
    'NumElements',8,...
    'ElementSpacing',lambda/2);

%% Signal Parameters

fs = 1e6;

t = (0:1/fs:0.002).';

signal = cos(2*pi*100e3*t);

trueAngle = 35;

collector = phased.Collector( ...
    'Sensor',array,...
    'OperatingFrequency',fc,...
    'PropagationSpeed',c);

rx = collector(signal,[trueAngle;0]);

rx = awgn(rx,20,'measured');

%% MUSIC

estimator = phased.MUSICEstimator( ...
    'SensorArray',array,...
    'OperatingFrequency',fc,...
    'PropagationSpeed',c,...
    'ScanAngles',-90:0.5:90,...
    'DOAOutputPort',true,...
    'NumSignalsSource','Property',...
    'NumSignals',1);

[~,doa] = estimator(rx);

disp('=======================================')
fprintf('Actual DOA     : %.2f Degrees\n',trueAngle);
fprintf('Estimated DOA  : %.2f Degrees\n',doa);
disp('=======================================')

figure

plotSpectrum(estimator)

grid on

title('MUSIC Spatial Spectrum')