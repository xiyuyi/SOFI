%demo
% cutInfoPath='/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo.mat'
% para.Node = Node;
% para.mvlength = 20000;
% para.xdim = 125;
% para.ydim = 125;
% para.inputPath = '/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2';
% para.inputName = 'BlinkingSetZ50_Bleached.tif';
% para.outputPath = '.';
% para.laglist = [0,0,0,0,0,0,0];
% para.LibPath = '/Volumes/Seagate2/Research/SOFI-by-Xiyu/fcns';

load SOFI_bleachCorrected_Prep.mat
load(cutInfoPath)
cumuSet = xy_getCumuOrd2to7(para);