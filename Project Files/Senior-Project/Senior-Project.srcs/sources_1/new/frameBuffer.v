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
    output [7:0] pixel_read,
    input wire writeEnable,
    // Clock
    input wire clk
    );
    wire [7:0] douta;
    wire [7:0] dinb;
    blk_mem_gen_0 frameBufferMemory(
    .addrb(readAddr),
    .addra(writeAddr),
    .clkb(clk),
    .clka(clk),
    .doutb(pixel_read),
    .dina(pixel_write),
    .ena(writeEnable),
    .wea(writeEnable),
    .enb(1'b1),
    .douta(douta),
    .dinb(dinb),
    .web(1'b0)
    ); //Frame buffer for 800x600.
endmodule
