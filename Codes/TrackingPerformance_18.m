clc;
close all;

frames = 1:100;

actualAngle = -60 + 120*(frames-1)/(length(frames)-1);

estimatedAngle = actualAngle + 0.2*randn(size(actualAngle));

beamAngle = estimatedAngle;

trackingError = abs(actualAngle-estimatedAngle);

figure('Color',[0.08 0.08 0.08],...
       'Position',[150 80 1200 700]);

%% Tracking Error

subplot(2,2,1)

plot(frames,...
     trackingError,...
     'r',...
     'LineWidth',2)

grid on

title('Tracking Error','Color','w')

xlabel('Frame','Color','w')

ylabel('Error (Degrees)','Color','w')

set(gca,'Color',[0.12 0.12 0.12],...
        'XColor','w',...
        'YColor','w')

%% Actual vs Estimated DOA

subplot(2,2,2)

plot(frames,...
     actualAngle,...
     'c',...
     'LineWidth',2)

hold on

plot(frames,...
     estimatedAngle,...
     '--y',...
     'LineWidth',2)

grid on

legend('Actual','Estimated',...
       'TextColor','w')

title('DOA Estimation','Color','w')

xlabel('Frame','Color','w')

ylabel('Angle (Degrees)','Color','w')

set(gca,'Color',[0.12 0.12 0.12],...
        'XColor','w',...
        'YColor','w')

%% Beam Direction

subplot(2,2,3)

plot(frames,...
     beamAngle,...
     'g',...
     'LineWidth',2)

grid on

title('Beam Steering Direction','Color','w')

xlabel('Frame','Color','w')

ylabel('Angle (Degrees)','Color','w')

set(gca,'Color',[0.12 0.12 0.12],...
        'XColor','w',...
        'YColor','w')

%% Error Histogram

subplot(2,2,4)

histogram(trackingError,15)

title('Tracking Error Distribution','Color','w')

xlabel('Error (Degrees)','Color','w')

ylabel('Count','Color','w')

set(gca,'Color',[0.12 0.12 0.12],...
        'XColor','w',...
        'YColor','w')

sgtitle('6G Beam Tracking Performance Analysis',...
        'Color','w',...
        'FontSize',18)

disp('=================================')
disp('Tracking Performance Completed')
disp('=================================')
saveFolder = fullfile('..','Figures','18_TrackingPerformance');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

set(gcf,'InvertHardcopy','off');

exportgraphics(gcf,...
    fullfile(saveFolder,'TrackingPerformance.png'),...
    'Resolution',300,...
    'BackgroundColor','current');