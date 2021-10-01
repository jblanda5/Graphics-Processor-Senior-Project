fid = fopen('genTestPattern.coe', 'wt');
k=0;
fprintf(fid, "memory_initialization_radix=2;\n");
fprintf(fid, "memory_initialization_vector=\n");
z = 0;
for i=1:480000
    if (i<=1600)
        fprintf(fid,"00000000\n");
    elseif (i <= 5*800)
        fprintf(fid,"00000001\n");
    elseif (i <= 10*800)
        fprintf(fid,"00000010\n");
    elseif (i <= 15*800)
        fprintf(fid,"00000011\n");
    elseif (i <= 20*800)
        fprintf(fid,"00000100\n");
    elseif (i <= 25*800)
        fprintf(fid,"00000101\n");
    elseif (i <= 30*800)
        fprintf(fid,"00000110\n");
    elseif (i <= 35*800)
        fprintf(fid,"00000111\n");
    elseif (i <= 40*800)
        fprintf(fid,"00001000\n");
    elseif (i <= 45*800)
        fprintf(fid,"00001001\n");
    elseif (i <= 50*800)
        fprintf(fid,"00001010\n");
    elseif (i <= 55*800)
        fprintf(fid,"00001011\n");
    elseif (i <= 60*800)
        fprintf(fid,"00001100\n");
    elseif (i <= 65*800)
        fprintf(fid,"00001101\n");
    elseif (i <= 70*800)
        fprintf(fid,"00001110\n");
    elseif (i <= 75*800)
        fprintf(fid,"00001111\n");
    elseif (i <= 80*800)
        fprintf(fid,"00010000\n");
    elseif (i <= 85*800)
        fprintf(fid,"00100000\n");
    elseif (i <= 90*800)
        fprintf(fid,"01000000\n");
    elseif (i <= 95*800)
        fprintf(fid,"10000000\n");
    else
        if (z < 10)
        fprintf(fid, "11100000\n");
        z = z + 1;
        elseif (z < 20)
        fprintf(fid, "00011100\n");
        z = z + 1;
        elseif (z < 30)
        fprintf(fid, "00000011\n");
        z = z + 1;
        else
        z = 0;
        fprintf(fid, "00011100\n");
        end
    end
end
fprintf(fid,";");
disp('Text file write done');disp(' ');
fclose(fid);