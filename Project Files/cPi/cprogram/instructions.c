#include <stdio.h>
#include <stdint.h>
#include "sendInstruction_safe.h"
#include "reset.h"

void drawLine(int x1, int y1, int x2, int y2, uint8_t color){
    //Opcode is 0010
    long long Instruction;
    uint8_t msB;
    msB = 2 << 4;
    msB += (color >> 4);
    Instruction = color; //the first 4 bits here will be pushed out
    Instruction = Instruction << 10;
    Instruction += x1;
    Instruction = Instruction << 10;
    Instruction += y1;
    Instruction = Instruction << 10;
    Instruction += x2;
    Instruction = Instruction << 10;
    Instruction += y2;
    Instruction = Instruction << 20;
    sendInstruction(msB, Instruction);
}

void drawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, uint8_t color){
    //Opcode is 0100
    long long Instruction;
    uint8_t msB;
    msB = 4 << 4;
    msB += (color >> 4);
    Instruction = color; //the first 4 bits here will be pushed out
    Instruction = Instruction << 10;
    Instruction += x1;
    Instruction = Instruction << 10;
    Instruction += y1;
    Instruction = Instruction << 10;
    Instruction += x2;
    Instruction = Instruction << 10;
    Instruction += y2;
    Instruction = Instruction << 10;
    Instruction += x3;
    Instruction = Instruction << 10;
    Instruction += y3;
    sendInstruction(msB, Instruction);
}

void colorScreen(uint8_t color){
    //Opcode is 0011
    long long Instruction;
    uint8_t msB;
    msB = 3 << 4;
    msB += (color >> 4);
    Instruction = color;
    Instruction = Instruction << 60;
    sendInstruction(msB, Instruction);
}