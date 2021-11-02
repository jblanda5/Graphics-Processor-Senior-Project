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
/////////////////////////////////////////////////////////////////////////////////

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
reg [9:0]d;
reg [9:0]y_current;
reg [9:0]x_current;
reg increment_x;
reg increment_y;

assign x_out = x_current;
assign y_out = y_current;

initial begin
ready <= 1;
end

// Set up initial values given a new line to draw.
always @(posedge x1, y1, x2, y2) begin
dx <= x2 - x1;
dy <= y2 - y1;


if (dx > dy) begin //big_x
d <= dx;
    if (dy > y2) begin
        increment_x = 0;
        dy <= ~(dy)+1;
    end
    else begin
        increment_x = 1;
    end
end

if (dy > dx) begin //big_y
d <= dy;
    if (dx > x2) begin
        increment_y = 0;
        dx <= ~(dx)+1;
    end
    else begin
        increment_y = 1;
    end
end

y_current <= y1;
x_current <= x1;

ready <= 0;
end

always @(posedge (clk & ~ready)) begin //If the module is not in standbye mode...
 
if (dx > dy) begin   
    d = d + dy + dy;
    
    if (d > (dx + dx)) begin
		if (increment_x) begin
			y_current <= y_current + 1;
		end
		else begin
			y_current <= y_current - 1;
		end
        d <= d - (dx + dx);
    end
    
    x_current = x_current + 1; //increment x value
    if (x_current == x2) begin
        ready <= 1;
    end
end

if (dy > dx) begin   
    d = d + dx + dx;
    
    if (d > (dy + dy)) begin
		if (increment_y) begin
			x_current <= x_current + 1;
		end
		else begin
			x_current <= x_current - 1;
		end
        d <= d - (dy + dy);
    end
    
    y_current = y_current + 1; //increment y value
    if (y_current == y2) begin
        ready <= 1;
    end
end

end

endmodule