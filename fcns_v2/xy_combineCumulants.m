for ord=2:7;
 for i0=1:ord
   for i1=1:ord
        eval(['str=getFigOrd',num2str(ord),'.P',num2str(i0*10+i1),';'])  
        eval(['P',num2str(i0*10+i1),'=',str,';'])
        eval(['ptp=',str,';']);
        ptp2 = ExpandFrame(ord,ptp);
        eval(['P',num2str(i0*10+i1),'=ptp2;'])
        eval(['acP',num2str(i0*10+i1),'=ptp;'])    
   end
 end
 Orig2=[0,0];
 Orig3=[-1,-1];
 Orig4=[-1,-1];
 Orig5=[-2,-2];
 Orig6=[-2,-2];
 Orig7=[-3,-3];
 for i0=1:ord
     for i1=1:ord
%        disp(['ord:',num2str(ord),'/7; Pack#:2/7; Pixel#',num2str(i0*10+i1)])
        eval(['MoveTagsOrd',num2str(ord),'.P',num2str(i0*10+i1),'=Orig',num2str(ord),'+[',num2str(i0-1),',',num2str(i1-1),'];'])
     end
 end
 for i0=1:ord
     for i1=1:ord
%         disp(['ord:',num2str(ord),'/7; Pack#:3/7; Pixel#',num2str(i0*10+i1)])
        eval(['mvPP=P',num2str(i0*10+i1),';']);eval(['mvTag=MoveTagsOrd',num2str(ord),'.P',num2str(i0*10+i1),';']);
        mvAA=MoveImage(mvPP,mvTag);
        eval(['a',num2str(i0*10+i1),'=mvAA;'])
        eval(['clear P',num2str(i0*10+i1)]);
     end
 end
 eval([' ActualImage.XC',num2str(ord),'=zeros(size(a11));'])
 for i0=1:ord
    for i1=1:ord
%        disp(['ord:',num2str(ord),'/7; Pack#:4/7; Pixel#',num2str(i0*10+i1)])
eval(['ActualImage.XC',num2str(ord),'=ActualImage.XC',num2str(ord),'+a',num2str(i0*10+i1),';'])
eval(['clear acP',num2str(i0*10+i1)]);
    end
 end
eval(['ACtp=getFigOrd',num2str(ord),'.PAC;'])
eval(['ActualImage.AC',num2str(ord),'=',ACtp,';'])
eval(['ActualImageOrd',num2str(ord),'=ActualImage;'])
clear ActualImage
end
