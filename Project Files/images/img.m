clear
clc
% This will convert any 8 bit BMP to hex that we can store.
b=imread('testPattern.bmp'); % 8-bit BMP image RGB332 
k=1;
for i=1:600% image is written from the last row to the first row
for j=1:800
    p8(k) = bitget(b(i,j,1),8);
    p7(k) = bitget(b(i,j,1),7);
    p6(k) = bitget(b(i,j,1),6);
    p5(k) = bitget(b(i,j,1),5);
    p4(k) = bitget(b(i,j,1),4);
    p3(k) = bitget(b(i,j,1),3);
    p2(k) = bitget(b(i,j,1),2);
    p1(k) = bitget(b(i,j,1),1);
    k=k+1;
end
end
fid = fopen('pixels.txt', 'wt');
fprintf(fid, "%d",p);
disp('Text file write done');disp(' ');
fclose(fid);