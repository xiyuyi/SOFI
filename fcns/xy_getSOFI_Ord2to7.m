function xy_getSOFI_Ord2to7(xdim,ydim,mvlength,inputPath,inputName,outputPath,laglist,LibPath,sigFit);
%% prepare for parameters
addpath(LibPath);
xy_getSOFI_Ord2to7_paraPrep
%% calculating ImMean within each bin
for i0=1:SysInfo.binNumber
    disp(['calculate Mean image within bin #',num2str(i0),'/',num2str(SysInfo.binNumber)])
    i1end = min([(i0*SysInfo.binLength), (FileInfo.FIGnum-Pro.MaxLag)]);
    i1start = (i0-1)*SysInfo.binLength+1;
    Pro.IMtemp=zeros(Pro.IMsize);
    
    for i1=i1start : i1end
        % read a frame
        a0 = double(imread([inputPath,'/',inputName],'Index',i1));
        Pro.IMtemp=Pro.NormFac.*reshape(cast(a0,'double'),FileInfo.IMxdim,FileInfo.IMydim);
        % add up togeter 
        Pro.IMmean=Pro.IMtemp+Pro.IMmean;
    end% calculate mean within the bin 
    Pro.IMmean=Pro.IMmean./(i1end-i1start+1);
    
    clear imt;
    % start to calculte SOFI within this bin
    for i1=i1start : i1end
        %save data2.mat
        disp(['calculate correlations up to frame #',num2str(i1),'/',num2str(i1end)])
        % read the frames
        im = double(imread([inputPath,'/',inputName],'Index',i1)) - Pro.IMmean;
        % convert frames into the 17 versions with edges
        for imtag=1:17
            imt=im;
            edge=edges(imtag,:);
            imt=[zeros(xdim,edge(1)),imt,zeros(xdim,edge(2))];
            imt=[zeros(edge(3),ydim+4);imt;zeros(edge(4),ydim+4)];
            eval(['im',num2str(imtag),'=imt;'])
        end
    clear imt imtag
    %***** individual ****
    % calculate XC2N(1~ 96) based on: im1~17 and R2
        for xc2tag=1:length(R2(:,1))
            eval(['XC2N',num2str(xc2tag),'Temp = im',num2str(R2(xc2tag,1)),'.*im',num2str(R2(xc2tag,2)),';'])
            eval(['XC2N',num2str(xc2tag),' = XC2N',num2str(xc2tag),'+XC2N',num2str(xc2tag),'Temp;'])
        end
 
        for xc3tag=1:length(R3(:,1))
            eval(['XC3N',num2str(xc3tag),'Temp = XC2N',num2str(tag3in21(xc3tag,1)),'Temp.*im',num2str(tag3in21(xc3tag,2)),';'])
            eval(['XC3N',num2str(xc3tag),' = XC3N',num2str(xc3tag),'+XC3N',num2str(xc3tag),'Temp;'])
        end
 
        for xc4tag=1:1:length(R4(:,1))
            eval(['XC4N',num2str(xc4tag),'Temp = XC2N',num2str(tag4in22(xc4tag,1)),'Temp.*XC2N',num2str(tag4in22(xc4tag,2)),'Temp;'])
            eval(['XC4N',num2str(xc4tag),'=XC4N',num2str(xc4tag),'+XC4N',num2str(xc4tag),'Temp;'])
        end
 
        for xc5tag=1:length(R5(:,1))
            eval(['XC5N',num2str(xc5tag),'Temp = XC2N',num2str(tag5in23(xc5tag,1)),'Temp.*XC3N',num2str(tag5in23(xc5tag,2)),'Temp;'])
            eval(['XC5N',num2str(xc5tag),'=XC5N',num2str(xc5tag),'+XC5N',num2str(xc5tag),'Temp ;'])
        end
 
        for xc6tag=1:length(R6(:,1))
            eval(['XC6N',num2str(xc6tag),'Temp = XC2N',num2str(tag6in24(xc6tag,1)),'Temp.*XC4N',num2str(tag6in24(xc6tag,2)),'Temp;'])
            eval(['XC6N',num2str(xc6tag),'=XC6N',num2str(xc6tag),'+XC6N',num2str(xc6tag),'Temp;'])
        end
 
        for xc7tag=1:length(R7(:,1))
            eval(['XC7N',num2str(xc7tag),'Temp = XC3N',num2str(tag7in34(xc7tag,1)),'Temp.*XC4N',num2str(tag7in34(xc7tag,2)),'Temp;'])
            eval(['XC7N',num2str(xc7tag),'= XC7N',num2str(xc7tag),'+XC7N',num2str(xc7tag),'Temp;'])
        end
    end% finished calcualting all the sofi parameters within the bin

%take the average from all the sum values.
NNN=i1end-i1start+1;
for xc2tag=1:length(R2(:,1))
     eval(['XC2N',num2str(xc2tag),' = XC2N',num2str(xc2tag),'./NNN;'])
 end
 
 for xc3tag=1:length(R3(:,1))
    eval(['XC3N',num2str(xc3tag),' = XC3N',num2str(xc3tag),'./NNN;'])
 end
 
 for xc4tag=1:1:length(R4(:,1))
   eval(['XC4N',num2str(xc4tag),'=XC4N',num2str(xc4tag),'./NNN;'])
 end
 
 for xc5tag=1:length(R5(:,1))
   eval(['XC5N',num2str(xc5tag),'=XC5N',num2str(xc5tag),'./NNN;'])
 end
 
 for xc6tag=1:length(R6(:,1))
 eval(['XC6N',num2str(xc6tag),'=XC6N',num2str(xc6tag),'./NNN;'])
 end
 
 for xc7tag=1:length(R7(:,1))
      eval(['XC7N',num2str(xc7tag),'= XC7N',num2str(xc7tag),'./NNN;'])
 end
end


% calculate all the AC2 AC3 AC4 AC5 depend on the sofi order
load CumuMapInds.mat
load CumuMapFigsString.mat
[Xi2Map, Xi2Matrix, wMap, wMatrix] = xy_getSOFI_Ord2to7_getXi2Map_wMap(CumuMapInd, tags, sigFit)
x=zeros(size(XC2N1));

xy_getSOFI_CombinePixelsOrdAll
xy_getSOFI_CombinePixelsOrdAll_MomentsLike


end