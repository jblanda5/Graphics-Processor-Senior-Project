#include <stdio.h>
#include <pigpiod_if2.h>
#include "stdint.h"
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

int main()
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

    set_mode(pi, RTR, PI_INPUT);
    set_pull_up_down(pi, RTR, PI_PUD_DOWN);


    gpio_write(pi, BIT7, 1);
    gpio_write(pi, BIT6, 1);
    gpio_write(pi, BIT5, 1);
    gpio_write(pi, BIT4, 1);
    gpio_write(pi, BIT3, 1);
    gpio_write(pi, BIT2, 1);
    gpio_write(pi, BIT1, 1);
    gpio_write(pi, BIT0, 1);
    gpio_write(pi, RTS, 0);

    printf("Reading an RTR value of %i\n",gpio_read(pi, RTR));
    sleep(100);
    pigpio_stop(pi);
}