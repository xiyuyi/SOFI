function output = xyfcns_fInterp2(A,ixdim,iydim);
% the originla grids are assumed to be 0 to xdim-1, 0 to ydim-1.
[xdim, ydim] = size(A);

% calcualte FT matrix.
Bx = zeros(1, 2*xdim); Bx(2) = 1; Bx = fft(Bx);
By = zeros(2*ydim, 1); By(2) = 1; By = fft(By);
Ux = (ones(2*xdim, 1)*Bx).^([0:1:2*xdim-1]'*ones(1, 2*xdim));
Uy = (By*ones(1, 2*ydim)).^(ones(2*ydim, 1)*[0:1:2*ydim-1]);
% take fourier transform
FA = Ux*[A,fliplr(A);flipud(A),rot90(A,2)]*Uy;

% calculate iFT matrix.
iUx = (ones(2*ixdim, 1)*conj(Bx)).^((([0:1:2*ixdim-1]').*(2*xdim-1)./(2*ixdim-1))*ones(1, 2*xdim));
iUy = (conj(By)*ones(1, 2*iydim)).^(ones(2*ydim, 1)*(([0:1:2*iydim-1]).*(2*ydim-1)./(2*iydim-1)));
iFA = iUx*FA*iUy./(ixdim*iydim);
output = abs(iFA(1:ixdim, 1:iydim));
end