#include <pigpiod_if2.h>

#define RESET 26
void reset(int pi)
{
    gpio_write(pi, RESET, 1);
    while (gpio_read(pi, RESET) == 0) {}
    gpio_write(pi, RESET, 0);
}