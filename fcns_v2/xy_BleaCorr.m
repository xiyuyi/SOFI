function [Node, OffSet, b] = xy_BleaCorr(para)
 fpath = para.fpath;
 fname = para.fname;
frameN = para.mvlength;
Factor = para.Factor;

%% setting Offset. and record intensity change
OffSet = 0; % this suppose to be the biggest possible range between the maximum value and minimum value
for i0 = 1:frameN
    disp(['get offset frame',num2str(i0),'/20000'])
     a = imread([fpath,'/',fname],'Index',i0);
   Min = min(a(:));
   Max = max(a(:));
   OffSet = max(Max-Min, OffSet);
    b(i0) = mean(double(a(:)));
end
%% decide break points of blocks.
% step1. calcualte the average signal 
%(should the subtraction be pixel-wise? or over all...I think it should be pixelwise.)
% now sit back and think about it.
% instinctly think should be pixelwise. need to justify it by itself.
% step2. decide the break points based on the average signal.
Node = cutNodes(b,frameN,Factor);
OffSet = double(OffSet);
end