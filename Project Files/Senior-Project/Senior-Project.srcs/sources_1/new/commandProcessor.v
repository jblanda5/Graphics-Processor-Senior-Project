`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 09:31:43 AM
// Design Name: 
// Module Name: commandProcessor
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


module commandProcessor(
input wire write_en, read_en,
output wire full, empty,
output wire [31:0] dataOut,
input wire [31:0] dataIn,
input wire clk
);

//Instantiate FIFO object
commandFIFO commandBuffer(
.full(full), 
.din(dataIn), 
.wr_en(write_en), 
.empty(empty), 
.dout(dataOut), 
.rd_en(read_en), 
.clk(clk)
);
endmodule
