function [Node, bSmooth] = cutNodes_demo(b,frameN,Factor)
%% first start from average signal trace b.
%Decide the time smooth kernal size such that b keeps decreasing.
Hsize = 20;
flag = 0;
tag = 1;
while (flag == 0)
    H = fspecial('gaussian',[1,Hsize*10],Hsize);
    c = imfilter([b,fliplr(b)],H,'circular');c=c(1:frameN);
    cdif = c(2:end) - c(1:end-1);
    if isempty(find(cdif>0, 1));
        flag=1;
    end
    Hsize = Hsize + 10;
end
bSmooth = c;
c = (c-min(c))./(max(c)-min(c)).*Factor;
d = floor(c);
e = 1;
tag=1;
for i0 = Factor:-1:1
    e = find(d==i0);
    Node(tag) = e(end);tag=tag+1;
end
Node = [0,Node,frameN];%add the beginning and ending node.