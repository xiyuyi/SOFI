function [RhoMap, RhoTru, epsMap] = xy_getPSF_paraEsti(xdim,ydim,mvlength,inputPath,inputName,outputPath,ImMeanLoc,sig,saveOption,tauSeries);
U = fspecial('gaussian',[301,301],sig);
load(ImMeanLoc);
mvlengthS = num2str(mvlength);
if sum(tauSeries) == 0
    for ord = 2:7; eval(['m',num2str(ord),' = zeros(xdim, ydim);']); end
    for i0 = 1:mvlength
        disp(['processing frame #',num2str(i0),'/',mvlengthS])
        im = double(imread([inputPath,'/',inputName],'Index',i0)) - ImMean;
        for ord = 2:7; eval(['m',num2str(ord),' = m',num2str(ord),' + im.^',num2str(ord),';']); end
    end
    for ord = 2:7; eval(['m',num2str(ord),' = m',num2str(ord),'./mvlength;']); end
    % calculate high order cumulants at tau=0.
    AC2 = m2;
    AC3 = m3;
    AC4 = m4 - 3.*m2.^2;
    AC5 = m5 - 10.*m3.*m2;
    AC6 = m6 - 15.*m4.*m2 - 10.*m3.^2 + 30.*m2.^3;
    AC7 = m7 - 21.*m5.*m2 - 35.*m4.*m3 + 210.*m3.*m2.^2;
