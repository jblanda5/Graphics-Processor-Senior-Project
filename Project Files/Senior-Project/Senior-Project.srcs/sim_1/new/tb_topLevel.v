`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 01:14:13 PM
// Design Name: 
// Module Name: tb_topLevel
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


module tb_topLevel();
reg CLK100MHZ;
wire Hsync;
wire Vsync;
wire [11:0]vga;
reg [70:0] dataIn;
reg write_en;
TopLevel testTopLevel(CLK100MHZ,Hsync,Vsync,vga,dataIn,write_en);

integer i=0;
  initial begin
        CLK100MHZ <= 0;
        dataIn <= 71'b11111111111111111111111111111111111111111111111111111111111111111111111;
        write_en <= 1;
        #1;
        CLK100MHZ <= 1;
        i = i+1;
        #1;
        CLK100MHZ <= 0;
        dataIn <= 71'b01010101010101010101010101010101010101010101010101010101010101010101010;
        #1;
        CLK100MHZ <= 1;
        #1;  
    while (i<2500000) begin
        CLK100MHZ <= 0;
        #1;
        CLK100MHZ <= 1;
        i = i+1;
        #1;
      end
   end
     
endmodule
