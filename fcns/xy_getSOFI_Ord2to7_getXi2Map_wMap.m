function [Xi2Map, Xi2Matrix, wMap, wMatrix] = xy_getSOFI_Ord2to7_getXi2Map_wMap(CumuMapInd, tags, sig)
for ord = 2 : 7;
    for i0 = 1 : ord;
        for i1 = 1 : ord;
            eval(['RInds = CumuMapInd.Ord',num2str(ord),'P',num2str(i0*10+i1),';'])
            rs = [];
            for i2 = 1:ord
                rs = [rs; tags(RInds(i2),:)];
            end
            Xi2 = sum(sum(rs.^2))-sum(sum(rs,1).^2)/ord;
            xy_w = exp(-Xi2/2/sig^2);
            eval(['Xi2Map.Ord',num2str(ord),'P',num2str(i0*10+i1),'=Xi2;'])
            eval(['wMap.Ord',num2str(ord),'P',num2str(i0*10+i1),'=xy_w;'])
            eval(['Xi2Matrix.Ord',num2str(ord),'(',num2str(i0),',',num2str(i1),')=Xi2;']) 
            eval(['wMatrix.Ord',num2str(ord),'(',num2str(i0),',',num2str(i1),')=xy_w;'])         
        end
    end
end
end
