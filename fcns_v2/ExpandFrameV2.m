function output=ExpandFrameV2(ord,im1)
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



output = zeros(size(im1).*ord + (ord - 1));
output(1:ord:end-(ord-1),1:ord:end-(ord-1)) = im1;

