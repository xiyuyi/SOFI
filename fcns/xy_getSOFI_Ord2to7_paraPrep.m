%xy_getSOFI_Ord2to7_paraPrep
load([LibPath,'/Tags.mat']);
load([LibPath,'/CumuMapFigsString.mat']);
load([LibPath,'/CumuMapInds.mat']);
load([LibPath,'/name1.mat']);

if sum(laglist)>0; error('non-zero time lags not enabled');end
Iminfo.size='uint16';
FileInfo.xdim=xdim;
FileInfo.ydim=ydim;
FileInfo.BMpath='./';
FileInfo.BMname=name1;
FileInfo.BMextn='tif';
FileInfo.SFpath='./';
FileInfo.SFname=['SOFI_',name1];
FileInfo.SFextn='mat';
Pro.IMinfo=Iminfo;
FileInfo.FIGnum=mvlength; clear mvlength;
Pro.Frame1=double(imread([inputPath,'/',inputName],'Index',1));
Pro.IMsize=size(Pro.Frame1);
FileInfo.IMxdim=Pro.IMsize(1);
FileInfo.IMydim=Pro.IMsize(2);
Pro.IMmean=zeros(Pro.IMsize);
SysInfo.ord=7;% order of AC_SOFI,2 to 7
SysInfo.laglist=laglist;
Pro.MaxLag=max(SysInfo.laglist(1:SysInfo.ord));
SysInfo.binLength=FileInfo.FIGnum; %# of frames per bin;
SysInfo.binNumber=floor(FileInfo.FIGnum/SysInfo.binLength); %# of bins in total;
Pro.NormFac=1;% can change.
ord = 7;
%ord2
for i0=1:length(R2(:,1)); eval(['XC2N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
%ord3
for i0=1:length(R3(:,1)); eval(['XC3N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
%ord4
for i0=1:length(R4(:,1)); eval(['XC4N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
%ord5
for i0=1:length(R5(:,1)); eval(['XC5N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
%ord6
for i0=1:length(R6(:,1)); eval(['XC6N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
%ord7
for i0=1:length(R7(:,1)); eval(['XC7N',num2str(i0),'=zeros(Pro.IMsize+4);']); end
