%FILE FORMAT: x1,y1,x2,y2,x3,y3,R(/255),G(/255),B(/255)
clear
close all
data = readmatrix("Banana.txt");
figure(1);
for i=1:length(data)
    line([data(i,1),data(i,3)],[-data(i,2),-data(i,4)],'color', [data(i,7)/255,data(i,8)/255,data(i,9)/255]);
    line([data(i,5),data(i,3)],[-data(i,6),-data(i,4)],'color', [data(i,7)/255,data(i,8)/255,data(i,9)/255]);
    line([data(i,5),data(i,1)],[-data(i,6),-data(i,2)],'color', [data(i,7)/255,data(i,8)/255,data(i,9)/255]);
end
axis([0,800],[0,600]);