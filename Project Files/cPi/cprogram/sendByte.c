//#include <stdio.h>
#include <wiringPi.h>
#include <stdint.h>
//#include <unistd.h>

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

int sendByte(uint8_t byte){
    if ((byte & 128) > 0){
        digitalWrite(BIT7, HIGH);
    }
    else {
        digitalWrite(BIT7, LOW);
    }
    
    if ((byte & 64) > 0){
        digitalWrite(BIT6, HIGH);
    }
    else {
        digitalWrite(BIT6, LOW);
    }
    
    if ((byte & 32) > 0){
        digitalWrite(BIT5, HIGH);
    }
    else {
        digitalWrite(BIT5, LOW);
    }
    
    if ((byte & 16) > 0){
        digitalWrite(BIT4, HIGH);
    }
    else {
        digitalWrite(BIT4, LOW);
    }
    
    if ((byte & 8) > 0){
        digitalWrite(BIT3, HIGH);
    }
    else {
        digitalWrite(BIT3, LOW);
    }
    
    if ((byte & 4) > 0){
        digitalWrite(BIT2, HIGH);
    }
    else {
        digitalWrite(BIT2, LOW);
    }
    
    if ((byte & 2) > 0){
        digitalWrite(BIT1, HIGH);
    }
    else {
        digitalWrite(BIT1, LOW);
    }
    
    if ((byte & 1) > 0){
        digitalWrite(BIT0, HIGH);
    }
    else {
        digitalWrite(BIT0, LOW);
    }
//    printf("sent byte:%i\n",byte);
    return 0;
}