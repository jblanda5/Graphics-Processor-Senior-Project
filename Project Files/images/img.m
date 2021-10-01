clear
clc
X=imread('testPattern4.bmp'); %Convert an indexed color bmp image to binary
width = 800;
height = 600;
fid = fopen('imgTestPattern4.coe', 'wt');
fprintf(fid, "memory_initialization_radix=16;\n");
fprintf(fid, "memory_initialization_vector=\n");
for i=1:height
    for j=1:width
    fprintf(fid, "%x ",X(i,j));
    end
    fprintf(fid, "\n");
end
fprintf(fid, ";");
disp('Text file write done');disp(' ');
fclose(fid);
