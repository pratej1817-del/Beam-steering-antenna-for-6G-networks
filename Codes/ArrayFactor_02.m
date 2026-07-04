clc;
clear;
close all;

N = 4;      
d = 0.5;        
theta = linspace(-180,180,1000);

theta_rad = deg2rad(theta);

AF = zeros(size(theta_rad));

for n = 0:N-1

    AF = AF + exp(1j*2*pi*d*n*sin(theta_rad));

end

AF = abs(AF);

AF = AF/max(AF);

figure

plot(theta,AF,'LineWidth',2)

grid on

xlabel('Angle (Degrees)')

ylabel('Normalized Array Factor')

title('Radiation Pattern of 4-Element Linear Array')