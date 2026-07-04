clc;
clear;
close all;

%% ==========================================================
% Adaptive Beam Steering using MUSIC DOA
% Beam Steering Smart Antenna for 6G Networks
%% ==========================================================

fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

%% Antenna Array

N = 8;

array = phased.ULA( ...
    'NumElements',N,...
    'ElementSpacing',lambda/2);

%% Simulated User Direction

trueAngle = 35;

%% Signal

fs = 1e6;

t = (0:1/fs:0.002).';

signal = cos(2*pi*100e3*t);

collector = phased.Collector( ...
    'Sensor',array,...
    'OperatingFrequency',fc,...
    'PropagationSpeed',c);

rx = collector(signal,[trueAngle;0]);

rx = awgn(rx,20,'measured');

%% MUSIC DOA

estimator = phased.MUSICEstimator( ...
    'SensorArray',array,...
    'OperatingFrequency',fc,...
    'PropagationSpeed',c,...
    'ScanAngles',-90:0.5:90,...
    'DOAOutputPort',true,...
    'NumSignalsSource','Property',...
    'NumSignals',1);

[~,estimatedDOA] = estimator(rx);

%% ==========================================================
%% Beam Steering
%% ==========================================================
%% Adaptive Beam Steering (Array Factor)
%% ==========================================================

theta = -90:0.2:90;

AF = zeros(size(theta));

k = 2*pi/lambda;
d = lambda/2;

for m = 1:length(theta)

    psi = k*d*(sind(theta(m))-sind(estimatedDOA));

    AF(m)=abs(sum(exp(1j*(0:N-1)*psi)));

end

AF = AF/max(AF);

AFdB = 20*log10(AF);

AFdB(AFdB<-40)=-40;

figure

plot(theta,AFdB,'b','LineWidth',2)

grid on

xlabel('Angle (Degrees)')
ylabel('Normalized Gain (dB)')

title(['Adaptive Beam Steering using MUSIC (',num2str(estimatedDOA),'°)'])

xlim([-90 90])
ylim([-40 0])

hold on

plot(estimatedDOA,0,'ro','MarkerSize',10,'LineWidth',2)

legend('Beam Pattern','Estimated User')%% Save Figure

saveFolder = fullfile('..','Figures','14_AdaptiveBeamSteering');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

exportgraphics(gcf,...
    fullfile(saveFolder,'AdaptiveBeamSteering.png'),...
    'Resolution',300);

%% Results

disp('===========================================')
fprintf('Actual User Angle      : %.2f°\n',trueAngle);
fprintf('Estimated DOA          : %.2f°\n',estimatedDOA);
fprintf('Beam Steering Angle    : %.2f°\n',estimatedDOA);
disp('===========================================')