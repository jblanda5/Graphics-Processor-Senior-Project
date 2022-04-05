%FILE FORMAT: x1,y1,x2,y2,x3,y3,R(/255),G(/255),B(/255)
clear
close all
data = readmatrix("Banana.txt");
figure(1);
for i=1:length(data)
    [P1, P2, P3, P4] = flat_triangle(data(i,1),data(i,2),data(i,3),data(i,4),data(i,5),data(i,6));
    
    
    line([P1(1),P2(1)],[-P1(2),-P2(2)], 'color',[data(i,7)/255,data(i,8)/255,data(i,9)/255]);
    line([P1(1),P4(1)],[-P1(2),-P4(2)], 'color',[data(i,7)/255,data(i,8)/255,data(i,9)/255]);
    line([P4(1),P2(1)],[-P4(2),-P2(2)], 'color',[data(i,7)/255,data(i,8)/255,data(i,9)/255]);


    line([P3(1),P2(1)],[-P3(2),-P2(2)], 'color',[data(i,7)/255,data(i,8)/255,data(i,9)/255]);
    line([P3(1),P4(1)],[-P3(2),-P4(2)], 'color',[data(i,7)/255,data(i,8)/255,data(i,9)/255]);
    line([P4(1),P2(1)],[-P4(2),-P2(2)], 'color',[data(i,7)/255,data(i,8)/255,data(i,9)/255]);
end