%This file foor some reason sets "FF" as 0. 
clear
clc
X=imread('testPattern.bmp'); %Convert an indexed color bmp image to binary
width = 800;
height = 600;
fid = fopen('imgTestPattern.coe', 'wt');
fprintf(fid, "memory_initialization_radix=16;\n");
fprintf(fid, "memory_initialization_vector=\n");
for i=1:height
    for j=1:width
    if (X(i,j) == 0)
        X(i,j) = 255;
    end
    fprintf(fid, "%x ",X(i,j));
    end
    fprintf(fid, "\n");
end
fprintf(fid, ";");
disp('Text file write done');disp(' ');
fclose(fid);
