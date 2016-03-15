



for ord=2:7;
 for i0=1:ord
   for i1=1:ord
        disp(['ord:',num2str(ord),'/7; Pack#:1/7; Pixel#',num2str(i0*10+i1)])
        eval(['str=getFigOrd',num2str(ord),'.P',num2str(i0*10+i1),';'])  
        eval(['P',num2str(i0*10+i1),'=',str,';'])
       eval(['ptp=',str,';']);
      ptp2=ExpandFrame(ord,ptp);
      
       eval(['P',num2str(i0*10+i1),'=ptp2;'])
       eval(['acP',num2str(i0*10+i1),'=ptp;'])
       
   end
 end
 disp([''])
 disp(['************************************************'])
 disp([''])
 Orig2=[0,0];
 Orig3=[-1,-1];
 Orig4=[-1,-1];
 Orig5=[-2,-2];
 Orig6=[-2,-2];
 Orig7=[-3,-3];
 
 for i0=1:ord
     for i1=1:ord
        disp(['ord:',num2str(ord),'/7; Pack#:2/7; Pixel#',num2str(i0*10+i1)])

        eval(['MoveTagsOrd',num2str(ord),'.P',num2str(i0*10+i1),'=Orig',num2str(ord),'+[',num2str(i0-1),',',num2str(i1-1),'];'])
     
     end
 end
 disp([''])
 disp(['************************************************'])
 disp([''])
 

 
 for i0=1:ord
     for i1=1:ord
         disp(['ord:',num2str(ord),'/7; Pack#:3/7; Pixel#',num2str(i0*10+i1)])
        eval(['mvPP=P',num2str(i0*10+i1),';']);eval(['mvTag=MoveTagsOrd',num2str(ord),'.P',num2str(i0*10+i1),';']);
        mvAA=MoveImage(mvPP,mvTag);
        eval(['a',num2str(i0*10+i1),'=mvAA;'])
        
        eval(['clear P',num2str(i0*10+i1)]);
     end
 end
 disp([''])
 disp(['************************************************'])
 disp([''])
 
 eval([' ActualImage.XC',num2str(ord),'=zeros(size(a11));'])
 eval([' ActualImage.XC',num2str(ord),'_rmW=zeros(size(a11));'])
 
 for i0=1:ord
    for i1=1:ord
        disp(['ord:',num2str(ord),'/7; Pack#:4/7; Pixel#',num2str(i0*10+i1)])
        
eval(['ExpandedPixels_P',num2str(i0*10+i1),'=a',num2str(i0*10+i1),';'])
eval(['ExpandedPixels_rmW_P',num2str(i0*10+i1),'=a',num2str(i0*10+i1),'./wMap.Ord',num2str(ord),'P',num2str(i0*10+i1),';'])
eval(['ActualPixels_P',num2str(i0*10+i1),'=acP',num2str(i0*10+i1),';'])
eval(['clear a',num2str(i0*10+i1)]);
eval(['clear acP',num2str(i0*10+i1)]);
    end
end
disp([''])
 disp(['************************************************'])
 disp([''])
 

 for i0=1:ord
     for i1=1:ord
         disp(['ord:',num2str(ord),'/7; Pack#:5/7; Pixel#',num2str(i0*10+i1)])
        
eval([' ActualImage.XC',num2str(ord),'=ActualImage.XC',num2str(ord),'+ExpandedPixels_P',num2str(i0*10+i1),';'])
eval([' ActualImage.XC',num2str(ord),'_rmW=ActualImage.XC',num2str(ord),'_rmW + ExpandedPixels_rmW_P',num2str(i0*10+i1),';'])

     end
 end
 disp([''])
 disp(['************************************************'])
 disp([''])
 
eval(['ACtp=getFigOrd',num2str(ord),'.PAC;'])
eval(['ActualImage.AC',num2str(ord),'=',ACtp,';'])
l=who;
x1=[' '];
for i0=1:length(l)
  str=l{i0};
  if length(str)>length(['ActualPixels_'])
     disp(['ord:',num2str(ord),'/7; Pack#:6/7; Name#',num2str(i0),'/',num2str(length(l))])
       
     if strcmp(str(1:length(['ActualPixels_'])),['ActualPixels_'])
     x1=[x1,' ',str];
     end
  end
end
disp([''])
 disp(['************************************************'])
 disp([''])
 
x2=[' '];
for i0=1:length(l)
    disp(['ord:',num2str(ord),'/7; Pack#:7/7; Name#',num2str(i0),'/',num2str(length(l))])
        
  str=l{i0};
  if length(str)>length(['ExpandedPixels_'])
     if strcmp(str(1:length(['ExpandedPixels_'])),['ExpandedPixels_'])
     x2=[x2,' ',str];
     end
  end
end

disp([' '])
 disp(['************************************************'])
 disp(['saving ord# ',num2str(ord),'...'])
eval(['save ',outputPath,'/SOFIforFit_XC',num2str(ord),'.mat wMap Xi2Map wMatrix Xi2Matrix ActualImage ',x1,' ',x2,''])
eval(['clear  ActualImage ',x1,' ',x2,''])
 disp([' Finish ord# ',num2str(ord)])
 disp(['************************************************'])
 
 disp([' '])
 pause(1)
 
end
%eval(['ExpandedSOFI.XC',num2str(ord),'P',num2str(i0*10+i1),'=ptp2;'])