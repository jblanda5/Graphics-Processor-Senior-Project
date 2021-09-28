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
    output wire [7:0] pixel_read,
    input wire writeEnable,
    // Clock
    input wire CLK
    );
    blk_mem_gen_0 frameBufferMemory( //This is wrong and needs to be fixed.
    .addra(writeAddr),
    
    writeAddr,readAddr,CLK,CLK,pixel_write,writeEnable,pixel_read
    ); //Frame buffer for 800x600.
endmodule
