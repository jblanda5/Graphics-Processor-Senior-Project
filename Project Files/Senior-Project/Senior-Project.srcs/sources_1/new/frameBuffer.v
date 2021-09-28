`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2021 10:02:33 AM
// Design Name: 
// Module Name: frameBuffer
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


module frameBuffer(
    // Write to frame inputs
    input [18:0] writeAddr,
    input [7:0] pixel_write,
    // Output frame I/O
    input [18:0] readAddr,
    output reg [7:0] pixel_read,
    // Clock
    input CLK
    );
    reg[7:0] frame[479999:0]; //Frame buffer for 800x600.
    always @(posedge CLK) begin
    frame[writeAddr] <= pixel_write;
    pixel_read <= frame[readAddr];
    end
endmodule
