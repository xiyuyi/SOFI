function xy_fInterp_fSOFI(ordList, fpath, fname, mvlength, xdim, ydim, outputPath, outputName);
%% interpolation is a MUST, with periodic boundary condition considered.
mvlengthS = num2str(mvlength);
%% take fourier transform of A, manually. don't use fast fourier transform.
% calculate base vectors:
Bx = zeros(1, 2*xdim); Bx(2) = 1; Bx = fft(Bx);
By = zeros(2*ydim, 1); By(2) = 1; By = fft(By);

% 1. calculate fourier transform matrix. (without center shift)
Fx = (ones(2*xdim, 1)*Bx).^([0:1:2*xdim-1]'*ones(1, 2*xdim));
Fy = (By*ones(1, 2*ydim)).^(ones(2*ydim, 1)*[0:1:2*ydim-1]);

for ord = ordList
% 2. calculate inverse fourier transform matrix for given order. (without center shift, with interpolation of given order)
iFx = (ones((2*xdim-1)*ord + 1, 1)*conj(Bx)); iFxp = ([0:1/ord:2*xdim-1]'*ones(1, 2*xdim)); iFx = (iFx.^iFxp)./(2*xdim); 
iFy = (conj(By)*ones(1, (2*ydim-1)*ord + 1)); iFyp = (ones(2*ydim, 1)*[0:1/ord:2*ydim-1] ); iFy = (iFy.^iFyp)./(2*ydim); 


    for i0 = 1 : mvlength
        A = double(imread([fpath, '/', fname], 'Index', i0));
        FA = Fx*[A,fliplr(A);flipud(A),flipud(fliplr(A))]*Fy;
        iFA = abs(iFx*FA*iFy);
        iFA = iFA(1:(xdim-1)*ord + 1, 1:(ydim-1)*ord + 1);
        iFA = uint16(iFA);
        imwrite(uint16(iFA),[outputPath,'/',outputName], 'WriteMode', 'Append');
        disp(['Zero-padding of frame #',num2str(i0),'/',mvlengthS,', ord',num2str(ord)])
    end
end
end
