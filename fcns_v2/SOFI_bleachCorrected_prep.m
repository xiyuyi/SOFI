%demo
clear all

para.mvlength = 20000;
para.xdim = 125;
para.ydim = 125;
para.inputPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2';
para.inputName = 'Noise1_BlinkingSetZ50.tif';
para.outputPath = '.';
para.laglist = [0,0,0,0,0,0,0];
para.LibPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2/cutInfos_noBleach_noise1';
mkdir set1
mkdir set2
mkdir set3
mkdir set4
mkdir set5


cutInfoPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2/cutInfos/CutInfo_0d25.mat';
load('/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo_0d25.mat');
para.Node = Node;
save set1/SOFI_bleachCorrected_Prep.mat

cutInfoPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2/cutInfos/CutInfo_0d5.mat';
load('/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo_0d5.mat');
para.Node = Node;
save set2/SOFI_bleachCorrected_Prep.mat

cutInfoPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2/cutInfos/CutInfo_1.mat';
load('/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo_1.mat');
para.Node = Node;
save set3/SOFI_bleachCorrected_Prep.mat

cutInfoPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2/cutInfos/CutInfo_2.mat';
load('/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo_2.mat');
para.Node = Node;
save set4/SOFI_bleachCorrected_Prep.mat

cutInfoPath = '/u/scratch/x/xiyuyi/July4/rhoOn_od5_bleachv2/cutInfos/CutInfo_4.mat';
load('/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo_4.mat');
para.Node = Node;
save set5/SOFI_bleachCorrected_Prep.mat
