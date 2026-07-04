clc;
close all;

fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

N = 8;
d = lambda/2;

theta = -90:0.2:90;

saveFolder = fullfile('..','Figures','19_BeamScanning');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

figure('Color',[0.08 0.08 0.08],...
    'Position',[150 80 1100 650]);

for scanAngle = -60:5:60

    clf

    psi = 2*pi*d/lambda*(sind(theta)-sind(scanAngle));

    AF = zeros(size(theta));

    for k = 1:length(theta)
        AF(k)=abs(sum(exp(1j*(0:N-1)*psi(k))));
    end

    AF = AF/max(AF);

    AFdB = 20*log10(AF);

    AFdB(AFdB<-40)=-40;

    plot(theta,AFdB,...
        'c',...
        'LineWidth',2.5);

    hold on

    xline(scanAngle,...
        '--r',...
        'LineWidth',2);

    grid on

    set(gca,...
        'Color',[0.12 0.12 0.12],...
        'XColor','w',...
        'YColor','w');

    title(sprintf('Beam Scanning : %.0f°',scanAngle),...
        'Color','w',...
        'FontSize',18);

    xlabel('Angle (Degrees)','Color','w');
    ylabel('Normalized Gain (dB)','Color','w');

    xlim([-90 90]);
    ylim([-40 2]);

    drawnow;

    pause(0.08);

end

set(gcf,'InvertHardcopy','off');

exportgraphics(gcf,...
    fullfile(saveFolder,'BeamScanning.png'),...
    'Resolution',300,...
    'BackgroundColor','current');

disp('================================')
disp('Beam Scanning Completed')
disp('================================')