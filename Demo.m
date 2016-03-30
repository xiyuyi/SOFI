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

%% step5 ldrc process the Moments. use second order SOFI as reference mask
InputImage = imfilter(M6,fspecial('gaussian',[11,11],2));
order = 7;
Mask = imfilter(M2,fspecial('gaussian',[11,11],2));
windowSize=25;

ldrcResult = xy_ldrc(InputImage, order, Mask,  windowSize);

%% step6 visualization
TransMap = ldrcResult.ldrc.^0.6; Cmap = colormap(cool); cLevelN = 256; 
TransMapRange = [min(TransMap(:)),max(TransMap(:))]; CIntRange = [0,0.5];
colorCodeResult_Rho = xy_colorCode(imresize(RhoMap,size(TransMap)), TransMap, Cmap, cLevelN, TransMapRange, CIntRange);
colorCodeResult_eps = xy_colorCode(imresize(epsMap,size(TransMap)), TransMap, Cmap, cLevelN, TransMapRange, [10,500]);
figure;imshow(colorCodeResult_Rho.img)
figure;imshow(colorCodeResult_eps.img)


%% step7 save
save([outputPath,'/ldrcOutPut.mat']);

