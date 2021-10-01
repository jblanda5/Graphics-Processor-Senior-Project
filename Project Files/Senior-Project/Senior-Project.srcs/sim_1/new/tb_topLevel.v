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
TopLevel testTopLevel(CLK100MHZ,Hsync,Vsync,vga);

integer i=0;
  initial begin
    while (i<2500000) begin
        CLK100MHZ <= 0;
        #1;
        CLK100MHZ <= 1;
        i = i+1;
        #1;
      end
   end
     
endmodule
