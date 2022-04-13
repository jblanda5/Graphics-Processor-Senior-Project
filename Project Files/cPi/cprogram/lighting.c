#include <stdint.h>
#include <math.h>

uint8_t lighting(uint8_t color, double x1, double y1, double z1, double x2, double y2, double z2, double x3, double y3, double z3) {
double difference[3] = {1 - x1, 1 - y1, 1 - z1}; 
double a_vector[3] = {x2-x1, y2-y1, z2-z1};
double b_vector[3] = {x3-x1, y3-y1, z3-z1};
double w_vector[3] = {a_vector[1]*b_vector[2] - a_vector[3]*b_vector[1], a_vector[2]*b_vector[0] - a_vector[0]*b_vector[2], a_vector[0]*b_vector[1] - a_vector[1]*b_vector[0]};
//Normalize
double temp = sqrt(w_vector[0]*w_vector[0] + w_vector[1]*w_vector[1] + w_vector[2]*w_vector[2]);
w_vector[0] = w_vector[0] / temp;
w_vector[1] = w_vector[1] / temp;
w_vector[2] = w_vector[2] / temp;
temp = sqrt(difference[0]*difference[0] + difference[1]*difference[1] + difference[2]*difference[2]);
difference[0] = difference[0] / temp;
difference[1] = difference[1] / temp;
difference[2] = difference[2] / temp;
//Dot Product
double dotProduct = w_vector[0]*difference[0] + w_vector[1]*difference[1] + w_vector[2]*difference[2];
//Get new lighting value
uint8_t r = (7 & (color >> 5));
uint8_t g = (7 & (color >> 2));
uint8_t b = (3 & (color));
r = r*dotProduct;
g = g*dotProduct;
b = b*dotProduct;
uint8_t newColor = (r << 5) | (g << 2) | b;
return newColor;
}