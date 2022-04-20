#include <stdio.h>
#include <wiringPi.h>

/*
Initialize Pins to send data to FPGA

Pin 22 - (GPIO 25) MSB
Pin 18 - (GPIO 24)
Pin 16 - (GPIO 23)
Pin 12 - (GPIO 18)
Pin 15 - (GPIO 22)
Pin 13 - (GPIO 27)
Pin 11 - (GPIO 17)
Pin 7  - (GPIO 4) LSB
Pin 40 - (GPIO 21) Output, RTS
Pin 38 - (GPIO 20) Input, RTR
Pin 37 - (GPIO 26) Reset
The internal gpio pull-up is enabled, as for a high impedence we want a default 'low' read value.

gcc -o X X.c -lpigpio
*/

#define BIT7 7
#define BIT6 6
#define BIT5 5
#define BIT4 4
#define BIT3 3
#define BIT2 2
#define BIT1 1
#define BIT0 0
#define RTS 21
#define RTR 20
#define RESET 26


void init()
{
    wiringPiSetupGpio();

    pinMode(BIT7, OUTPUT);
    pinMode(BIT6, OUTPUT);
    pinMode(BIT5, OUTPUT);
    pinMode(BIT4, OUTPUT);
    pinMode(BIT3, OUTPUT);
    pinMode(BIT2, OUTPUT);
    pinMode(BIT1, OUTPUT);
    pinMode(BIT0, OUTPUT);
    pinMode(RTS, OUTPUT);
    pinMode(RESET, OUTPUT);

    pinMode(RTR, INPUT);
    pullUpDnControl(RTR, PUD_DOWN);
}