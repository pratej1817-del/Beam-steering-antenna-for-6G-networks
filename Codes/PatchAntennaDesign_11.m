clc;
clear;
close all;

%% ============================================================
% Beam Steering Smart Antenna for 6G Networks
% Module 11 - Fast Patch Antenna Design
%% ============================================================

fc = 28e9;                     % 28 GHz

%% Rogers RT5880 Substrate

substrate = dielectric( ...
    'Name','Rogers5880', ...
    'EpsilonR',2.2, ...
    'LossTangent',0.0009, ...
    'Thickness',0.254e-3);

%% Design Patch

patch = design(patchMicrostrip,fc);

patch.Substrate = substrate;

%% Create Folder

saveFolder = fullfile('..','Figures','11_PatchDesign');

if ~exist(saveFolder,'dir')
    mkdir(saveFolder);
end

%% ============================================================
%% 1. Patch Geometry
%% ============================================================

figure;

show(patch);

title('28 GHz Patch Antenna Geometry');

exportgraphics(gcf,...
    fullfile(saveFolder,'PatchGeometry.png'),...
    'Resolution',300);

%% ============================================================
%% 2. Radiation Pattern
%% ============================================================

figure;

pattern(patch,fc);

title('Radiation Pattern at 28 GHz');

exportgraphics(gcf,...
    fullfile(saveFolder,'PatchPattern.png'),...
    'Resolution',300);

disp('=========================================')
disp('FAST PATCH DESIGN COMPLETED')
disp('=========================================')