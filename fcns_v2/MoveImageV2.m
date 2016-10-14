function imin=MoveImageV2(imin,MoveR)
[xdim, ydim] = size(imin);

xini1 = max(1, MoveR(1)+1); xend1 = min(xdim, xdim + MoveR(1));
xini2 = max(1,-MoveR(1)+1); xend2 = min(xdim, xdim - MoveR(1));

yini1 = max(1, MoveR(2)+1); yend1 = min(ydim, ydim + MoveR(2));
yini2 = max(1,-MoveR(2)+1); yend2 = min(ydim, ydim - MoveR(2));

imin(xini1:xend1, yini1:yend1) = imin(xini2:xend2, yini2:yend2); 



