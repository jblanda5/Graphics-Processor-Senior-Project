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
    input [18:0] writeBus,
    input [2:0] R_write,
    input [2:0] G_write,
    input [1:0] B_write,
    // Output frame I/O
    input [18:0] index,
    output reg [2:0] R_read,
    output reg [2:0] G_read,
    output reg [1:0] B_read,
    // Clock
    input CLK
    );
    reg[7:0] frame[480000:0]; //Frame buffer for 800x600. Extra pixel for designated blanking.
    always @(posedge CLK) begin
    frame[writeBus] <= (R_write << 5) + (G_write << 2) + (B_write);
    R_read <= (frame[index] >> 5) & 3'b111;
    G_read <= (frame[index] >> 2) & 3'b111;
    B_read <= (frame[index]) & 2'b11;
    Pixel <= frame[index];
    end
endmodule
