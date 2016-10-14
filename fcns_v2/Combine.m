%Combine
NN=96;

a=zeros(129,129,NN);
for binN=1:NN
    binN
    load(['Bin',num2str(binN),'_results.mat'],'ActualImageOrd4');
    a(:,:,binN)=ActualImageOrd4.AC4;
end