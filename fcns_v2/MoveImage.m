function imout=MoveImage(imin,MoveR)

MoveDim1=MoveR(1);
MoveDim2=MoveR(2);
a0=imin;
if MoveDim1>0
    for step=1:MoveDim1
   a3=a0;
   a3=[zeros(1,length(a3(1,:)));a3];a3(length(a3(:,1)),:)=[];%need change
   a0=a3;
    end
end
if MoveDim1<0
    for step=1:abs(MoveDim1)
   a3=a0;
   a3=[a3;zeros(1,length(a3(1,:)))];a3(1,:)=[];%need change
   a0=a3;
    end
end


if MoveDim2>0
   for step=1:MoveDim2
       a2=a0;
       a2=[zeros(length(a2(:,1)),1),a2];a2(:,length(a2(1,:)))=[];%need change
       a0=a2;
   end
end

if MoveDim2<0
   for step=1:abs(MoveDim2)
       a2=a0;
       a2=[a2,zeros(length(a2(:,1)),1)];a2(:,1)=[];%need change
       a0=a2;
   end
end





imout=a0;return


