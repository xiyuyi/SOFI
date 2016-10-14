%% user input
% fbc = 0.005;
% frameN = 2000;
% para.LibPath = '/Volumes/Seagate2/Research/SOFI-by-Xiyu/fcns_v2';
% para.inputPath = '/Volumes/ResearchMac3/SOFI_ldrcMoments/fixed_FPfusion/ROIs';
% para.inputName = 'Will_Transfect_Fixed_5_Spool_FOV.tif';
% para.outputPath = 'Data5_fbc0d5';
% para.laglist = [0,0,0,0,0,0,0];

%% user input ends
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load UserInputSOFI.mat


%%
para.mvlength = frameN;
Factor = round(1/fbc);     
addpath(genpath(para.LibPath));
%% get the actual bleaching curve as the decay of spatial average signal
para.mvlength = frameN;
output = cutNodePrep(para) ;
para.xdim = output.xdim;
para.ydim = output.ydim;
b = output.b;
%% decide break points of blocks.
% step1. calcualte the average signal 
%(should the subtraction be pixel-wise? or over all...I think it should be pixelwise.)
% now sit back and think about it.
% instinctly think should be pixelwise. need to justify it by itself.
% step2. decide the break points based on the average signal.
[Node, bSmooth] = cutNodes_demo(output.b,para.mvlength,Factor);
para.Node = Node;

%%
mkdir(para.outputPath)
save([para.outputPath,'/CutInfo.mat'], 'Node', 'b', 'bSmooth');
cumuSet = xy_getCumuOrd2to7V2(para);
save([para.outputPath,'/cumuSet.mat'])