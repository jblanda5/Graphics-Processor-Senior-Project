#include <pigpiod_if2.h>

#define RESET 26
void reset()
{
    digitalWrite(RESET, 1);
    while (digitalRead(RESET) == 0) {}
    digitalWrite(RESET, 0);
}