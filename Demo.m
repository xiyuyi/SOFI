% demo code for SOFI processing.
addpath ./fcns
xdim=256;
ydim=256;
mvlength=1000;
inputPath = './ExampleMovie';
inputName = 'dish1_9_good.tif';
outputPath = './ExampleMovie';
ImMeanLocFori = './ExampleMovie/ImMean_dish1_9_good.mat';
saveOption='off';
laglist = [0, 0, 0, 0, 0, 0, 0];
LibPath = './fcns'
xini=89; yini=160;
xend=166;yend=250;

%sigFit = xy_getPSF_globalAC2XC2(xdim,ydim,mvlength,inputPath,inputName,outputPath,ImMeanLocFori,saveOption);
sigFit = xy_getPSF_globalAC2XC2_selectFOV(xdim,ydim,mvlength,inputPath,inputName,outputPath,ImMeanLocFori,saveOption,xini,xend,yini,yend);
xy_getSOFI_Ord2to7(xdim,ydim,mvlength,inputPath,inputName,outputPath,laglist,LibPath,sigFit);