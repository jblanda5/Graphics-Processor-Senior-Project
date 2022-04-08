#include <stdio.h>
#include <stdint.h>
#include "instructions.h"
#include "sendByte.h"

void flatTriangle(int pi, int x1, int y1, int x2, int y2, int x3, int y3, uint8_t color) {
    int top_x, top_y;
    int bottom_x, bottom_y;
    int middle_x, middle_y;
    int new_x, new_y;
    float b;
    printf("got points (%i,%i), (%i,%i), and (%i,%i)\n",x1,y1,x2,y2,x3,y3);
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
            top_x = new_x;
            top_y = new_y;
        }
        else {
            top_x = x3;
            top_y = y3;
            middle_x = x1;
            middle_y = y1;
            new_x = x2;
            new_y = y2;
            //Since this is already flat bottom, minimize the extra triangle to a line that overlaps this triangle.
            bottom_x = new_x;
            bottom_y = new_y;
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
            top_x = x3;
            top_y = y3;
        }
        else {
            top_x = x1;
            top_y = y1;
            middle_x = x2;
            middle_y = y2;
            new_x = x3;
            new_y = y3;
            //Since this is already flat bottom, minimize the extra triangle to a line that overlaps this triangle
            bottom_x = new_x;
            bottom_y = new_y;
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
            top_x = new_x;
            top_y = new_y;
        }
        else {
            top_x = x2;
            top_y = y2;
            middle_x = x1;
            middle_y = y1;
            new_x = x3;
            new_y = y3;
            //Since this is already flat top, minimize the extra triangle to a line that overlaps this triangle
            bottom_x = new_x;
            bottom_y = new_y;
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
        //Correct any inf errors:
        if (bottom_x == top_x) {
            bottom_x++;
        }
        b = (float)top_y - (((float)bottom_y - (float)top_y)/((float)bottom_x - (float)top_x))*(float)top_x;
        new_y = middle_y;
        new_x = (int)(((float)new_y - b)*(((float)bottom_x - (float)top_x)/((float)bottom_y - (float)top_y)));
        //Solved for new point to make flat top/bottom
    }
    drawTriangle(pi, bottom_x,bottom_y,middle_x,middle_y,new_x,new_y,color);
    drawTriangle(pi, top_x,top_y,middle_x,middle_y,new_x,new_y,color);
    printf("Drawing a flat-bottom triangle with points x1:%i, y1:%i, x2:%i, y2:%i, x3:%i, y3:%i\n",top_x,top_y,new_x,new_y,middle_x,middle_y);
    printf("Drawing a flat-top triangle with points x1:%i, y1:%i, x2:%i, y2:%i, x3:%i, y3:%i\n",bottom_x,bottom_y,new_x,new_y,middle_x,middle_y);
}