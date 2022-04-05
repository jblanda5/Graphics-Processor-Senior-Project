clear
close all 
xin1 = 190;
yin1 = 343;
xin2 = 229;
yin2 = 393;
xin3 = 226;
yin3 = 343;
[P1, P2, P3, P4] = flat_triangle(xin1, xin2, xin3, yin1, yin2, yin3);

figure(1);
line([P1(1),P2(1)],[P1(2),P2(2)]);
line([P1(1),P4(1)],[P1(2),P4(2)]);
line([P4(1),P2(1)],[P4(2),P2(2)]);


line([P3(1),P2(1)],[P3(2),P2(2)],'color','r');
line([P3(1),P4(1)],[P3(2),P4(2)],'color','r');
line([P4(1),P2(1)],[P4(2),P2(2)],'color','r');