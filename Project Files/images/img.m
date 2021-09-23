clear
clc
% This will convert any 8 bit BMP to hex that we can store.
b=imread('testPattern.bmp'); % 8-bit BMP image RGB332 
k=1;
for i=1:600% image is written from the last row to the first row
for j=1:800
    p(k) = bitget(b(i,j,1),8);
    p(k+1) = bitget(b(i,j,1),7);
    p(k+2) = bitget(b(i,j,1),6);
    p(k+3) = bitget(b(i,j,1),5);
    p(k+4) = bitget(b(i,j,1),4);
    p(k+5) = bitget(b(i,j,1),3);
    p(k+6) = bitget(b(i,j,1),2);
    p(k+7) = bitget(b(i,j,1),1);
    k=k+8;
end
end
fid = fopen('pixels.txt', 'wt');
fprintf(fid, "%d",p);
disp('Text file write done');disp(' ');
fclose(fid);