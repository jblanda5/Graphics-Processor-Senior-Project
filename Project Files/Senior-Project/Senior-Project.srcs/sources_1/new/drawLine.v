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
output reg ready, //Will be used to tell its parent if this module is busy or ready to be used.
output wire [9:0]x_out,
output wire [9:0]y_out
);

reg [9:0]dx;
reg [9:0]dy;
reg [9:0]D;
reg [9:0]y_current;
reg [9:0]x_current;
reg increment;
// Assign outputs to current value + offset
assign x_out = x_current + x1;
assign y_out = y_current + y1;
assign Dnext = D + dy + dy;

initial begin
ready <= 1;
end

// Set up initial values given a new line to draw.
always @(*) begin
dx <= x2 - x1;
// Check for underflow
if (y2 - y1 > y2) begin
	increment = 0;
	dy <= ~(y2-y1)+1;
end
else begin
	dy <= y2 - y1;
	increment = 1;
end
D <= x2-x1;
y_current <= 0; //Start point = (0,0)
x_current <= 0;

ready <= 0;
end

always @(posedge (clk)) begin
//Add setup state

if (~ready) begin //If the module is not in standbye mode...

    if (Dnext > (dx + dx)) begin
		
		// Increment if dy was positive, decrement if negative
		if (increment) begin
			y_current <= y_current + 1;
		end
		else begin
			y_current <= y_current - 1;
		end
		
		// Reduce D by 2*dx
        D <= Dnext - (dx + dx);
    end
    else begin
        D <= Dnext;
    end
    
    x_current = x_current + 1; //increment x value
    
    if (x_current == dx) begin
        ready <= 1;
    end
end
end

endmodule
