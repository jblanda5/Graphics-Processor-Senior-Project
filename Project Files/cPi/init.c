#include <stdio.h>
#include <pigpio.h>

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

The internal gpio pull-up is enabled, as for a high impedence we want a default 'low' read value.

gcc -o X X.c -lpigpio
*/

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


int init()
{
   if (gpioInitialise()<0) return 1;

   gpioSetMode(BIT7, PI_OUTPUT);
   gpioSetMode(BIT6, PI_OUTPUT);
   gpioSetMode(BIT5, PI_OUTPUT);
   gpioSetMode(BIT4, PI_OUTPUT);
   gpioSetMode(BIT3, PI_OUTPUT);
   gpioSetMode(BIT2, PI_OUTPUT);
   gpioSetMode(BIT1, PI_OUTPUT);
   gpioSetMode(BIT0, PI_OUTPUT);
   gpioSetMode(RTS, PI_OUTPUT);

   gpioSetMode(RTR, PI_INPUT);
   gpioSetPullUpDown(RTR, PI_PUD_UP);

   //gpioSetAlertFunc(HALL, alert); //Can we use this to trigger data output? If we can call a function when RTR goes high?
   //gpioTerminate();
   return 0;
}

int terminate() {
    gpioTerminate();
    return 0;
}