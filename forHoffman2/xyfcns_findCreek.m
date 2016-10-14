function [CreekMap, EdgePos, EdgeNeg] = xyfcns_findCreek(A);
[xdim, ydim] = size(A);
aNeg = A; aNeg(A>0)=0; aNeg(A<=0)=1;
aPos = A; aPos(A<0)=0; aPos(A>=0)=0;
EdgeNeg = zeros(xdim, ydim);
EdgePos = zeros(xdim, ydim);
for i0 = 2:xdim-1;
    for i1 = 2:ydim-1;
        if aNeg(i0,i1)==1
            tag = sum(sum(aNeg(i0-1:i0+1,i1-1:i1+1)));
            if tag > 1 && tag <= 8
                EdgeNeg(i0, i1)=1;
            end
        end
        if aPos(i0,i1)==1
            tag = sum(sum(aPos(i0-1:i0+1,i1-1:i1+1)));
            if tag > 1 && tag <= 8
                EdgePos(i0, i1)=1;
            end
        end
    end
end
CreekMap = EdgePos + EdgeNeg;
end