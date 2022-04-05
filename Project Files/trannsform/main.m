clear
close all
P1 = [1, 1, 1];
P2 = [2, 4, 1];
P3 = [-1, -1, 1];
scale = [1, 1, 1];
angle = [0,0,0];
translation = [1, 0, 0];
[P1, P2, P3] = transform(P1, P2, P3, scale, angle, translation);

figure(1);
line([P1(1),P2(1)],[P1(2),P2(2)]);
hold on;
line([P3(1),P2(1)],[P3(2),P2(2)]);
line([P1(1),P3(1)],[P1(2),P3(2)]);
