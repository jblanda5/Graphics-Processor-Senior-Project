#include <stdio.h>
#include <pigpio.h>
from sendByte import sendByte

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

/*
This program runs on the assumption that the receiving interface (FPGA) is going to operate at a much faster speed than the GPIO,
therefore we can remove some of the waiting.
*/

int sendInstruction(uint instruction){
    uint8 byte;
    byte = instruction >> 64; //8 MSB of Instruction
    while (gpioRead(RTR) == 0)
    {
        //Latch until FPGA is ready to recieve
    }
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 56;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 48;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 40;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 32;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 24;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 16;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction >> 8;
    sendByte(byte);
    while (gpioRead(RTR) == 0)
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0); //De-assert RTS once input has been accepted
    byte = instruction;
    sendByte(byte);
    gpioWrite(RTS, 1);
    while (gpioRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    gpioWrite(RTS, 0);
    return 0;
}