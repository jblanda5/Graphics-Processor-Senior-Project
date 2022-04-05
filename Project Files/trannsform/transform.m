function [P1_out,P2_out,P3_out] = transform(P1,P2,P3,scale,angle,translation)
M = [scale(1), scale(1), 0, 0;
    -scale(2), scale(2), 0, 0;
    0, 0, scale(3), 0;
    translation(1), translation(2), translation(3), 1];
%M is our translation and scale matrix.
Rx = [1, 0, 0, 0;
    0, cos(angle(1)), -sin(angle(1)), 0;
    0, sin(angle(1)), cos(angle(1)), 0;
    0, 0, 0, 1];
Ry = [cos(angle(2)), 0, sin(angle(2)), 0;
    0, 1, 0, 0;
    -sin(angle(2)), 0, cos(angle(2)), 0;
    0, 0, 0, 1];
Rz = [cos(angle(3)), -sin(angle(3)), 0, 0;
    sin(angle(3)), cos(angle(3)), 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1];
output = [P1, 1; P2, 1; P3, 1]*M*Rx*Ry*Rz;

P1_out = [output(1,1)/output(1,3), output(1,2)/output(1,3)]; %divide by Z
P2_out = [output(2,1)/output(2,3), output(2,2)/output(2,3)];
P3_out = [output(3,1)/output(3,3), output(3,2)/output(3,3)];
end