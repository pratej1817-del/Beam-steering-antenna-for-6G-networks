clc;
clear;
close all;

%% ==========================================================
% SMART ANTENNA TRACKING CONSOLE
% Beam Steering Smart Antenna for 6G
%% ==========================================================

fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

N = 8;
d = lambda/2;

theta = -90:0.2:90;

figure('Color','w',...
    'Position',[100 50 1400 700]);

for userAngle = -60:2:60

    clf

    %% ===================================================
    % LEFT SIDE
    %% ===================================================

    subplot(1,2,1)

    hold on
    axis equal
    grid on

    xlim([-1.2 1.2])
    ylim([-1.2 1.2])

    title('6G Smart Antenna Tracking')

    % Base Station

    plot(0,0,'ks',...
        'MarkerSize',18,...
        'MarkerFaceColor','b')

    text(0,-0.12,...
        'Base Station',...
        'HorizontalAlignment','center',...
        'FontWeight','bold')

    %% User

    r = 1;

    x = r*cosd(userAngle);
    y = r*sind(userAngle);

    plot(x,y,'ro',...
        'MarkerFaceColor','r',...
        'MarkerSize',12)

    text(x,y+0.08,...
        'User',...
        'HorizontalAlignment','center')

    %% Beam

    plot([0 x],[0 y],...
        'g',...
        'LineWidth',3)

    %% ===================================================
    % RIGHT SIDE
    %% ===================================================

    subplot(1,2,2)

    AF = zeros(size(theta));

    for k=1:length(theta)

        psi = 2*pi*d/lambda*...
            (sind(theta(k))-sind(userAngle));

        AF(k)=abs(sum(exp(1j*(0:N-1)*psi)));

    end

    AF = AF/max(AF);

    AFdB = 20*log10(AF);

    AFdB(AFdB<-40)=-40;

    plot(theta,AFdB,...
        'b','LineWidth',2)

    hold on

    plot(userAngle,0,...
        'ro',...
        'MarkerFaceColor','r')

    grid on

    xlim([-90 90])
    ylim([-40 2])

    xlabel('Angle (Degrees)')
    ylabel('Normalized Gain (dB)')

    title('Adaptive Beam Steering')

    %% Status

    annotation('textbox',...
        [0.36 0.78 0.25 0.18],...
        'String',...
        {['Frequency : 28 GHz'],...
         ['Elements : 8'],...
         ['User Angle : ',num2str(userAngle),'°'],...
         ['Estimated DOA : ',num2str(userAngle),'°'],...
         ['Beam Angle : ',num2str(userAngle),'°'],...
         'Tracking : ACTIVE'},...
        'FontSize',11,...
        'FontWeight','bold',...
        'BackgroundColor',[0.94 0.97 1]);

    drawnow

    pause(0.08)

end