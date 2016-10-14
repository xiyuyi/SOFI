function output = xy_ldrc2(XC, XCord, Mask, windowSize)
s = windowSize;
ord = XCord;
[xdim, ydim] =  size(Mask);
[xdimXC, ydimXC] =  size(XC);
if xdim + ydim - xdimXC - ydimXC ==0
    maskR = Mask;
else

[X,Y]   = meshgrid([1:ord:(ydim-1)*ord+1], [1:ord:(xdim-1)*ord+1]);
[Xq,Yq] = meshgrid([1:1:(ydim-1)*ord+1],   [1:1:(xdim-1)*ord+1]  );

maskR=interp2(X, Y, Mask, Xq, Yq); %so this is the resized reference mask.
end
ldrc = zeros(xdimXC, ydimXC);
topMap = zeros(xdimXC-s+1, ydimXC-s+1);

for i0=1:1:xdimXC-s+1
    disp(['Pixel Loc:',num2str([i0,i0+s-1])])
  for i1=1:1:ydimXC-s+1 
     Top=max(max((maskR(i0:i0+s-1, i1:i1+s-1))));%find upper bound of this window.
     w = XC(i0:i0+s-1, i1:i1+s-1); % take the window whose dynamic range should be compressed.
     normw = (w-min(w(:)))./(max(w(:))-min(w(:)));% normalize this chosen window to be in the range of 0~1
     imx=normw.*Top; % linear rescale of the window to reach the maximum value of the reference window
     ldrc(i0:i0+s-1,i1:i1+s-1)=ldrc(i0:i0+s-1,i1:i1+s-1)+imx;
     topMap(i0,i1)=Top;
  end
end
% now bring up the dimmed edge, because of the different weight in the
% summation
rwMask = ones(xdimXC, ydimXC).*s^2;
% part1 corners
CC = zeros(s,s);
for i0 = 1:s
    for i1 = 1:s
        CC(i0, i1) = i0.*i1;
    end
end
rwMask(1:s, 1:s)=CC;
rwMask(end-s+1:end, 1:s) = flipud(CC);
rwMask(1:s, end-s+1:end) = fliplr(CC);
rwMask(end-s+1:end,end-s+1:end) = rot90(CC,2);

% part2 edges
for i0 = 1:s
    v = s*i0;
    rwMask(i0,s+1:end-s)=v;
    rwMask(end-i0+1,s+1:end-s)=v;
    rwMask(s+1:end-s,i0)=v;
    rwMask(s+1:end-s,end-i0+1)=v;
end

% extend topMap
topMapF = zeros(xdimXC, ydimXC);
topMapF(s/2+1:end-s/2+1, s/2+1:end-s/2+1)=topMap;

% corners
topMapF(1:s/2,1:s/2)=topMap(1,1);
topMapF(1:s/2,end-s/2+1:end)=topMap(1,end);
topMapF(end-s/2+1:end,1:s/2)=topMap(end,1);
topMapF(end-s/2+1:end,end-s/2+1:end)=topMap(end,end);

% edges
topMapF(s/2:end-s/2,1:s/2) = topMap(:,1)*ones(1,s/2);%left edge
topMapF(1:s/2,s/2:end-s/2) = ones(s/2,1)*topMap(1,:);%upper edge
topMapF(s/2:end-s/2,end-s/2+1:end) = topMap(:,end)*ones(1,s/2);%right edge
topMapF(end-s/2+1:end,s/2:end-s/2) = ones(s/2,1)*topMap(end,:);% bottom edge

H = fspecial('gaussian',[s,s],s/20);
[a,b]=size(topMapF);
t = [topMapF,fliplr(topMapF);flipud(topMapF),rot90(topMapF,2)];
t = imfilter(t,H,'circular');
topMapF = t(1:a, 1:b);

output.topMap = topMapF;
output.ldrc0  = ldrc;
output.ldrc   = ldrc./rwMask;
output.maskR  = maskR;
output.ldrcW  = zeros(size(ldrc));
output.rwMask = rwMask;
output.ldrcW  = output.ldrc.*topMapF;

end