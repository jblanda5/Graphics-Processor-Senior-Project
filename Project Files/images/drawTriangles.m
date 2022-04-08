%FILE FORMAT: x1,y1,x2,y2,x3,y3,R(/255),G(/255),B(/255)
clear
close all
point_data = readmatrix("TeapotPLYFile.txt");
triangle_data = readmatrix("LineConnectors.txt");
x_angle = pi/2;
y_angle = 0;
z_angle = 0;
s = [2, 2, 2];
t = [0, 0, 0];
T = [s(1), 0, 0, 0;
    0, s(2), 0, 0;
    0, 0, s(3), 0;
    t(1), t(2), t(3), 1];
Rx = [1, 0, 0, 0;
    0, cos(x_angle), -1*sin(x_angle), 0;
    0, sin(x_angle), cos(x_angle), 0;
    0, 0, 0, 1];
Ry = [cos(y_angle), 0, sin(y_angle), 0;
    0, 1, 0, 0;
    -sin(y_angle), 0, cos(y_angle), 0;
    0, 0, 0, 1];

Rz = [cos(z_angle), -sin(z_angle), 0, 0;
    sin(z_angle), cos(z_angle), 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1];





figure(1);
for i=1:length(triangle_data)

    P1 = [point_data(triangle_data(i,2)+1,1), point_data(triangle_data(i,2)+1,2),point_data(triangle_data(i,2)+1,3),1];
    P2 = [point_data(triangle_data(i,3)+1,1), point_data(triangle_data(i,3)+1,2),point_data(triangle_data(i,3)+1,3),1];
    P3 = [point_data(triangle_data(i,4)+1,1), point_data(triangle_data(i,4)+1,2),point_data(triangle_data(i,4)+1,3),1];
    
    P1 = P1*T*Rx*Ry*Rz;
    P2 = P2*T*Rx*Ry*Rz;
    P3 = P3*T*Rx*Ry*Rz;
    
    P1 = conv3d_2d(P1);
    P2 = conv3d_2d(P2);
    P3 = conv3d_2d(P3);
    
%   Bad: not sure what's happening here (z division)
%    [P1, P2, P3, P4] = flat_triangle(P1(1)/P1(3),P1(2)/P1(3),P2(1)/P2(3),P2(2)/P2(3),P3(1)/P3(3),P3(2)/P3(3));
%   Good: Shows the tea pot (no z division)
    [P1, P2, P3, P4] = flat_triangle(P1(1),P1(2),P2(1),P2(2),P3(1),P3(2));
        line([P1(1),P2(1)],[-P1(2),-P2(2)], 'color',[rand(),rand(),rand()]);
        line([P1(1),P4(1)],[-P1(2),-P4(2)], 'color',[rand(),rand(),rand()]);
        line([P4(1),P2(1)],[-P4(2),-P2(2)], 'color',[rand(),rand(),rand()]);


        line([P3(1),P2(1)],[-P3(2),-P2(2)], 'color',[rand(),rand(),rand()]);
        line([P3(1),P4(1)],[-P3(2),-P4(2)], 'color',[rand(),rand(),rand()]);
        line([P4(1),P2(1)],[-P4(2),-P2(2)], 'color',[rand(),rand(),rand()]);
end

xlabel("x");
ylabel("y");