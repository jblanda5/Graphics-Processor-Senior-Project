`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2021 07:29:03 PM
// Design Name: 
// Module Name: TEST
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TEST(
    input wire CLK100MHZ,
    output wire Hsync, //Horizontal Sync signal  
    output wire Vsync, //Vertical Sync signal
    output wire [11:0] vga, //Pixel output
    input wire [3:0] x1,
    input wire [3:0] y1,
    input wire [3:0] x2,
    input wire [3:0] y2,
    input wire write_en
);
    wire [70:0] dataIn;
    assign dataIn = 71'b0 | (3'b010 << 68) | (8'b11100000 << 60) | (x1 << 55) | (y1 << 45) | (x2 << 35) | (y2 << 25);
    
TopLevel graphicsCard(
    .CLK100MHZ(CLK100MHZ),
    .Hsync(Hsync), //Horizontal Sync signal  
    .Vsync(Vsync), //Vertical Sync signal
    .vga(vga), //Pixel output
    .dataIn(dataIn),
    .write_en(write_en)
);
endmodule
