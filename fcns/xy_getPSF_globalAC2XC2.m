% Author: Xiyu Yi
% the fitted PSF has this model:
% PSF(r) = exp(-r^2/(2*sigFit^2)); and it is in the unit of unit pixel
% length.

function sigFit = xy_getPSF_globalAC2XC2(xdim,ydim,mvlength,inputPath,inpuName,outputPath,ImMeanLoc,saveOption)

%1. get all pixel vector locations, for this array. Center location is [0,0]
ri_series = [-2,-2;-2,-1;-2,0;-2,1;-2,2;-1,-2;-1,-1;-1,0;-1,1;-1,2;0,-2;0,-1];
Slope.Xi2 = [16,10,8,10,16,10,4,2,4,10,8,2]; % get corresponding Xi^2
load(ImMeanLoc)

SOFI2_AC = zeros(xdim-4, ydim-4); %edge All cutted.
for i0 = 1:12
    eval(['SOFI2_XC',num2str(i0),' = zeros(xdim-4, ydim-4);'])
end
mvlengthS = num2str(mvlength);
for i0 = 1:mvlength
    disp(['frame #',num2str(i0),'/',mvlengthS])
    im = double(imread([inputPath,'/',inpuName],'Index',i0)) - ImMean;
% Cut edges, to get equivalence image shifting, to get alignment of
% pixels as if XC computation.
    imAC = im(3:end-2,3:end-2);
    for i1 = 1:12
        ri = ri_series(i1,:);
        imI = im(3+ri(1):end-2+ri(1), 3+ri(2):end-2+ri(2));
        eval(['imI',num2str(i1),'=imI;'])
        rj = [0,0]-ri;
        imJ = im(3+rj(1):end-2+rj(1), 3+rj(2):end-2+rj(2));
        eval(['imJ',num2str(i1),'=imJ;'])        
    end
    SOFI2_AC = SOFI2_AC + imAC.^2;
    for i1 = 1:12
        eval(['SOFI2_XC',num2str(i1),'= SOFI2_XC',num2str(i1),' + imI',num2str(i1),'.*imJ',num2str(i1),';'])
    end
end
SOFI2_AC = SOFI2_AC./mvlength;
for i0 = 1:12
    eval(['SOFI2_XC',num2str(i0),' = SOFI2_XC',num2str(i0),'./mvlength;'])
end
% now fit for slopes
 for i0 = 1:12
     eval(['y=SOFI2_XC',num2str(i0),'(:);'])
     [a, b] = fit(SOFI2_AC(:),y,'poly1','lower',[0,-Inf],'upper',[1,Inf],'weight',SOFI2_AC(:).^2);
     eval(['Slope.S(',num2str(i0),')=a.p1;'])
 end
% now we should have yy = -xx/2/sig^2
[a,b] = fit(Slope.Xi2',log(Slope.S)','poly1','lower',[-Inf,-Inf],'upper',[Inf,Inf]); 
sigFit = sqrt(-(1/2/a.p1));

if strcmp(saveOption,'on')
save([outputPath,'/SOFI2_XC_AC.mat'],'X*');
save([outputPath,'/Ufit.mat'],'sig');
save([outputPath,'/All_from_PSFfit.mat']);

end

end