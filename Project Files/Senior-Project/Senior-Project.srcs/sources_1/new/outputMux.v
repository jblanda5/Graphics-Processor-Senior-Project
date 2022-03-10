`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2021 10:37:17 PM
// Design Name: 
// Module Name: outputMux
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


module outputMux(
input wire [18:0] drawLineAddr,
input wire [18:0] blankScreenAddr,
input wire [18:0] drawTriangleAddr,
input wire rtrDrawLine,
input wire rtrBlankScreen,
input wire rtrDrawTriangle,
output wire [18:0] writeAddr,
output wire writeEnable
    );
    assign writeAddr = (rtrDrawLine ? (rtrBlankScreen ? (rtrDrawTriangle ? 0 :drawTriangleAddr) : blankScreenAddr) : drawLineAddr); //replace 0 with (rtrDrawTriangle ? 0 : drawTriangleAddr)
    assign writeEnable = ~(rtrDrawLine & rtrBlankScreen & rtrDrawTriangle); // add & rtrDrawTriangle
endmodule
