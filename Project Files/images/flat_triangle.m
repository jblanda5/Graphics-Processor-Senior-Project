function [P1,P2,P3,P4] = flat_triangle(xin1,yin1,xin2,yin2,xin3,yin3)
%P3 will be the bottom most point
%P1 will be the top most point

    %First, detect if a flat top/bottom is passed.
    if (yin1 == yin2)
        if (yin1 > yin3) %Flat bottom
            P3 = [xin1, yin1];
            P2 = [xin2, yin2];
            P1 = [xin3, yin3];
            P4 = [xin1, yin1];
        else %Flat top
            P1 = [xin1, yin1];
            P2 = [xin2, yin2];
            P3 = [xin3, yin3];
            P4 = [xin1, yin1];
        end
        return
    elseif (yin2 == yin3)
        if (yin2 > yin1) %Flat bottom
            P1 = [xin1, yin1];
            P2 = [xin2, yin2];
            P3 = [xin3, yin3];
            P4 = [xin3, yin3];
        else %Flat top
            P3 = [xin1, yin1];
            P2 = [xin2, yin2];
            P1 = [xin3, yin3];
            P4 = [xin3, yin3];
        end
        return
    elseif (yin1 == yin3)
        if (yin1 > yin2) %Flat bottom
            P1 = [xin2, yin2];
            P2 = [xin1, yin1];
            P3 = [xin3,yin3];
            P4 = [xin1,yin1];
        else
            P3 = [xin2, yin2];
            P2 = [xin1, yin1];
            P1 = [xin3,yin3];
            P4 = [xin1,yin1];
        end
        return
    end
    
    %Sort points.
    if (yin1 < yin2 && yin1 < yin3)
      P1 = [xin1, yin1];
    elseif (yin2 < yin1 && yin2 < yin3)
      P1 = [xin2, yin2];
    else
      P1 = [xin3, yin3];
    end
    
    if (yin1 > yin2 && yin1 > yin3)
      P3 = [xin1, yin1];
    elseif (yin2 > yin1 && yin2 > yin3)
      P3 = [xin2, yin2];
    else
      P3 = [xin3, yin3];
    end
    
    if (yin1 < P3(2) && yin1 > P1(2))
        P2 = [xin1, yin1];
    elseif (yin2 < P3(2) && yin2 > P1(2))
        P2 = [xin2, yin2];
    else 
        P2 = [xin3, yin3];
    end
    
    b = P1(2) - (P3(2)-P1(2))/(P3(1)-P1(1))*P1(1);
    P4 = [(P2(2)-b)*((P3(1)-P1(1))/(P3(2)-P1(2))),P2(2)];
end