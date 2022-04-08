#include <stdio.h>
#include <pigpiod_if2.h>

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
#define RESET 26


int init()
{
    int pi = pigpio_start(NULL, NULL);

    set_mode(pi, BIT7, PI_OUTPUT);
    set_mode(pi, BIT6, PI_OUTPUT);
    set_mode(pi, BIT5, PI_OUTPUT);
    set_mode(pi, BIT4, PI_OUTPUT);
    set_mode(pi, BIT3, PI_OUTPUT);
    set_mode(pi, BIT2, PI_OUTPUT);
    set_mode(pi, BIT1, PI_OUTPUT);
    set_mode(pi, BIT0, PI_OUTPUT);
    set_mode(pi, RTS, PI_OUTPUT);
    set_mode(pi, RESET, PI_OUTPUT);

    set_mode(pi, RTR, PI_INPUT);
    set_pull_up_down(pi, RTR, PI_PUD_DOWN);
   return pi;
}

void terminate(int pi) {
    pigpio_stop(pi);
}