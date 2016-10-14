% demo code for SOFI processing.

load SOFI_vHoffman2.mat
mkdir(outputPath)

ImMean = zeros(xdim,ydim);
for i0 = 1:mvlength
    disp(['calculating Mean frame #',num2str(i0),'/',num2str(mvlength)])
    ImMean = ImMean + double(imread([inputPath,'/',inputName],'Index',i0));
end
ImMean = ImMean./mvlength;
save(ImMeanLocFori,'ImMean');
%% step1 estimate the PSF.
sigFit = xy_getPSF_globalAC2XC2_selectFOV(xdim,ydim,mvlength,inputPath,inputName,outputPath,ImMeanLocFori,saveOption,xini,xend,yini,yend);


%% step2 SOFI calculation
xy_getSOFI_Ord2to7(xdim,ydim,mvlength,inputPath,inputName,outputPath,laglist,LibPath,sigFit);


%% step3 parameter estimation
[RhoMap, RhoTru, epsMap] = xy_getPSF_paraEsti(xdim,ydim,mvlength,inputPath,inputName,outputPath,ImMeanLocFori,sigFit,saveOption,laglist);


%% step4 get Moments reconstruction
[M2, M3, M4, M5, M6, M7] = xy_getSOFI_MomentsReconstruction(outputPath,outputPath,ImMeanLocFori,LibPath);

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
exit
