#include <stdio.h>
#include <pigpio.h>

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

int sendByte(uint8 byte){
    if (byte & 128 > 0){
        gpioWrite(BIT7, 1);
    }
    else {
        gpioWrite(BIT7, 0);
    }
    
    if (byte & 64 > 0){
        gpioWrite(BIT6, 1);
    }
    else {
        gpioWrite(BIT6, 0);
    }
    
    if (byte & 32 > 0){
        gpioWrite(BIT5, 1);
    }
    else {
        gpioWrite(BIT5, 0);
    }
    
    if (byte & 16 > 0){
        gpioWrite(BIT4, 1);
    }
    else {
        gpioWrite(BIT4, 0);
    }
    
    if (byte & 8 > 0){
        gpioWrite(BIT3, 1);
    }
    else {
        gpioWrite(BIT3, 0);
    }
    
    if (byte & 4 > 0){
        gpioWrite(BIT2, 1);
    }
    else {
        gpioWrite(BIT2, 0);
    }
    
    if (byte & 2 > 0){
        gpioWrite(BIT1, 1);
    }
    else {
        gpioWrite(BIT1, 0);
    }
    
    if (byte & 1 > 0){
        gpioWrite(BIT0, 1);
    }
    else {
        gpioWrite(BIT0, 0);
    }
    return 0;
}