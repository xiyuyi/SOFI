ExpandFrameV2(2,ones(3));% just to call this function once so it'll be compiled
MoveImageV2(ones(4),[0,0]);% just to call this function once so it'll be compiled
for ord=2:7;
    Orig2 = [0,0];
    Orig3 = [-1,-1];
    Orig4 = [-1,-1];
    Orig5 = [-2,-2];
    Orig6 = [-2,-2];
    Orig7 = [-3,-3];
    eval([' ActualImage.XC',num2str(ord),'=zeros(',num2str(ord*(xdim+4)+(ord-1)),',',num2str(ord*(ydim+4)+(ord-1)),');']);
 for i0=1:ord
   for i1=1:ord
        eval(['str=getFigOrd',num2str(ord),'.P',num2str(i0*10+i1),';'])  
        eval(['acP',num2str(i0*10+i1),'=',str,';'])
        eval(['P',num2str(i0*10+i1),'=ExpandFrameV2(ord,acP',num2str(i0*10+i1),');'])    
        eval(['MoveTagsOrd',num2str(ord),'.P',num2str(i0*10+i1),'=Orig',num2str(ord),'+[',num2str(i0-1),',',num2str(i1-1),'];'])
        eval(['mvTag=MoveTagsOrd',num2str(ord),'.P',num2str(i0*10+i1),';']);
        eval(['ActualImage.XC',num2str(ord),'=ActualImage.XC',num2str(ord),'+MoveImageV2(P',num2str(i0*10+i1),',mvTag);'])
        eval(['clear acP',num2str(i0*10+i1)]);
        eval(['clear P',num2str(i0*10+i1)]);
    end
 end
    eval(['ACtp=getFigOrd',num2str(ord),'.PAC;'])
    eval(['ActualImage.AC',num2str(ord),'=',ACtp,';'])
    eval(['ActualImageOrd',num2str(ord),'=ActualImage;'])
    clear ActualImage
end
