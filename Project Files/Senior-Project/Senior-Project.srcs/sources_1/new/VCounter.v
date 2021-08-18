`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The College of New Jersey
// Engineer: Jeffrey Blanda
// 
// Create Date: 08/18/2021 02:17:39 PM
// Design Name: Vertical Counter
// Module Name: VCounter
// Project Name: Video FX FPGA
// Target Devices: 
// Tool Versions: 
// Description: This will generate the Vertical Sync signal
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// for 800x600 resolution @60Hz
// 1px front porch
// 23 pixel back porch
// 40Mhz Pixel Clock

module VCounter(
input Hsync,
output Vsync
    );
endmodule
