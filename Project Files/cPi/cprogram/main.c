#include "init.h"
#include <stdio.h>
#include "instructions.h"
#include "flatTriangle.h"
#include "lighting.h"
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

double calc_distance(double x[], double y[], double z[], int triangles[][3], int index, int distance) {
    double x1 = (int)x[triangles[index][0]];
    double y1 = (int)y[triangles[index][0]];
    double z1 = (int)z[triangles[index][0]]+distance;
    double x2 = (int)x[triangles[index][1]];
    double y2 = (int)y[triangles[index][1]];
    double z2 = (int)z[triangles[index][1]]+distance;
    double x3 = (int)x[triangles[index][2]];
    double y3 = (int)y[triangles[index][2]];
    double z3 = (int)z[triangles[index][2]]+distance;
    double dist1 = sqrt(x1*x1+y1*y1+z1*z1);
    double dist2 = sqrt(x2*x2+y2*y2+z2*z2);
    double dist3 = sqrt(x3*x3+y3*y3+z3*z3);
    if (dist1 > dist2 && dist1 > dist3) {
        return dist1;
    }
    else if (dist2 > dist1 && dist2 > dist3) {
        return dist2;
    }
    else {
        return dist3;
    }
    //double added_distance = sqrt((x1*x1) + (y1*y1) + (z1*z1)) + sqrt((x2*x2) + (y2*y2) + (z2*z2)) + sqrt((x3*x3) + (y3*y3) + (z3*z3));
    //double added_distance = sqrt((double)z1*(double)z1 + (double)z2*(double)z2 + (double)z3*(double)z3);
    //int added_distance = x1 + x2 + x3 + y1 + y2 + y3 + z1 + z2 + z3;
    //return added_distance;
}

void drawBanana() {
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
        flatTriangle(x1[i],y1[i],x2[i],y2[i],x3[i],y3[i],color[i]);
    }
}

void drawTeaPot(int scale, int distance, int tx, int ty, int tz, double x_angle, double y_angle, double z_angle, uint8_t color) {
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
    //Bubble sort to sort triangles by distance to the viewpoint
    int temp[3];
    double x1;
    double y1;
    double z1;
    double x2;
    double y2;
    double z2;
    double x3;
    double y3;
    double z3;
    int lighted_color[num_triangles];
    for (int i=0; i<num_triangles-1; ++i) {
        x1 = transformed_x[triangle[i][0]];
        x2 = transformed_x[triangle[i][1]];
        x3 = transformed_x[triangle[i][2]];
        y1 = transformed_y[triangle[i][0]];
        y2 = transformed_y[triangle[i][1]];
        y3 = transformed_y[triangle[i][2]];
        z1 = transformed_z[triangle[i][0]]+distance;
        z2 = transformed_z[triangle[i][1]]+distance;
        z3 = transformed_z[triangle[i][2]]+distance;
        lighted_color[i] = lighting(color,x1,y1,z1,x2,y2,z2,x3,y3,z3);
        for (int j=0; j<(num_triangles - 1 - i); ++j) {
            if (calc_distance(transformed_x,transformed_y,transformed_z,triangle,j,distance) > calc_distance(transformed_x,transformed_y,transformed_z,triangle,j+1,distance)) {
                temp[0] = triangle[j][0];
                temp[1] = triangle[j][1];
                temp[2] = triangle[j][2];
                triangle[j][0] = triangle[j+1][0];
                triangle[j][1] = triangle[j+1][1];
                triangle[j][2] = triangle[j+1][2];
                triangle[j+1][0] = temp[0];
                triangle[j+1][1] = temp[1];
                triangle[j+1][2] = temp[2];
            }
        }
    }
    int x_in1[num_triangles];
    int y_in1[num_triangles];
    int x_in2[num_triangles];
    int y_in2[num_triangles];
    int x_in3[num_triangles];
    int y_in3[num_triangles];
    for (int i=0; i<num_triangles-1;++i) {
            x_in1[i] = (int)(scale*transformed_x[triangle[i][0]]/(transformed_z[triangle[i][0]]+distance))+400;
            y_in1[i] = (int)(scale*transformed_y[triangle[i][0]]/(transformed_z[triangle[i][0]]+distance))+300;
            x_in2[i] = (int)(scale*transformed_x[triangle[i][1]]/(transformed_z[triangle[i][1]]+distance))+400;
            y_in2[i] = (int)(scale*transformed_y[triangle[i][1]]/(transformed_z[triangle[i][1]]+distance))+300;
            x_in3[i] = (int)(scale*transformed_x[triangle[i][2]]/(transformed_z[triangle[i][2]]+distance))+400;
            y_in3[i] = (int)(scale*transformed_y[triangle[i][2]]/(transformed_z[triangle[i][2]]+distance))+300;
        if (x_in1[i] > 800 || x_in2[i] > 800 || x_in3[i] > 800 || x_in1[i] < 0 || x_in2[i] < 0 || x_in3[i] < 0 || y_in1[i] > 600 || y_in2[i] > 600 || y_in3[i] > 600 || y_in1[i] < 0 || y_in2[i] < 0 || y_in3[i] < 0) {
            printf("Error: vertex out of bounds.\n");
            x_in1[i] = 0;
            x_in2[i] = 0;
            x_in3[i] = 0;
            y_in1[i] = 0;
            y_in2[i] = 0;
            y_in3[i] = 0;
        }
    }
    for (int i=0; i<num_triangles-1;++i) { //Draw
            flatTriangle(x_in1[i],y_in1[i],x_in2[i],y_in2[i],x_in3[i],y_in3[i],lighted_color[i]);
    }
}

int main(int argc, char *argv[])
{   
    if (argc == 1) {
    init();
    colorScreen(0);
    drawTeaPot(700, 10, 0, 0, 0, 3.14159/2, 0, 0, 255);
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
    }
    else if (strcmp(argv[1],"demo") == 0) {
        init();
        colorScreen(255);
        drawTeaPot(700, 10, 0, 0, 0, 3.14159/4, 3.14159/4, 0, 16);
        printf("Drew Green tea pot!\n");
        sleep(10);
        //colorScreen(pi,200);
        //drawBanana(pi);
        int x=0;
        for (int i=0; i<256; ++i) {
            drawLine(x,0,x,600,i);
            drawLine(x+1,0,x+1,600,i);
            drawLine(x+2,0,x+2,600,i);
            x = x+3;
        }
        sleep(10);
        colorScreen(255);
        drawTeaPot(700, 10, 0, 0, 0, 0, 0, 0, 2);
        printf("Drew Blue tea pot!\n");
        sleep(10);
        colorScreen(0);
        drawTeaPot(700, 10, 0, 0, 0, 3.14159/2, 0, 0, 128);
        printf("Drew Red tea pot!\n");
        terminate();
    }
}