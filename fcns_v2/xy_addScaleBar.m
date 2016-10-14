function [outim, outv] = xy_addScaleBar(im,xini,xend,yini,yend)
v=max(abs(im(:)));
ind = find(abs(im(:))==max(abs(im(:))));
if im(ind(1))<=0
v = -v;
end
im(xini:xend,yini:yend)=v;
outim = im;
outv = v;

end