%function [L0, locs0] = xy_esti_LMap(epsMap, RhoMap, AC2, AC7)
function [Lini, locs] = xy_esti_LMap(e, p, a7, AcceptFactor, UestiFactor, IniFactor, sig, FG)
w7 = p - 63.*p.^2 + 602.*p.^3 - 2100.*p.^4 + 3360.*p.^5 - 2520.*p.^6 + 720.*p.^7;
b7 = w7.*e.^7;

AceptMap = e;
AceptMap(AceptMap<AcceptFactor.*max(e(:)))=0;
AceptMap(AceptMap>0)=1;

U = fspecial('gaussian',[UestiFactor*15,UestiFactor*15],sig*UestiFactor);
U = U./max(U(:));
U7=binPixel(U.^7,UestiFactor);
amp7 = max(U7(:));
Lini = round(a7./(b7).*AceptMap./amp7.*UestiFactor^2.*IniFactor);
Lini(Lini==Inf)=0;
Lini(Lini<0)=0;
Lini(isnan(Lini))=0;
Lini(Lini>5)=5;
N_emi = sum(Lini(:)); %total number of candidate emitters.
locs = zeros(N_emi,2); %put 2D coordinate to candidate emitters.
[locsx, locsy] = find(Lini>0);
tag = 0;
for i0 = 1:length(locsx)
    x=locsx(i0);
    y=locsy(i0);
    N_local = Lini(x,y);
    for i1 = 1:N_local;
        tag = tag+1;
        locs(tag,:) =[floor((x-0.5)*FG),floor((y-0.5)*FG)];
    end
end
return