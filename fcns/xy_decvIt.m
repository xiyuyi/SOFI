% this script demonstrate iterative deconvolution method with shrinking
% kernal.
function output = xy_decvIt(para)
J0 = para.J0; 
PSF0 = para.PSF0;
lambda = para.lambda;
ItN = para.ItN;

J = J0;
for i0 = 1:ItN
    disp(['iteration #',num2str(i0),'/',num2str(ItN)])
    alpha = lambda.^i0/(lambda-1);
    [J,PSF] = deconvblind(J,PSF0.^alpha,1);
end

output = J;
end

