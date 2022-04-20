//#include <stdio.h>
#include <wiringPi.h>
#include "sendByte.h"
#include "stdint.h"
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


void delay() { //Delay for CYCLES plus function call time.
}

//This operates under the assumption that the FPGA will always be ready to recieve after recieving the previous byte as it is much faster than the GPIO on the Pi

int sendInstruction(int pi, uint8_t msB, long long instruction){
    uint8_t byte;
    byte = msB; //MSB of Instruction
    while (digitalRead(RTR) == 0)
    {
        //Latch until FPGA is ready to recieve
    }
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 56;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 48;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 40;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 32;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 24;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 16;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 8;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction;
    sendByte(pi, byte);
    digitalWrite(RTS, HIGH);
//    while (digitalRead(RTR) == 1)
//    {
        //Latch until FPGA has received byte
//    }
    delay();
    digitalWrite(RTS, LOW);
    return 0;
}