`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2/28/2022 12:55:05 PM
// Design Name:
// Module Name: drawSide
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
module drawSide(
input wire [9:0]x1,  //X for first point
input wire [9:0]y1,  //Y for first point
input wire [9:0]x2,  //X for second point
input wire [9:0]y2,  //Y for second point
input wire clk,
input wire rts, //Will be used to determine if data is received.
output reg rtr, //Will be used to tell its parent if this module is busy or ready to be used.
output wire [9:0]x_out,
output wire [9:0]y_out,
input wire enable,
output reg done,
output reg [3:0]state
);

reg [9:0]dx;
reg [9:0]dy;
reg [11:0]D;
reg [9:0]y_current;
reg [9:0]x_current;
wire [11:0]Dnextx;
wire [11:0]Dnexty;
// Assign outputs to current value + offset
assign x_out = x_current;
assign y_out = y_current;
assign Dnextx = D + dy + dy;
assign Dnexty = D + dx + dx;


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
                done <= 0;
            end
        end
       
        value: begin
            dx <= (x2 > x1) ? (x2 - x1) : (x1 - x2); //absolute value dx
            dy <= (y2 > y1) ? (y2 - y1) : (y1 - y2); //absolute value dy
            y_current <= y1;
            x_current <= x1;
            if (((x2>x1)?(x2-x1):(x1-x2)) >= ((y2>y1)?(y2-y1):(y1-y2))) begin //go into bigX
                if(x2 >= x1) begin //Positive dx
                    D <= (y2>y1) ? ((x2 - x1) + (y2 - y1) + (y2 - y1)) : ((x2-x1) + (y1-y2) + (y1-y2)); //Initial Value of D
                    state <= bigX;
                end
                else begin
                    D <= (y2>y1) ? ((x1 - x2) + (y2 - y1) + (y2 - y1)) : ((x1-x2) + (y1-y2) + (y1-y2)); //Initial Value of D
                    state <= negX; //Negative X increment

                end
            end
            else begin //go into bigY
                if (y2 >= y1) begin //Positive dy
                    D <= (x2>x1) ? ((y2 - y1) + (x2 - x1) + (x2 - x1)) : ((y2 - y1) + (x1 - x2) + (x1 - x2)); //Initial Value of D
                    state <= bigY;
                end
                else begin
                    D <= (x2>x1) ? ((y1 - y2) + (x2 - x1) + (x2 - x1)) : ((y1 - y2) + (x1 - x2) + (x1 - x2)); //Initial Value of D
                    state <= negY; //Negative Y increment
                end
            end
        end
       
        bigX: begin
            if (x_current == x2) begin
                state <= idle;
                done <= 1;
            end
            if (enable) begin
                if (D > dx + dx)begin
                    D <= Dnextx - dx - dx;
                    y_current <= (x_current == x2) ? y_current : (y1 > y2) ? (y_current - 1) : (y_current + 1);
                end else begin
                    D <= Dnextx;
                end

                if (x_current == x2) begin
                    state <= idle;
                    done <= 1;
                end else begin //Not done, increment.
                    x_current <= x_current + 1;
                end
            end
        end
       
        negX: begin
            if (x_current == x2) begin
                state <= idle;
                done <= 1;
            end
            if (enable) begin
                if (D > dx + dx)begin
                    D <= Dnextx - dx - dx;
                    y_current <= (x_current == x2) ? y_current : (y2<y1) ? (y_current - 1) : (y_current + 1);
                end
                else begin
                    D <= Dnextx;
                end
                if (x_current == x2) begin
                    state <= idle;
                    done <= 1;
                end
                else begin //Not done, increment
                    x_current <= x_current - 1;
                end
            end
        end
       
        bigY: begin
            if (y_current == y2) begin
                state <= idle;
                done <= 1;
            end
            if (enable) begin
                if (D > dy + dy)begin
                    D <= Dnexty - dy - dy;
                    x_current <= (y_current == y2) ? x_current : (x1 > x2) ? (x_current - 1) : (x_current + 1);
                end
                else begin
                    D <= Dnexty;
                end
                if (y_current == y2) begin
                    state <= idle;
                    done <= 1;
                end
                else begin //Not done, increment
                y_current <= y_current + 1;
                end
            end
        end
       
        negY: begin
            if (y_current == y2) begin
                state <= idle;
                done <= 1;
            end
            if (enable) begin
                if (D > dy + dy) begin
                    D <= Dnexty - dy - dy;
                    x_current <= (y_current == y2) ? x_current : ((x2<x1) ? (x_current - 1) : (x_current + 1));
                end
                else begin
                    D <= Dnexty;
                end
                if (y_current == y2) begin
                    state <= idle;
                    done <= 1;
                end
                else begin //Not done, increment
                y_current <= y_current - 1;
                end
            end
        end
       
        default: state <= reset;
    endcase
end
endmodule