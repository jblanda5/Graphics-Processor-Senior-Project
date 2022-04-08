%FILE FORMAT: x1,y1,x2,y2,x3,y3,R(/255),G(/255),B(/255)
clear
close all
point_data = readmatrix("TeapotPLYFile.txt");
triangle_data = readmatrix("LineConnectors.txt");
figure(1);
for i=1:length(triangle_data)

    P1 = [point_data(triangle_data(i,2)+1,1), point_data(triangle_data(i,2)+1,2),point_data(triangle_data(i,2)+1,3)];
    P2 = [point_data(triangle_data(i,3)+1,1), point_data(triangle_data(i,3)+1,2),point_data(triangle_data(i,3)+1,3)];
    P3 = [point_data(triangle_data(i,4)+1,1), point_data(triangle_data(i,4)+1,2),point_data(triangle_data(i,4)+1,3)];

%   Bad: not sure what's happening here (z division)
    [P1, P2, P3, P4] = flat_triangle(3.5*P1(1)/P1(3),3.5*P1(2)/P1(3),3.5*P2(1)/P2(3),3.5*P2(2)/P2(3),3.5*P3(1)/P3(3),3.5*P3(2)/P3(3));
%   Good: Shows the tea pot (no z division)
%    [P1, P2, P3, P4] = flat_triangle(P1(1),P1(2),P2(1),P2(2),P3(1),P3(2));
    
    
    line([P1(1),P2(1)],[-P1(2),-P2(2)], 'color',[rand(),rand(),rand()]);
    line([P1(1),P4(1)],[-P1(2),-P4(2)], 'color',[rand(),rand(),rand()]);
    line([P4(1),P2(1)],[-P4(2),-P2(2)], 'color',[rand(),rand(),rand()]);


    line([P3(1),P2(1)],[-P3(2),-P2(2)], 'color',[rand(),rand(),rand()]);
    line([P3(1),P4(1)],[-P3(2),-P4(2)], 'color',[rand(),rand(),rand()]);
    line([P4(1),P2(1)],[-P4(2),-P2(2)], 'color',[rand(),rand(),rand()]);
end