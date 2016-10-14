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
     for ord=2:7
     load([outputPath,'/Bin',num2str(i0),'_results.mat'],'ActualImageOrd*')
     eval(['cumuSet.AC',num2str(ord),'= ActualImageOrd',num2str(ord),'.AC',num2str(ord),' + cumuSet.AC',num2str(ord),';'])
     eval(['cumuSet.XC',num2str(ord),'= ActualImageOrd',num2str(ord),'.XC',num2str(ord),' + cumuSet.XC',num2str(ord),';'])
     %clear ActualImage*
 end
 