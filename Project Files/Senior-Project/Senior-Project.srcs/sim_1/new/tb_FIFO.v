`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2021 01:13:03 PM
// Design Name: 
// Module Name: tb_FIFO
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


module tb_FIFO();
wire full;
reg[70:0] dataIn;
reg write_en;
wire empty;
wire[70:1] dataOut;
reg read_clk;
reg read_en;
reg clk;
commandFIFO TESTFIFO(
.full(full), 
.din(dataIn), 
.wr_en(write_en), 
.empty(empty), 
.dout(dataOut), 
.rd_en(read_en),
.rd_clk(read_clk),
.wr_clk(clk)
);

integer i=0;
  initial begin
  read_clk <= 0;
  #5
    while(1) begin
        read_clk <= ~read_clk;
        #1;
    end
  end
  initial begin
        clk <= 0;
        dataIn <= 71'b11111111111111111111111111111111111111111111111111111111111111111111111;
        write_en <= 1;
        #1;
        clk <= 1;
        #1;
        clk <= 0;
        dataIn <= 71'b01010101010101010101010101010101010101010101010101010101010101010101010;
        #1;
        clk <= 1;
        #5;
    while (i<20) begin
        read_en <= 0;
        #1;
        read_en <= 1;
        i = i+1;
        #1;
      end
   end
     
endmodule
