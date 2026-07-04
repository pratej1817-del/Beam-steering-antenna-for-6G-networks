clc;
clear;
close all;

N = 4;          
d = 0.5;        

x = (0:N-1) * d;

disp('Antenna Element Positions (in wavelengths):')
disp(x)

figure

stem(x,ones(1,N),...
    'filled',...
    'LineWidth',2,...
    'MarkerSize',8)

xlabel('Position (\lambda)')
ylabel('Amplitude')

title('4-Element Linear Antenna Array')

grid on

axis([-0.5 2.5 0 1.5])