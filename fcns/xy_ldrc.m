function output = xy_ldrc(XC, XCord, Mask, windowSize)
s = windowSize;
ord = XCord;
[xdim, ydim] =  size(Mask);
[xdimXC, ydimXC] =  size(XC);
if xdim + ydim -xdimXC-ydimXC ==0
    maskR = Mask;
else

[X,Y]=meshgrid([1:ord:(ydim-1)*ord+1],[1:ord:(xdim-1)*ord+1]);
[Xq,Yq]=meshgrid([1:1:(ydim-1)*ord+1],[1:1:(xdim-1)*ord+1]);

maskR=interp2(X,Y,Mask,Xq,Yq); %so this is the resized reference mask.
end
ldrc = zeros(xdimXC, ydimXC);
topMap = zeros(xdimXC-s+1, ydimXC-s+1);
for i0=1:1:xdimXC-s+1
 %   for i0 = 156
    disp(['Pixel Loc:',num2str([i0,i0+s-1])])
  for i1=1:1:ydimXC-s+1 
  %    for i1 = 156
     Top=max(max((maskR(i0:i0+s-1, i1:i1+s-1))));%find upper bound of this window.
     Bot=min(min((maskR(i0:i0+s-1, i1:i1+s-1))));%find lower bound of this window.
     w = XC(i0:i0+s-1, i1:i1+s-1); % take the window whose dynamic range should be compressed.
     normw = (w-min(w(:)))./(max(w(:))-min(w(:)));
     imx=normw.*Top; % linear rescale of the window
     ldrc(i0:i0+s-1,i1:i1+s-1)=ldrc(i0:i0+s-1,i1:i1+s-1)+imx;
     %figure(1);imshow(ldrc,[]);colormap(pink);drawnow;
     topMap(i0,i1)=Top;
  end
end
output.topMap = topMap;
output.ldrc = ldrc;
output.maskR = maskR;
end