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
    pixel_read <= (frame[readAddr+7] << 7) + (frame[readAddr+6] << 6) + (frame[readAddr+5] << 5) + (frame[readAddr+4] << 4) + (frame[readAddr+3] << 3) + (frame[readAddr+2] << 2) + (frame[readAddr+1] << 1) + (frame[readAddr]);
    pixel_read <= frame[readAddr];
    end
endmodule
