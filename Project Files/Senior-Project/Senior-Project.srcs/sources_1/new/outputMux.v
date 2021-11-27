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
input wire rtrDrawLine,
output wire [18:0] writeAddr,
output wire writeEnable
    );
    assign writeAddr = (rtrDrawLine ? 0 : drawLineAddr); //replace 0 with (rtrDrawTriangle ? 0 : drawTriangleAddr)
    assign writeEnable = ~(rtrDrawLine); // add | rtrDrawTriangle
endmodule
