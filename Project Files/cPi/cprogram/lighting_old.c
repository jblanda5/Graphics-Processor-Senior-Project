#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

uint8_t lighting(uint8_t color, int scale, double x1, double y1, double z1, double x2, double y2, double z2, double x3, double y3, double z3) {
    double va[3] = {scale*x1 - scale*x3, scale*y1 - scale*y3, scale*z1 - scale*z3};
    double vb[3] = {scale*x2 - scale*x3, scale*y2 - scale*y3, scale*z2 - scale*z3};
    double normal_x = va[1]*vb[2] - va[2]*vb[1];
    double normal_y = va[2]*vb[0] - va[0]*vb[2];
    double normal_z = va[0]*vb[1] - va[1]*vb[0];
    if (normal_x == 0 && normal_y == 0 && normal_z == 0) {
        printf("Error: normal vector is 0.\n");
        printf("Point values: (%f, %f, %f), (%f, %f, %f), (%f, %f, %f)\n",x1,y1,z1,x2,y2,z2,x3,y3,z3);
        printf("Vector A:<%f,%f,%f>\n",va[0],va[1],va[2]);
        printf("Vector B:<%f,%f,%f>\n",vb[0],vb[1],vb[2]);
        return 0;
    }
    if (normal_z == 0) {
        return 0;
    }
    //Normalize vector to 1
    //printf("X:%f Y:%f Z:%f\n", normal_x, normal_y, normal_z);
    //printf("Magnitude:%f\n",sqrt(normal_x*normal_x + normal_y*normal_y + normal_z*normal_z));
    double denom = sqrt(normal_x*normal_x + normal_y*normal_y + normal_z*normal_z);
    normal_x = normal_x / denom;
    normal_y = normal_y / denom;
    normal_z = normal_z / denom;
    double dot_product = normal_x*0.57735 + normal_y*0.57735 + normal_z*0.57735; //We'll say the viewport has a vector of <1/sqrt(3), 1/sqrt(3), 1/sqrt(3)>
    //double dot_product = normal_z;
    if (dot_product < 0) { //abs
        dot_product = dot_product*(-1);
    }
    if (dot_product > 1) { //account for floating point inaccuracies
        dot_product = 1;
    }
    dot_product =  (dot_product + 0.5) / 1.5;
    dot_product += 0.25;
    if (dot_product > 1) {
        dot_product = 1;
    }
    //If the dot product is 0, there will be no lighting. If the dot product is 1, our lighting is dead on.
    uint8_t r = color >> 5;
    uint8_t g = (color >> 2) & 7;
    uint8_t b = color & 3;
    //printf("dot product:%f\n",dot_product);
    r = (int)r*dot_product;
    g = (int)g*dot_product;
    b = (int)b*dot_product;
    uint8_t new_color = (r << 5) | (g << 2) | b;
    return new_color;
}