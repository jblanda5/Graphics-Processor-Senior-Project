function [x1,y1,x2,y2,x3,y3,x4,y4] = flat_triangle(xin1,yin1,xin2,yin2,xin3,yin3)
%x4,y4 will be the bottom most point
%x1,y1 will be the top most point
    %Step one: sort points.
    P1 = [xin1, yin1];
    P2 = [xin2, yin2];
    P3 = [xin3, yin3];
    if (P1(2) == P2(2) || P1(2) == P3(2) || P2(2) == P3(2))
        %We already have a flat top/bottom triangle
        if (P1(2) == P2(2))
            if (P3(2) > P1(2))
                x4 = P3(1);
                y4 = P3(2);
            else
                x1 = P3(1);
                y1 = P3(1);
            end
            x2 = P2(1);
            y2 = P2(2);
            x3 = P1(1);
            y3 = P1(2);
        elseif(P1(2) == P3(2))
            if (P2(2) > P1(2))
                x4 = P2(1);
                y4 = P2(2);
            else
                x1 = P2(1);
                y1 = P2(1);
            end
            x2 = P3(1);
            y2 = P3(2);
            x3 = P1(1);
            y3 = P1(2);
        elseif(P2(2) == P3(2))
            if (P1(2) > P2(2))
                x4 = P1(1);
                y4 = P1(2);
            else
                x1 = P1(1);
                y1 = P1(1);
            end
            x2 = P2(1);
            y2 = P2(2);
            x3 = P3(1);
            y3 = P3(2);
        end
        return; %we already have everything we need for this case
    elseif (P1(2) > P2(2) && P1(2) > P3(2))
        x4 = P1(1);
        y4 = P1(2);
    elseif (P2(2) > P1(2) && P2(2) > P3(2))
        x4 = P2(1);
        y4 = P2(2);
    elseif (P3(2) > P1(2) && P3(2) > P2(2))
        x4 = P3(1);
        y4 = P3(2);
    end
end