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

function [9:0]abs(input[9:0] a);
    abs = a[9] ? ~a+1 : a;
endfunction

reg [9:0]dx;
reg [9:0]dy;
reg [9:0]negdx;
reg [9:0]negdy;
reg [9:0]D;
reg [9:0]y_current;
reg [9:0]x_current;
wire [9:0]Dnextx;
wire [9:0]Dnexty;
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
            negdx <= 0;
            negdy <= 0;
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
            dx <= abs(x2 - x1);
            dy <= abs(y2 - y1);
            negdx <= x2 - x1;
            negdy <= y2 - y1;
            y_current <= 0;
            x_current <= 0;
            if ((x2-x1) >= (y2-y1)) begin //go into bigX
               
                if(x2 > x1) begin //Positive dx
                    D <= (x2 - x1) + (y2 - y1) + (y2 - y1); //Initial Value of D
                    state <= bigX;
                end
                else begin
                    D <= (x1 - x2) + (y2 - y1) + (y2 - y1); //Initial Value of D
                    state <= negX; //Negative X increment

                end
            end
            else begin //go into bigY
               
                if(y2 > y1) begin //Positive dy
                    D <= (y2 - y1) + (x2 - x1) + (x2 - x1); //Initial Value of D
                    state <= bigY;
                end
                else begin
                    D <= (y1 - y2) + (x2 - x1) + (x2 - x1); //Initial Value of D
                    state <= negY; //Negative Y increment
                end
            end
        end
       
        bigX: begin
            if (D > dx + dx)begin
                y_current = y_current + 1;
                D <= Dnextx - dx - dx;
            end
            else begin
                D <= Dnextx;
            end
            x_current = x_current + 1;
            if (x_current == dx) begin
                state <= idle;
            end
        end
       
        negX: begin
            if (D > dx + dx)begin
                y_current = y_current + 1;
                D <= Dnextx - dx - dx;
            end
            else begin
                D <= Dnextx;
            end
            x_current = x_current - 1;
            if (x_current == negdx) begin
                state <= idle;
            end
        end
       
        bigY: begin
            if (D > dy + dy)begin
                x_current = x_current + 1;
                D <= Dnexty - dy - dy;
            end
            else begin
                D <= Dnexty;
            end
            y_current = y_current + 1;
            if (y_current == dy) begin
                state <= idle;
            end
        end
       
        negY: begin
            if (D > dy + dy) begin
                x_current = x_current + 1;
                D <= Dnexty - dy - dy;
            end
            else begin
                D <= Dnexty;
            end
            y_current = y_current - 1;
            if (y_current == negdy) begin
                state <= idle;
            end
        end
       
        default: state <= reset;
    endcase
end
endmodule