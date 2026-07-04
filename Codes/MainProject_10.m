clc;
clear;
close all;

disp('===============================================')
disp('     6G SMART ANTENNA BEAM STEERING PROJECT')
disp('===============================================')

currentFolder = fileparts(mfilename('fullpath'));
cd(currentFolder);

%% Module 01 - Array Creation
disp('Running Module 01...')
run('ArrayCreation_01.m')

%% Module 02 - Array Factor
disp('Running Module 02...')
run('ArrayFactor_02.m')

%% Module 03 - Beam Steering
disp('Running Module 03...')
run('BeamSteering_03.m')

%% Module 04 - Multi Angle Beam Steering
disp('Running Module 04...')
run('MultiAngleBeamSteering_04.m')

%% Module 05 - 3D Radiation
disp('Running Module 05...')
run('Radiation3D_05.m')

%% Module 06 - Compare Arrays
disp('Running Module 06...')
run('CompareArrays_06.m')

%% Module 07 - Gain & Beamwidth
disp('Running Module 07...')
run('BeamWidthGain_07.m')

%% Module 08 - User Tracking
disp('Running Module 08...')
run('UserTracking_08.m')

%% Module 09 - Performance Dashboard
disp('Running Module 09...')
run('PerformanceDashboard_09.m')

%% Module 11 - Patch Antenna Design
disp('Running Module 11...')
run('PatchAntennaDesign_11.m')

%% Module 13 - MUSIC DOA
disp('Running Module 13...')
run('DOA_MUSIC_13.m')

%% Module 14 - Adaptive Beam Steering
disp('Running Module 14...')
run('AdaptiveBeamSteering_14.m')

%% Module 15 - Automatic Performance
disp('Running Module 15...')
run('AutomaticPerformance_15.m')

%% Module 16 - Smart Tracking Console
disp('Running Module 16...')
run('SmartTrackingConsolePro_16.m')

disp('===============================================')
disp('      ALL MODULES COMPLETED SUCCESSFULLY')
disp('===============================================')