else
    %% prepare empty frame for each partition of m2, m3, m4, m5, and single ones for m6, m7
    Emp = zeros(xdim, ydim); 
    mvlengthEF = mvlength-max(tauSeries);
    % prepare all partitions of m2, m3, m4, m5
    for j0 = 1:7-1; for j1 = j0+1 : 7; eval(['P2im',num2str(j0),num2str(j1),'=Emp;']); end; end
    for j0 = 1:7-2; for j1 = j0+1 : 6; for j2 = j1+1 : 7; eval(['P3im',num2str(j0),num2str(j1),num2str(j2),'=Emp;']); end;end; end
    for j0 = 1:7-3; for j1 = j0+1 : 5; for j2 = j1+1 : 6; for j3 = j1+1 : 7; eval(['P4im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),'=Emp;']); end; end;end; end
    for j0 = 1:7-4; for j1 = j0+1 : 4; for j2 = j1+1 : 5; for j3 = j1+1 : 6; for j4 = j1+1 : 7; eval(['P5im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),num2str(j4),'=Emp;']); end; end; end;end; end
    P6im123456 = Emp;
    P7im1234567 = Emp;
    % now calculate all the partitions of m2, m3, m4, m5, m6, m7
    for i0 = 1:mvlengthEF
        disp(['processing frame #',num2str(i0),'/',mvlengthS])
        % read out image Ind 1~7
        for tauN = 1:7
        im = double(imread([inputPath,'/',inputName],'Index',i0+tauSeries(tauN))) - ImMean;
        eval(['im',num2str(tauN),'=im;'])
        end
        % go through all partitions of m2, m3, m4, m5
        for j0 = 1:7-1; for j1 = j0+1 : 7; eval(['P2im',num2str(j0),num2str(j1),'= P2im',num2str(j0),num2str(j1),' + im',num2str(j0),'.*im',num2str(j1),';']); end; end
        for j0 = 1:7-2; for j1 = j0+1 : 6; for j2 = j1+1 : 7; eval(['P3im',num2str(j0),num2str(j1),num2str(j2),'=P3im',num2str(j0),num2str(j1),num2str(j2),'+im',num2str(j0),'.*im',num2str(j1),'.*im',num2str(j2),';']); end;end; end
        for j0 = 1:7-3; for j1 = j0+1 : 5; for j2 = j1+1 : 6; for j3 = j1+1 : 7; eval(['P4im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),'=P4im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),' + im',num2str(j0),'.*im',num2str(j1),'.*im',num2str(j2),'.*im',num2str(j3),';']); end; end;end; end
        for j0 = 1:7-4; for j1 = j0+1 : 4; for j2 = j1+1 : 5; for j3 = j1+1 : 6; for j4 = j1+1 : 7; eval(['P5im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),num2str(j4),'=P5im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),num2str(j4),'+im',num2str(j0),'.*im',num2str(j1),'.*im',num2str(j2),'.*im',num2str(j3),'.*im',num2str(j4),';']); end; end; end;end; end
        P6im123456 = P6im123456 + im1.*im2.*im3.*im4.*im5.*im6;
        P7im1234567 = P7im1234567 + im1.*im2.*im3.*im4.*im5.*im6.*im7;
    end
    % take time average of all partitions of m2, m3, m4, m5
    for j0 = 1:7-1; for j1 = j0+1 : 7; eval(['P2im',num2str(j0),num2str(j1),'=P2im',num2str(j0),num2str(j1),'./mvlengthEF;']); end; end
    for j0 = 1:7-2; for j1 = j0+1 : 6; for j2 = j1+1 : 7; eval(['P3im',num2str(j0),num2str(j1),num2str(j2),'=P3im',num2str(j0),num2str(j1),num2str(j2),'./mvlengthEF;']); end;end; end
    for j0 = 1:7-3; for j1 = j0+1 : 5; for j2 = j1+1 : 6; for j3 = j1+1 : 7; eval(['P4im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),'=P4im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),'./mvlengthEF;']); end; end;end; end
    for j0 = 1:7-4; for j1 = j0+1 : 4; for j2 = j1+1 : 5; for j3 = j1+1 : 6; for j4 = j1+1 : 7; eval(['P5im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),num2str(j4),'=P5im',num2str(j0),num2str(j1),num2str(j2),num2str(j3),num2str(j4),'./mvlengthEF;']); end; end; end;end; end
    P6im123456 = P6im123456./mvlengthEF;
    P7im1234567 = P7im1234567./mvlengthEF;
    
    % calculate high order cumulants at tau~=0.
    AC2 = P2im12;
    AC3 = P3im123;
    AC4 = P4im1234  - P2im12.*P2im34 - P2im13.*P2im24 - P2im23.*P2im14;
    AC5 = P5im12345 - P2im12.*P3im345 - P2im13.*P3im245 - P2im14.*P3im235 - P2im15.*P3im234 - P2im23.*P3im145 - P2im24.*P3im135 - P2im25.*P3im134 - P2im34.*P3im125 - P2im35.*P3im124 - P2im45.*P3im123;
    % calculate AC6 partition of 4+2, 3+3, 2+2+2; then combine
        AC6P42 = Emp;
        for j0 = 1:5; for j1 = j0+1:6; P4Inds = setdiff([1:6],[j0,j1]);eval(['AC6P42 = AC6P42 + P2im',num2str(j0*10 + j1),'.*P4im',num2str(P4Inds(1)*1000+P4Inds(2)*100+P4Inds(3)*10+P4Inds(4)),';']);end;end;
        AC6P33 = Emp;
        for j0 = 2:5; for j1 = j0+1:6; P3Inds = setdiff([2:6],[1,j0,j1]);eval(['AC6P33 = AC6P33 + P3im1',num2str(j0),num2str(j1),'.*P3im',num2str(P3Inds(1)),num2str(P3Inds(2)),num2str(P3Inds(3)),';']);end;end
        AC6P222 = Emp;
        for j0 = 2:6; P22Inds = setdiff([2:6],[j0]); xx1 = num2str(P22Inds(1)); xx2 = num2str(P22Inds(2)); xx3 = num2str(P22Inds(3)); xx4 = num2str(P22Inds(4));
            eval(['AC6P222 = AC6P222 + P2im',num2str(10+j0),'.*P2im',xx1,xx2,'.*P2im',xx3,xx4,' + P2im',num2str(10+j0),'.*P2im',xx1,xx3,'.*P2im',xx2,xx4,' + P2im',num2str(10+j0),'.*P2im',xx1,xx4,'.*P2im',xx2,xx3,';']);end;
    AC6 = P6im123456 - AC6P42 - AC6P33 + 2.*AC6P222;
    % calculate AC7 partition of 5+2, 4+3, 3+2+2, then combine.
        AC7P52 = Emp;
        for j0 = 1:6; for j1 = j0+1:7;P5Inds = setdiff([1:7],[j0,j1]);
            eval(['AC7P52 = AC7P52 + P5im',num2str(P5Inds(1)),num2str(P5Inds(2)),num2str(P5Inds(3)),num2str(P5Inds(4)),num2str(P5Inds(5)),'.*P2im',num2str(j0*10+j1),';']);end;end
        AC7P43 = Emp;
        for j0 = 1:5; for j1 = j0+1:6; for j2 = j1+1:7; P4Inds = setdiff([1:7],[j0,j1,j2]);
            eval(['AC7P43 = AC7P43 + P4im',num2str(P4Inds(1)),num2str(P4Inds(2)),num2str(P4Inds(3)),num2str(P4Inds(4)),'.*P3im',num2str(j0*100+j1*10+j2),';']);end;end;end
        AC7P322 = Emp;
        for j0 = 1:5; for j1 = j0+1:6; for j2 = j1+1:7; P22Inds = setdiff([1:7],[j0,j1,j2]);xx1 = num2str(P22Inds(1)); xx2 = num2str(P22Inds(2)); xx3 = num2str(P22Inds(3)); xx4 = num2str(P22Inds(4));
            eval(['AC7P322 = AC7P322 + P3im',num2str(j0*100+j1*10+j2),'.*P2im',xx1,xx2,'.*P2im',xx3,xx4,'+ P3im',num2str(j0*100+j1*10+j2),'.*P2im',xx1,xx3,'.*P2im',xx2,xx4,'+ P3im',num2str(j0*100+j1*10+j2),'.*P2im',xx1,xx4,'.*P2im',xx2,xx3,';']);end;end;end
    
    AC7 = P7im1234567 - AC7P52 - AC7P43 +2.*AC7P322;
end
Uf3 = fspecial('gaussian',[301,301],sig/sqrt(6));       Uf3 = Uf3./max(Uf3(:));     C3cv = imfilter(AC3,Uf3);
Uf4 = fspecial('gaussian',[301,301],sig/sqrt(4));       Uf4 = Uf4./max(Uf4(:));     C4cv = imfilter(AC4,Uf4);
Uf5 = fspecial('gaussian',[301,301],sig/sqrt(10/3));    Uf5 = Uf5./max(Uf5(:));     C5cv = imfilter(AC5,Uf5);
Uf6 = fspecial('gaussian',[301,301],sig/sqrt(3));       Uf6 = Uf6./max(Uf6(:));     C6cv = imfilter(AC6,Uf6);
Uf7 = fspecial('gaussian',[301,301],sig/sqrt(14/5));    Uf7 = Uf7./max(Uf7(:));     C7cv = imfilter(AC7,Uf7);

X3 = C3cv./(AC2+eps);
X4 = C4cv./(AC2+eps);
X5 = C5cv./(AC2+eps);
X6 = C6cv./(AC2+eps);
X7 = C7cv./(AC2+eps);
[RhoMap, RhoTru, epsMap] = xy_getRhoEpsi(X3, X4, X5, X6, X7, 1000);
end
