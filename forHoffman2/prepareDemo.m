%Prepare
% demo code for SOFI processing.
PackagePath = '/Volumes/Seagate2/Research/SOFI-by-Xiyu';
addpath([PackagePath,'./fcns']);
xdim=512;
ydim=512;
mvlength=80;
inputPath = '/Volumes/Seagate2/Research/SOFI-ldrc/ForPublish_code_moved_SeeReadMe/SOFI_Modules/ExampleMovie';
inputName = 'dish1_9_good.tif';
outputPath = '/Volumes/Seagate2/Research/SOFI-ldrc/ForPublish_code_moved_SeeReadMe/SOFI_Modules/ExampleMovie';
ImMeanLocFori = '/Volumes/Seagate2/Research/SOFI-ldrc/ForPublish_code_moved_SeeReadMe/SOFI_Modules/ExampleMovie/ImMean_dish1_9_good.mat';
saveOption='off';
laglist = [0, 0, 0, 0, 0, 0, 0];
LibPath = [PackagePath,'/fcns'];
xini=89; yini=160;
xend=166;yend=250;