function output=ExpandFrame(ord,im1)
% ExpandFrame
%   get the expanded(reshaped into the frame with holes) XC pixel frames from the compact version
%   
%
% SYNTAX:
%   ExpandFrame(ord, im1)
%
% 
% INPUT:
%   ord    - order of the XC pixels.
%   im1    - input frame (size is initla size, have the same size with original movie frames).
%   
% OUTPUT:
%   output - The expaned frames, so the dimension becomes ord*(initial
%            size)+(ord-1)
%
% DESCRIPTION:
%   
%   That's it.


% By Xiyu Yi, University of California, Los Angeles. 2013/May




[xdim,ydim]=size(im1);
tp1=zeros((ord-1)*xdim,ydim);
tp2=[im1;tp1];
tp3=reshape(tp2,xdim,ydim*ord);
tp4=tp3';
[xdim2,ydim2]=size(tp4);
tp5=zeros((ord-1)*xdim2,ydim2);
tp6=[tp4;tp5];
tp7=reshape(tp6,xdim2,ydim2*ord);
tp8=tp7';
[xdim3,ydim3]=size(tp8);
tp9=[zeros(ord-1,ydim3);tp8];
tp10=[zeros(xdim3+ord-1,ord-1),tp9];
output=tp10;
