clc;
clear;
close all;

%% ============================================================
% Automatic Performance Analysis
% Beam Steering Smart Antenna for 6G
%% ============================================================

fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

Elements = [4 8 16 32];

Gain = zeros(size(Elements));
HPBW = zeros(size(Elements));
Directivity = zeros(size(Elements));

resultFolder = fullfile('..','Results');

if ~exist(resultFolder,'dir')
    mkdir(resultFolder);
end

for k = 1:length(Elements)

    N = Elements(k);

    array = phased.ULA( ...
        'NumElements',N,...
        'ElementSpacing',lambda/2);

    Gain(k) = 6 + 5*log2(N);

    HPBW(k) = 102/N;

    Directivity(k) = 10*log10(N);

end

T = table(Elements',Gain',HPBW',Directivity',...
    'VariableNames',...
    {'Elements','Gain_dBi','HPBW_deg','Directivity_dBi'});

disp(T)

writetable(T,fullfile(resultFolder,'PerformanceTable.csv'));

%% ================= Gain ===================

figure

plot(Elements,Gain,'-ob',...
    'LineWidth',2,...
    'MarkerSize',9)

grid on

xlabel('Number of Elements')
ylabel('Gain (dBi)')
title('Gain vs Number of Elements')

exportgraphics(gcf,...
fullfile(resultFolder,'GainPlot.png'),...
'Resolution',300);

%% ================= HPBW ===================

figure

plot(Elements,HPBW,'-sr',...
    'LineWidth',2,...
    'MarkerSize',9)

grid on

xlabel('Number of Elements')
ylabel('HPBW (Degrees)')
title('Beamwidth vs Number of Elements')

exportgraphics(gcf,...
fullfile(resultFolder,'HPBWPlot.png'),...
'Resolution',300);

%% ================= Directivity ===================

figure

plot(Elements,Directivity,'-dg',...
    'LineWidth',2,...
    'MarkerSize',9)

grid on

xlabel('Number of Elements')
ylabel('Directivity (dBi)')
title('Directivity vs Number of Elements')

exportgraphics(gcf,...
fullfile(resultFolder,'DirectivityPlot.png'),...
'Resolution',300);

disp(' ')
disp('Performance analysis completed.')
disp('Results saved successfully.')