function cumuSet = xy_getCumuOrd2to7(para)
%% prepare for parameters
      Node = para.Node;
  mvlength = para.mvlength;
      xdim = para.xdim;
      ydim = para.ydim;
 inputPath = para.inputPath;
 inputName = para.inputName;
outputPath = para.outputPath;
   laglist = para.laglist;
   LibPath = para.LibPath;


 binNumber = length(Node)-1;
 xy_paraPrepare
 for binInds = 1:binNumber % go through each bin
     ImMean = zeros(xdim, ydim);
     for i1 = Node(binInds)+1 : Node(binInds+1)
        % read a frame
        a0 = double(imread([inputPath,'/',inputName],'Index',i1));
        % add up togeter 
        ImMean = ImMean + a0;
     end
     ImMean = ImMean./(Node(binInds+1)-Node(binInds));
     
     clear imt;
     for i1 = Node(binInds)+1 : Node(binInds+1)
         disp(['calculate correlations up to frame #',num2str(i1),'/',num2str(Node(binInds+1)),'---->',num2str(para.mvlength),';     bin #',num2str(binInds),'/',num2str(binNumber)])
         % read the current frame
         im = double(imread([inputPath,'/',inputName],'Index',i1)) - ImMean;
         % convert frames into the 17 versions with edges
         for imtag=1:17
             imt=im;
             edge=edges(imtag,:);
             imt=[zeros(xdim,edge(1)),imt,zeros(xdim,edge(2))];
             imt=[zeros(edge(3),ydim+4);imt;zeros(edge(4),ydim+4)];
             eval(['im',num2str(imtag),'=imt;'])
         end
         clear imt imtag
        %% ***** individual correlations and cross correlations ****
        %%
        %%
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
     end
     %take the average from all the sum values.
     NNN = Node(binInds+1) - Node(binInds);
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
     % finished calcualting all the correlations within the bin
     
     % construct cumulants within the bin
     xy_combineCumulants
     save([outputPath,'/Bin',num2str(binInds),'_results.mat'],'ActualImageOrd*')
     1;
     clear ActualImage*
     % clear all parameters.
     %ord2
     for i0=1:length(R2(:,1)); eval(['XC2N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
     %ord3
     for i0=1:length(R3(:,1)); eval(['XC3N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
     %ord4
     for i0=1:length(R4(:,1)); eval(['XC4N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
     %ord5
     for i0=1:length(R5(:,1)); eval(['XC5N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
     %ord6
     for i0=1:length(R6(:,1)); eval(['XC6N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
     %ord7
     for i0=1:length(R7(:,1)); eval(['XC7N',num2str(i0),'=zeros(Pro.IMsize+4);']); end

 end
 
 
 %% get weighted-average of cumulants
 % get weighting factors
 w = zeros(1, binNumber);
 for i0 = 1:binNumber
     w(i0) = Node(i0+1) - Node(i0);
 end
 w = w./sum(w);
 
 % prepare cumuSet    
 for ord = 2 : 7
     xSize = (xdim+5)*ord-1;
     ySize = (ydim+5)*ord-1;
     eval(['cumuSet.AC',num2str(ord),'=zeros(xdim+4, ydim+4);'])
     eval(['cumuSet.XC',num2str(ord),'=zeros(xSize, ySize);'])
 end
 
 % now calculate the weight average of cumulants
 for i0 = 1:binNumber
     load([outputPath,'/Bin',num2str(i0),'_results.mat'],'ActualImageOrd*')
     disp(['bin# ',num2str(i0)])
     for ord=2:7
     eval(['cumuSet.AC',num2str(ord),'= ActualImageOrd',num2str(ord),'.AC',num2str(ord),' + cumuSet.AC',num2str(ord),';'])
     eval(['cumuSet.XC',num2str(ord),'= ActualImageOrd',num2str(ord),'.XC',num2str(ord),' + cumuSet.XC',num2str(ord),';'])
     end
     clear ActualImage*
 end
 
end