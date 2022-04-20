//#include <stdio.h>
#include <wiringPi.h>
#include "stdint.h"
//#include <unistd.h>

#define RTS 21
#define RTR 20


//This operates under the assumption that the FPGA will always be ready to recieve after recieving the previous byte as it is much faster than the GPIO on the Pi

int sendInstruction(int msB, long long instruction){
    int byte;
    byte = msB; //MSB of Instruction
    while (digitalRead(RTR) == 0)
    {
        //Latch until FPGA is ready to recieve
    }
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 56;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 48;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 40;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 32;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 24;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 16;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction >> 8;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW); //De-assert RTS once input has been accepted
    byte = instruction;
    digitalWriteByte(byte);
    digitalWrite(RTS, HIGH);
    while (digitalRead(RTR) == 1)
    {
        //Latch until FPGA has received byte
    }
    digitalWrite(RTS, LOW);
    return 0;
}