% This will convert any 8 bit BMP to hex that we can store.
b=imread('testPattern.bmp'); % 8-bit BMP image RGB332 
k=1;
for i=1:600% image is written from the last row to the first row
for j=1:800
    r = bitget(b(i,j,1),1)*4 + bitget(b(i,j,1),2)*2 + bitget(b(i,j,1),3);
    g = bitget(b(i,j,1),4)*32 + bitget(b(i,j,1),5)*16 + bitget(b(i,j,1),6)*8;
    bl = bitget(b(i,j,1),7)*128 + bitget(b(i,j,1),8)*64;
    a(k)= r+g+bl;
    k=k+1;
end
end
fid = fopen('testPattern.txt', 'wt');
fprintf(fid, '%x', a);
disp('Text file write done');disp(' ');
fclose(fid);