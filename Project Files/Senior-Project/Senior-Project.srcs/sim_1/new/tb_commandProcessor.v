`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 09:55:22 AM
// Design Name: 
// Module Name: tb_commandProcessor
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


module tb_commandProcessor;
reg write_en; 
wire full, empty;
reg read_en;
wire [31:0] dataOut;
reg [31:0] dataIn;
reg clk;
commandProcessor vram(
write_en,
read_en,
full,
empty, 
dataOut,
dataIn,
clk
);
integer i=0;
    initial begin
    write_en <= 1;
    read_en <= 0;
    while (i<1100) begin
        if (full) begin
            write_en <= 0;
            read_en <= 1;
        end
        if (empty) begin
            write_en <= 1;
            read_en <= 0;
        end
        clk <= 0;
        dataIn <= 'h11111111;
        #1;
        clk <= 1;
        i = i+1;
        #1;
        end
     end
endmodule
