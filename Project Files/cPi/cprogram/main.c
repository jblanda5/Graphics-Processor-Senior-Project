#include "init.h"
#include <stdio.h>
#include "instructions.h"
#include "flatTriangle.h"
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

uint8_t rgb_to_8bit(uint8_t r, uint8_t g, uint8_t b) {
    uint8_t red = (r*8)/256;
    uint8_t green = (g*8)/256;
    uint8_t blue = (b*4)/256;
    uint8_t rgb = (red << 5) | (green << 2) | blue;
    return rgb;
}

void drawBanana(int pi) {
    FILE *fptr = fopen("banana.txt", "r");
    int num_lines = 50;
    int x1[num_lines];
    int y1[num_lines];
    int x2[num_lines];
    int y2[num_lines];
    int x3[num_lines];
    int y3[num_lines];
    int r[num_lines];
    int g[num_lines];
    int b[num_lines];
    uint8_t color[num_lines];
    for (int i=0; i<num_lines;++i) { //pre-allocate everything
        fscanf(fptr,"%i,%i,%i,%i,%i,%i,%i,%i,%i\n",&x1[i],&y1[i],&x2[i],&y2[i],&x3[i],&y3[i],&r[i],&g[i],&b[i]);
        color[i] = rgb_to_8bit(r[i],g[i],b[i]);
//        printf("Drawing a %i colored triangle between the points x1:%i, y1:%i, x2:%i, y2:%i, x3:%i, y3:%i\n",color,x1,y1,x2,y2,x3,y3);
    }
    fclose(fptr);
    for (int i=0; i<num_lines;++i) {
        flatTriangle(pi,x1[i],y1[i],x2[i],y2[i],x3[i],y3[i],color[i]);
    }
}

void drawTeaPot(int pi) {
    uint8_t color;
    FILE *fptr = fopen("teapot_points.txt", "r");
    int num_points = 1177;
    double x[num_points];
    double y[num_points];
    double z[num_points];
    double transformed_x[num_points];
    double transformed_y[num_points];
    double transformed_z[num_points];
    for (int i=0; i<num_points; ++i){
        fscanf(fptr, "%lf %lf %lf \n", &x[i],&y[i],&z[i]);
    }
    fclose(fptr);
    fptr = fopen("teapot_triangles.txt", "r");
    int num_triangles = 2256;
    int triangle[num_triangles][3];
    for (int i=0; i<num_triangles; ++i){
        fscanf(fptr, "3 %i %i %i\n", &triangle[i][0],&triangle[i][1],&triangle[i][2]);
        printf("triangle values: %i,%i,%i\n",triangle[i][0],triangle[i][1],triangle[i][2]);
    }
    fclose(fptr);
    for (int i=0; i<num_points;++i) //Apply transformation
    {
        transformed_x[i] = (100*x[i])+400;
        transformed_y[i] = (100*y[i])+300;
        transformed_z[i] = 1;//(z[i]);
        printf("got points (%f,%f)\n",transformed_x[i],transformed_y[i]);
        if (transformed_z[i] == 0) { //avoid seg fault
            transformed_z[i] = 1;
        }
    }
    int x_in1;
    int y_in1;
    int x_in2;
    int y_in2;
    int x_in3;
    int y_in3;
    for (int i=0; i<num_triangles;++i) { //Draw
        color = rand() % 255;
        x_in1 = (int)(transformed_x[triangle[i][0]]/transformed_z[triangle[i][0]]);
        y_in1 = (int)(transformed_y[triangle[i][0]]/transformed_z[triangle[i][0]]);
        x_in2 = (int)(transformed_x[triangle[i][1]]/transformed_z[triangle[i][1]]);
        y_in2 = (int)(transformed_y[triangle[i][1]]/transformed_z[triangle[i][1]]);
        x_in3 = (int)(transformed_x[triangle[i][2]]/transformed_z[triangle[i][2]]);
        y_in3 = (int)(transformed_y[triangle[i][2]]/transformed_z[triangle[i][2]]);
        flatTriangle(pi,x_in1,y_in1,x_in2,y_in2,x_in3,y_in3,color);
    }
}

int main()
{
    int pi = init();
    colorScreen(pi,255);
    drawTeaPot(pi);
//    drawBanana(pi);
    /*
    colorScreen(pi,200);
    drawTriangle(pi,0,0,200,200,800,200,0);
    drawLine(pi,0,0,800,600,0);
    drawTriangle(pi,800,600,200,200,800,200,50);
    flatTriangle(pi,0,0,800,600,800,200,128);
    sleep(15);
    colorScreen(pi,0);
    */
    terminate(pi);
}