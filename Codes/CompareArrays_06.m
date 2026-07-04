clc;
clear;
close all;



fc = 28e9;
c = physconst('LightSpeed');
lambda = c/fc;

elements = [4 8 16];

saveFolder = fullfile('..','Figures','06_Comparison');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder)
end

for k = 1:length(elements)

    N = elements(k);

    array = phased.ULA( ...
        'NumElements',N,...
        'ElementSpacing',lambda/2);

    figure;

    pattern(array,...
        fc,...
        -180:180,...
        0,...
        'CoordinateSystem','polar',...
        'PropagationSpeed',c);

    title(sprintf('%d Element Linear Array',N));

    exportgraphics(gcf,...
        fullfile(saveFolder,...
        sprintf('%d_Element_Array.png',N)),...
        'Resolution',300);

end