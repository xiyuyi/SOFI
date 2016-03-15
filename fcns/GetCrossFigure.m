function output = GetCrossFigure(Rs)
% first, prepare a white pixel
output = ones(15*5+4,15*5+4,3);
p = ones(15,15,3).*0.7;
p(1:2,:,:)=1;
p(:,1:2,:)=1;
p(end-1:end,:,:)=1;
p(:,end-1:end,:)=1;

% now, prepare a pixel pattern as the chosen pixel
pc = ones(15,15,3);
pc(:,:,1)=pc(:,:,1).*0.8;
pc(:,:,2)=pc(:,:,2).*0.4;
pc(:,:,3)=pc(:,:,3).*0.4;
pc(1:2,:,:)=1;
pc(:,1:2,:)=1;
pc(end-1:end,:,:)=1;
pc(:,end-1:end,:)=1;

% now, prepare a pixel pattern as the AC pixel
k = ones(15,15,3).*0.7;
k(1:2,:,:)=1;
k(:,1:2,:)=1;
k(end-1:end,:,:)=1;
k(:,end-1:end,:)=1;
k(8,6:10,:)=0.2;
k(6:10,8,:)=0.2;


p1 = [p,  p,  p,  p,  p;...
      p,  p,  p,  p,  p;...
      p,  p,  k,  p,  p;...
      p,  p,  p,  p,  p;...
      p,  p,  p,  p,  p;...
     ];
for i0 = 1:length(Rs(:,1))
    r = Rs(i0, :) + [3,3];
    
    xini = (r(1)-1)*15 + 1;    xend = r(1)*15;
    yini = (r(2)-1)*15 + 1;    yend = r(2)*15;
    p1(xini:xend, yini:yend, :) = pc;
end

output(3:end-2, 3:end-2, :) = p1;

end




