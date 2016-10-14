%r = [0:0.001:1];
function w = getcumulants(rho, Fig)
r = rho;
w.w2 = r - r.^2;
w.w3 = r - 3*r.^2  + 2*r.^3;
w.w4 = r - 7*r.^2  + 12*r.^3  - 6*r.^4;
w.w5 = r - 15*r.^2 + 50*r.^3  - 60*r.^4   + 24*r.^5;
w.w6 = r - 31*r.^2 + 180*r.^3 - 390*r.^4  + 360*r.^5  - 120*r.^6;
w.w7 = r - 63*r.^2 + 602*r.^3 - 2100*r.^4 + 3360*r.^5 - 2520*r.^6 + 720*r.^7;
if strcmp(Fig,'Yes')
figure(1);hold on;
for i = 2:7
    eval(['y=w',num2str(i),';'])
    figure(1);plot(r,y)
end
end