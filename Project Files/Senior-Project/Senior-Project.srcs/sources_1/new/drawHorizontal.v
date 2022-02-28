`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2022 02:23:27 PM
// Design Name: 
// Module Name: drawHorizontal
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


module drawHorizontal(
input wire [9:0]x1,
input wire [9:0]x2,
input wire clk,
output reg [9:0]x,
input wire rts,
output reg rtr
);
reg [1:0]state;
parameter reset = 2'b00;
parameter idle = 2'b01;
parameter draw = 2'b10;
parameter setup = 2'b11;
always @(posedge clk) begin
    case(state)
    
        reset: begin
            rtr <= 0;
            x <= 0;
            state <= idle;
        end
        
        idle: begin
            rtr <= 1;
            if (rts) begin
                state <= setup;
                x <= x1;
                rtr <= 0;
            end
        end
        
        setup: begin
            x <= x1;
            rtr <= 0;
            state <= draw;
        end
        
        draw: begin
            if (x == x2) begin
                state <= idle;
            end
            else if (x1 > x2) begin
                x <= x - 1;
            end
            else begin
                x <= x + 1;
            end
        end
        
        default: state <= reset;
    endcase
end
    
endmodule
