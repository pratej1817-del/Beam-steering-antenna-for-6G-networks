clc;
clear;
close all;

%% ==========================================================
% Module 16
% Live Beam Tracking Animation
%% ==========================================================

fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

N = 8;
d = lambda/2;

theta = -90:0.25:90;

saveFolder = fullfile('..','Figures','16_UserTrackingAnimation');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

gifFile = fullfile(saveFolder,'BeamTracking.gif');

figure('Color','w','Position',[100 100 900 500]);

for userAngle = -60:2:60

    AF = zeros(size(theta));

    for i = 1:length(theta)

        psi = 2*pi*d/lambda * ...
             (sind(theta(i))-sind(userAngle));

        AF(i)=abs(sum(exp(1j*(0:N-1)*psi)));

    end

    AF = AF/max(AF);

    AFdB = 20*log10(AF);

    AFdB(AFdB<-40)=-40;

    clf

    plot(theta,AFdB,...
        'LineWidth',3,...
        'Color',[0 0.4470 0.7410]);

    hold on

    plot(userAngle,0,...
        'ro',...
        'MarkerFaceColor','r',...
        'MarkerSize',10);

    xline(userAngle,...
        '--r',...
        'LineWidth',2);

    text(userAngle+2,-5,...
        sprintf('User = %d°',userAngle),...
        'FontWeight','bold');

    grid on

    xlabel('Angle (Degrees)')
    ylabel('Normalized Gain (dB)')

    title('Adaptive Beam Tracking')

    xlim([-90 90])
    ylim([-40 2])

    drawnow

    frame = getframe(gcf);

    img = frame2im(frame);

    [A,map]=rgb2ind(img,256);

    if userAngle==-60

        imwrite(A,map,gifFile,...
            'gif',...
            'LoopCount',Inf,...
            'DelayTime',0.07);

    else

        imwrite(A,map,gifFile,...
            'gif',...
            'WriteMode','append',...
            'DelayTime',0.07);

    end

end

exportgraphics(gcf,...
fullfile(saveFolder,'FinalTrackingFrame.png'),...
'Resolution',300);

disp('========================================')
disp('User Tracking Animation Completed')
disp('GIF Saved Successfully')
disp('========================================')