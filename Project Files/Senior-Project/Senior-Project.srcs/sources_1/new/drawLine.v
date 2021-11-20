`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 12:55:05 PM
// Design Name: 
// Module Name: drawLine
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


module drawLine(
input wire [9:0]x1,  //X for first point
input wire [9:0]y1,  //Y for first point
input wire [9:0]x2,  //X for second point
input wire [9:0]y2,  //Y for second point
input wire clk,
input wire rts, //Will be used to determine if data is received.
output reg rtr, //Will be used to tell its parent if this module is busy or ready to be used.
output wire [9:0]x_out,
output wire [9:0]y_out
);

reg [9:0]dx;
reg [9:0]dy;
reg [9:0]D;
reg [9:0]y_current;
reg [9:0]x_current;
// Assign outputs to current value + offset
assign x_out = x_current + x1;
assign y_out = y_current + y1;
assign Dnextx = D + dy + dy;
assign Dnexty = D + dx + dx;

reg [3:0]state;
parameter reset = 4'b0000;
parameter idle = 4'b0001;
parameter value = 4'b0010;
parameter bigY = 4'b0011;
parameter bigX = 4'b0100;
parameter negY = 4'b0101;
parameter negX = 4'b0110;
always @(posedge clk) begin
    case(state)
        reset: begin
            dx <= 0;
            dy <= 0;
            D <= 0;
            y_current <= 0;
            x_current <= 0;
            state <= idle;
        end

        idle: begin //Idle state, wait for RTS
            rtr <= 1;
            if (rts) begin
                state <= value;
                rtr <= 0;
            end
        end
        
        value: begin
            dx <= x2 - x1;
            dy <= y2 - y1;
            if ((x2-x1) >= (y2-y1)) begin //go into bigX
                if(x2 > x1) begin //Positive dx
                    state <= bigX;
                end
                else begin
                    state <= negX; //Negative X increment
                end
            end
            else begin //go into bigY
                if(y2 > y1) begin
                    state <= bigY;
                end
                else begin
                    state <= negY; //Negative Y increment
                end
            end
        end

        default: state <= reset;
    endcase
end
endmodule
