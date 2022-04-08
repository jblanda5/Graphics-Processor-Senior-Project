%FILE FORMAT: x1,y1,x2,y2,x3,y3,R(/255),G(/255),B(/255)
clear
close all
point_data = readmatrix("TeapotPLYFile.txt");
triangle_data = readmatrix("LineConnectors.txt");
%point_data = [
%    -1, -1, 1;
%    -1, -1, 2;
%    1, -1, 1;
%    1, -1, 2;
%    -1, 1, 1;
%    -1, 1, 2;
%    -1, -1, 1;
%    -1, -1, 2];
%triangle_data = [
%    3 0 1 2;
%    3];

figure(1);
hold on
for i=1:length(triangle_data)

    P1 = [point_data(triangle_data(i,2)+1,1), point_data(triangle_data(i,2)+1,2),point_data(triangle_data(i,2)+1,3)];
    P2 = [point_data(triangle_data(i,3)+1,1), point_data(triangle_data(i,3)+1,2),point_data(triangle_data(i,3)+1,3)];
    P3 = [point_data(triangle_data(i,4)+1,1), point_data(triangle_data(i,4)+1,2),point_data(triangle_data(i,4)+1,3)];

%    P1 = conv3d_2d(P1);
%    P2 = conv3d_2d(P2);
%    P3 = conv3d_2d(P3);
    
%   Bad: not sure what's happening here (z division)
%    [P1, P2, P3, P4] = flat_triangle(P1(1)/P1(3),P1(2)/P1(3),P2(1)/P2(3),P2(2)/P2(3),P3(1)/P3(3),P3(2)/P3(3));
%   Good: Shows the tea pot (no z division)
%    [P1, P2, P3, P4] = flat_triangle(P1(1),P1(2),P2(1),P2(2),P3(1),P3(2));
    %center object
    P1(1) = P1(1) + 400;
    P1(2) = P1(2) + 300;
    P2(1) = P2(1) + 400;
    P2(2) = P2(2) + 300;
    P3(1) = P3(1) + 400;
    P3(2) = P3(2) + 300;
%    P4(1) = P4(1) + 400;
%    P4(2) = P4(2) + 300;
    if ( ... %Clipping filter. Ignore if out of bounds
        P1(1) >= 0 &&  ...
        P1(2) >= 0 &&  ...
        P2(1) >= 0 &&  ...
        P2(2) >= 0 &&  ...
        P3(1) >= 0 &&  ...
        P3(2) >= 0 &&  ...
        P1(1) <= 800 && ...
        P1(2) <= 600 && ...
        P2(1) <= 800 && ...
        P2(2) <= 600 && ...
        P3(1) <= 800 && ...
        P3(2) <= 600)
%        P4(1) >= 0 && 
%        P4(2) >= 0 && 
%        P4(1) <= 800 &&
%        P4(2) <= 600 
        plot3([P1(1),P2(1)], [P1(2),P2(2)], [P1(3),P2(3)]);
        plot3([P3(1),P2(1)], [P3(2),P2(2)], [P3(3),P2(3)]);
        plot3([P1(1),P3(1)], [P1(2),P3(2)], [P1(3),P3(3)]);
    end
end
hold off
xlabel("x");
ylabel("y");
zlabel("z");