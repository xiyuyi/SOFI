function output = cutNodePrep(para) % getting the average signal decrease profile as a function of time.
addpath(genpath(para.LibPath));
frameN = para.mvlength;
ip = para.inputPath;
fn = para.inputName;
a = imread([ip,'/',fn],'Index',1);
[xdim, ydim] = size(a);
ImMean = zeros(xdim, ydim);
OffSet = 0; % this suppose to be the biggest possible range between the maximum value and minimum value
b = zeros(1, frameN);
for i0 = 1:frameN
    disp(['get offset frame',num2str(i0),'/',num2str(frameN)])
    a = imread([ip,'/',fn],'Index',i0);
    Min = min(a(:));
    Max = max(a(:));
    b(i0) = mean(double(a(:)));
    ImMean = ImMean + double(a);
end
ImMean = ImMean./frameN;
output.b = b;
output.xdim = xdim;
output.ydim = ydim;
output.ImMean = ImMean;
end