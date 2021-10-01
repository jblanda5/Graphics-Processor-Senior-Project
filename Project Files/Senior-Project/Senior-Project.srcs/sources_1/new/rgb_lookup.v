`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 04:20:53 PM
// Design Name: 
// Module Name: rgb_lookup
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


module rgb_lookup(
    input [7:0] pixel,
    output wire [11:0] vga
    );
    reg[3:0] red,green,blue;
    assign vga = (red << 8) + (green << 4) + blue;
    always @(pixel) begin
    case(pixel[7:5])
        3'b000 : red <= 4'b0000;
        3'b001 : red <= 4'b0010;
        3'b010 : red <= 4'b0100;
        3'b011 : red <= 4'b0110;
        3'b100 : red <= 4'b1000;
        3'b101 : red <= 4'b1010;
        3'b110 : red <= 4'b1100;
        3'b111 : red <= 4'b1111;
    endcase
    case(pixel[4:2])
        3'b000 : green <= 4'b0000;
        3'b001 : green <= 4'b0010;
        3'b010 : green <= 4'b0100;
        3'b011 : green <= 4'b0110;
        3'b100 : green <= 4'b1000;
        3'b101 : green <= 4'b1010;
        3'b110 : green <= 4'b1100;
        3'b111 : green <= 4'b1111;
    endcase
    case(pixel[1:0])
        2'b00 : blue <= 4'b0000;
        2'b01 : blue <= 4'b0101;
        2'b10 : blue <= 4'b1010;
        2'b11 : blue <= 4'b1111;
    endcase
    end
endmodule
