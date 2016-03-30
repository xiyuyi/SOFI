% demo code for SOFI processing.
addpath ./fcns
xdim=256;
ydim=256;
mvlength=1000;
inputPath = '/Volumes/Seagate2/Research/SOFI-ldrc/ForPublish_code_moved_SeeReadMe/SOFI_Modules/ExampleMovie';
inputName = 'dish1_9_good.tif';
outputPath = '/Volumes/Seagate2/Research/SOFI-ldrc/ForPublish_code_moved_SeeReadMe/SOFI_Modules/ExampleMovie';
ImMeanLocFori = '/Volumes/Seagate2/Research/SOFI-ldrc/ForPublish_code_moved_SeeReadMe/SOFI_Modules/ExampleMovie/ImMean_dish1_9_good.mat';
saveOption='off';
laglist = [0, 0, 0, 0, 0, 0, 0];
LibPath = './fcns'
xini=89; yini=160;
xend=166;yend=250;

%% step1 estimate the PSF.
sigFit = xy_getPSF_globalAC2XC2_selectFOV(xdim,ydim,mvlength,inputPath,inputName,outputPath,ImMeanLocFori,saveOption,xini,xend,yini,yend);


%% step2 SOFI calculation
xy_getSOFI_Ord2to7(xdim,ydim,mvlength,inputPath,inputName,outputPath,laglist,LibPath,sigFit);


%% step3 parameter estimation
[RhoMap, RhoTru, epsMap] = xy_getPSF_paraEsti(xdim,ydim,mvlength,outputPath,inputName,outputPath,ImMeanLocFori,sigFit,saveOption,laglist);


%% step4 get Moments reconstruction
[M2, M3, M4, M5, M6, M7] = xy_getSOFI_MomentsReconstruction(inputPath,outputPath,ImMeanLocFori,LibPath);

save([outputPath,'/ldrcOutPut.mat']);