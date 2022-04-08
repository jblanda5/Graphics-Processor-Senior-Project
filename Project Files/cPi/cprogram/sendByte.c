#include <stdio.h>
#include <pigpiod_if2.h>
#include <stdint.h>
#include <unistd.h>

#define BIT7 25
#define BIT6 24
#define BIT5 23
#define BIT4 18
#define BIT3 22
#define BIT2 27
#define BIT1 17
#define BIT0 4
#define RTS 21
#define RTR 20

int sendByte(int pi, uint8_t byte){
    if ((byte & 128) > 0){
        gpio_write(pi, BIT7, 1);
    }
    else {
        gpio_write(pi, BIT7, 0);
    }
    
    if ((byte & 64) > 0){
        gpio_write(pi, BIT6, 1);
    }
    else {
        gpio_write(pi, BIT6, 0);
    }
    
    if ((byte & 32) > 0){
        gpio_write(pi, BIT5, 1);
    }
    else {
        gpio_write(pi, BIT5, 0);
    }
    
    if ((byte & 16) > 0){
        gpio_write(pi, BIT4, 1);
    }
    else {
        gpio_write(pi, BIT4, 0);
    }
    
    if ((byte & 8) > 0){
        gpio_write(pi, BIT3, 1);
    }
    else {
        gpio_write(pi, BIT3, 0);
    }
    
    if ((byte & 4) > 0){
        gpio_write(pi, BIT2, 1);
    }
    else {
        gpio_write(pi, BIT2, 0);
    }
    
    if ((byte & 2) > 0){
        gpio_write(pi, BIT1, 1);
    }
    else {
        gpio_write(pi, BIT1, 0);
    }
    
    if ((byte & 1) > 0){
        gpio_write(pi, BIT0, 1);
    }
    else {
        gpio_write(pi, BIT0, 0);
    }
//    printf("sent byte:%i\n",byte);
    return 0;
}