`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2021 04:28:13 PM
// Design Name: 
// Module Name: writeMux
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


module writeMux(
input[9:0] xLineDraw,
input[9:0] yLineDraw,
input[7:0] colorLineDraw,
input[1:0] select,
output wire[9:0] xOut,
output wire[9:0] yOut,
output wire[7:0] color
);
assign xOut = select[1] ? (select[0] ? xLineDraw : 8'b00000000) : (select[0] ? 8'b00000000 : 8'b00000000);
assign yOut = select[1] ? (select[0] ? yLineDraw : 8'b00000000) : (select[0] ? 8'b00000000 : 8'b00000000);
assign color = select[1] ? (select[0] ? colorLineDraw : 8'b00000000) : (select[0] ? 8'b00000000 : 8'b00000000);
endmodule
