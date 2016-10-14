function [RhoMap, RhoTru, epsMap] = xy_getRhoEpsi(x3, x4, x5, x6, x7, Res)
% this function search for epsilon and rho, with 5 fitting
% functions. X3~7 correspond to 5 different model.
rhoList = [1/Res:1/Res:1]; % get a list of rho.
[xdim, ydim] =  size(x3); % get the dimention of matrix
for i0 = 3:7; eval(['x',num2str(i0),' = x',num2str(i0),' + eps;']);end

for i0 = 1:xdim % go through each pixel.
    disp(['in row #',num2str(i0),'/',num2str(xdim)])
    for i1 = 1:ydim
            ep3m1 = 1/x3(i0, i1)*(1-2.*rhoList);
            ep4m1 = 1/x4(i0, i1)*(1-6.*rhoList + 6.*rhoList.^2);
            ep5m1 = 1/x5(i0, i1)*(1-14.*rhoList + 36.*rhoList.^2  - 24.*rhoList.^3);
            ep6m1 = 1/x6(i0, i1)*(1-30.*rhoList + 150.*rhoList.^2 - 240.*rhoList.^3  + 120.*rhoList.^4);
            ep7m1 = 1/x7(i0, i1)*(1-62.*rhoList + 540.*rhoList.^2 - 1560.*rhoList.^3 + 1800.*rhoList.^4 - 720.*rhoList.^5);
            Inds = intersect(intersect(intersect(intersect(find(ep3m1>0),find(ep4m1>0)),find(ep5m1>0)),find(ep6m1>0)),find(ep7m1>0));
            if length(Inds) > 0;
                Yset = [ep3m1; abs(ep4m1).^(1/2); abs(ep5m1).^(1/3); abs(ep6m1).^(1/4); abs(ep7m1).^(1/5)];
                Ydis = sum(Yset.^2,1) - sum(Yset,1).^2./5;
                tag = find(Ydis==min(Ydis));
                
                RhoMap(i0, i1) = rhoList(tag);
                RhoTru(i0, i1) = 1./min(Ydis);
                epsMap(i0, i1) = 1./mean(Yset(:,tag));
            else
                RhoMap(i0, i1) = 0;
                RhoTru(i0, i1) = 0;
                epsMap(i0, i1) = 0;
            end
        
    end
end




end