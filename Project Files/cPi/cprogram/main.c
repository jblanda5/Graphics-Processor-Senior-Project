#include "init.h"
#include <stdio.h>
#include "instructions.h"
#include "flatTriangle.h"
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

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

void drawTeaPot(int pi, int scale, int distance, int tx, int ty, int tz, double x_angle, double y_angle, double z_angle) {
    uint8_t color;
    FILE *fptr = fopen("teapot_points.txt", "r");
    if (fptr == NULL) {
        printf("can't open points file.\n");
        return;
    }
    int num_points = 1177;
    double x[num_points];
    double y[num_points];
    double z[num_points];
    double x_prime;
    double x_double_prime;
    double y_prime;
    double y_double_prime;
    double z_prime;
    double z_double_prime;
    double transformed_x[num_points];
    double transformed_y[num_points];
    double transformed_z[num_points];
    for (int i=0; i<num_points; ++i){
        fscanf(fptr, "%lf %lf %lf \n", &x[i],&y[i],&z[i]);
    }
    fclose(fptr);
    fptr = fopen("teapot_triangles.txt", "r");
    if (fptr == NULL) {
        printf("can't open triangles file.\n");
        return;
    }
    int num_triangles = 2256;
    int triangle[num_triangles][3];
    for (int i=0; i<num_triangles; ++i){
        fscanf(fptr, "3 %i %i %i\n", &triangle[i][0],&triangle[i][1],&triangle[i][2]);
//        printf("triangle values: %i,%i,%i\n",triangle[i][0],triangle[i][1],triangle[i][2]);
    }
    fclose(fptr);
    for (int i=0; i<num_points;++i) //Apply transformation
    {
        x_prime = x[i]+tx;
        y_prime = (y[i]+ty)*cos(x_angle) - (z[i]+tz)*sin(x_angle);
        z_prime = (z[i]+tz)*cos(x_angle) + (y[i]+ty)*sin(x_angle);
        x_double_prime = x_prime*cos(y_angle) + z_prime*sin(y_angle);
        y_double_prime = y_prime;
        z_double_prime = z_prime*cos(y_angle) - x_prime*sin(y_angle);
        transformed_x[i] = x_double_prime*cos(z_angle) - y_double_prime*sin(z_angle);
        transformed_y[i] = y_double_prime*cos(z_angle) + x_double_prime*sin(z_angle);
        transformed_z[i] = z_double_prime;
//        printf("got points (%f,%f)\n",transformed_x[i],transformed_y[i]);
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
        x_in1 = (int)(scale*transformed_x[triangle[i][0]]/(transformed_z[triangle[i][0]]+distance))+400;
        y_in1 = (int)(scale*transformed_y[triangle[i][0]]/(transformed_z[triangle[i][0]]+distance))+300;
        x_in2 = (int)(scale*transformed_x[triangle[i][1]]/(transformed_z[triangle[i][1]]+distance))+400;
        y_in2 = (int)(scale*transformed_y[triangle[i][1]]/(transformed_z[triangle[i][1]]+distance))+300;
        x_in3 = (int)(scale*transformed_x[triangle[i][2]]/(transformed_z[triangle[i][2]]+distance))+400;
        y_in3 = (int)(scale*transformed_y[triangle[i][2]]/(transformed_z[triangle[i][2]]+distance))+300;
        if (x_in1 > 800 || x_in2 > 800 || x_in3 > 800 || x_in1 < 0 || x_in2 < 0 || x_in3 < 0 || y_in1 > 600 || y_in2 > 600 || y_in3 > 600 || y_in1 < 0 || y_in2 < 0 || y_in3 < 0) {
            printf("Error: vertex out of bounds.\n");
        }
        else {
            flatTriangle(pi,x_in1,y_in1,x_in2,y_in2,x_in3,y_in3,color);
        }
    }
}

int main(int argc, char *argv[])
{   
    if (argc == 1) {
    int pi = init();
    colorScreen(pi,255);
    drawTeaPot(pi, 700, 10, 0, 0, 0, 3.14159/2, 0, 0);
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
    else if (strcmp(argv[1],"demo") == 0) {
        int pi = init();
        colorScreen(pi,255);
        drawTeaPot(pi, 700, 10, 0, 0, 0, 3.14159/2, 0, 0);
        sleep(5);
        colorScreen(pi,200);
        drawBanana(pi);
        sleep(10);
        colorScreen(pi,255);
        drawTeaPot(pi, 700, 10, 0, 0, 0, 0, 0, 0);
        terminate(pi);
    }
}