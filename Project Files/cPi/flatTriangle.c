void flatTriangle(void *params) {
    int x1, y1, x2, y2, x3, y3, x4, y4;
    x1 = (int*)params;
    y1 = (int*)params+1;
    x2 = (int*)params+2;
    y2 = (int*)params+3;
    x3 = (int*)params+4;
    y3 = (int*)params+5;

    int top_x, top_y;
    int bottom_x, bottom_y;
    int middle_x, middle_y;
    int new_x, new_y;
    float b;
    //First: Detect if there is already a flat top/bottom triangle
    if (y1 == y2) {
        if (y3 >= y2) {
            bottom_x = x3;
            bottom_y = y3;
            middle_x = x1;
            middle_y = y1;
            new_x = x2;
            new_y = y2;
            //Since this is already flat top, minimize the extra triangle to a line that overlaps this triangle.
            top_x = x1;
            top_y = y1;
        }
        else {
            top_x = x3;
            top_y = y3;
            middle_x = x1;
            middle_y = y1;
            new_x = x2;
            new_y = y2;
            //Since this is already flat bottom, minimize the extra triangle to a line that overlaps this triangle.
            bottom_x = x1;
            bottom_y = y1;
        }
    }
    else if (y2 == y3) {
        if (y1 > y2){
            bottom_x = x1;
            bottom_y = y1;
            middle_x = x2;
            middle_y = y2;
            new_x = x3;
            new_y = y3;
            //Since this is already flat top, minimize the extra triangle to a line that overlaps this triangle
            top_x = x2;
            top_y = y2;
        }
        else {
            top_x = x1;
            top_y = y1;
            middle_x = x2;
            middle_y = y2;
            new_x = x3;
            new_y = y3;
            //Since this is already flat bottom, minimize the extra triangle to a line that overlaps this triangle
            bottom_x = x2;
            bottom_y = y2;
        }
    }
    else if (y1 == y3) {
        if (y2 > y1) {
            bottom_x = x2;
            bottom_y = y2;
            middle_x = x1;
            middle_y = y1;
            new_x = x3;
            new_y = y3;
            //Since this is already flat top, minimize the extra triangle to a line that overlaps this triangle
            top_x = x1;
            top_y = y1;
        }
        else {
            top_x = x2;
            top_y = y2;
            middle_x = x1;
            middle_y = y1;
            new_x = x3;
            new_y = y3;
            //Since this is already flat top, minimize the extra triangle to a line that overlaps this triangle
            bottom_x = x1;
            bottom_y = y1;
        }
    }
    else { //Not flat top/bottom already
        if (y1 < y2 && y1 < y3)
        {
            top_x = x1;
            top_y = y1;
        }
        else if (y2 < y1 && y2 < y3) {
            top_x = x2;
            top_y = y2;
        }
        else {
            top_x = x3;
            top_y = y3;
        }
        //Top point found
        if (y1 > y2 && y1 > y3)
        {
            bottom_x = x1;
            bottom_y = y1;
        }
        else if (y2 > y1 && y2 > y3) {
            bottom_x = x2;
            bottom_y = y2;
        }
        else {
            bottom_x = x3;
            bottom_y = y3;
        }
        //Bottom point found
        if ((y1 > y2 && y1 < y3) || (y1 < y2 && y1 > y3)){
            middle_x = x1;
            middle_y = y1;
        }
        else if ((y2 > y1 && y2 < y3) || (y2 < y1 && y2 > y3)) {
            middle_x = x2;
            middle_y = y2;
        }
        else {
            middle_x = x3;
            middle_y = y3;
        }
        //Middle point found
        b = top_y - ((bottom_y - top_y)/(bottom_x - top_x))*top_x;
        new_y = middle_y;
        new_x = (new_y - (int)b)*((bottom_x - top_x)/(bottom_y - top_y));
        //Solved for new point to make flat top/bottom
    }
}