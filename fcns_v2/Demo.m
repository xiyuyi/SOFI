%demo
load /Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2/CutInfo_2.mat
para.Node = Node;
para.mvlength = 20000;
para.xdim = 125;
para.ydim = 125;
para.inputPath = '/Volumes/Seagate2/DataPackage/Simulation_Filaments/forCuspArtifact/cuspDemo_rhoOn_0d5_v5/Results_0d5_Bleach_v2';
para.inputName = 'BlinkingSetZ50_Bleached.tif';
para.outputPath = 'fcd2';
para.laglist = [0,0,0,0,0,0,0];
para.LibPath = '/Volumes/Seagate2/Research/SOFI-by-Xiyu/fcns';
mkdir(para.outputPath)

cumuSet = xy_getCumuOrd2to7(para);
save([para.outputPath,'/cumuSet.mat'])