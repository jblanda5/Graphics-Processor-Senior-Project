#include <stdio.h>

void drawLine(int x1, int y1, int x2, int y2, int color){
    //Opcode is 0010
    unsigned int Instruction;
    Instruction = 2 << 8;
    Instruction += color;
    Instruction << 10;
    Instruction += x1;
    Instruction << 10;
    Instruction += y1;
    Instruction << 10;
    Instruction += x2;
    Instruction << 10;
    Instruction += y2;
    Instruction << 20;
    sendInstruction(Instruction);
}

void drawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, int color){
    //Opcode is 0100
    unsigned int Instruction;
    Instruction = 4 << 8;
    Instruction += color;
    Instruction << 10;
    Instruction += x1;
    Instruction << 10;
    Instruction += y1;
    Instruction << 10;
    Instruction += x2;
    Instruction << 10;
    Instruction += y2;
    Instruction << 10;
    Instruction += x3;
    Instruction << 10;
    Instruction += y3;
    sendInstruction(Instruction);
}

void colorScreen(int color){
    //Opcode is 0011
    unsigned int Instruction;
    Instruction = 4 << 8;
    Instruction += color;
    Instruction << 60;
    sendInstruction(Instruction);
}