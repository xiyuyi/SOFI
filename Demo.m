% demo code for SOFI processing.
PackagePath = '.';

addpath(genpath([PackagePath,'/fcns']));
xdim=256;
ydim=256;
mvlength=1000;
if ismac
    inputPath = './exampleData';
elseif ispc
    inputPath = './exampleData';
end  

inputName = 'DifferentTauOn_2016Oct11_3.tif';
if ismac
    outputPath = './Output';
    ImMeanLocFori = [outputPath,'/ImMean.mat'];
    LibPath = [PackagePath,'/fcns'];
elseif ispc
    outputPath = '.\Output';
    ImMeanLocFori = [outputPath,'\ImMean.mat'];
    LibPath = [PackagePath,'\fcns'];
end

saveOption='off';
laglist = [0, 0, 0, 0, 0, 0, 0];
xini = 1;    yini = 1;
xend = xdim; yend = ydim;
mkdir(outputPath);
ImMean = zeros(xdim, ydim);
for i0 = 1 : mvlength
    disp(['calculating Mean frame #',num2str(i0),'/',num2str(mvlength)])
    if ismac
        ImMean = ImMean + double(imread([inputPath,'/',inputName],'Index',i0));
    elseif ispc
        ImMean = ImMean + double(imread([inputPath,'\',inputName],'Index',i0));
    end    
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

