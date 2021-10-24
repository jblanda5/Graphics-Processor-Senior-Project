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
input wire [10:0]x1,  //X for first point
input wire [10:0]y1,  //Y for first point
input wire [10:0]x2,  //X for second point
input wire [10:0]y2,  //Y for second point
input wire clk,
output reg ready, //Will be used to tell its parent if this module is busy or ready to be used.
output reg [10:0]x_out,
output reg [10:0]y_out,
output reg pixelWrite
);

function [10:0]pixelCheck(input[10:0]x, input[10:0]y, input[10:0]deltaX, input [10:0]deltaY);
    if ((deltaY*x) >= (deltaX*y)) begin //Check to see if the output would be negative
    pixelCheck = (deltaY*x)-(deltaX*y);
    end
    else begin //We're simply using this for error, so sign doesn't matter.
    pixelCheck = (deltaX*y)-(deltaY*x);
    end
endfunction    


reg [10:0]y_current;
reg [10:0]x_current;
reg [10:0]y_offset;
reg [10:0]x_offset;  //Used to move the origin for simplicity of the alogirthm, will be added to the output
reg [10:0]x2_shift;
reg [10:0]y2_shift;
reg [10:0]error_unchanged;
reg [10:0]error_above;
reg [10:0]error_below;

initial begin
ready <= 1;
end

always @(posedge x1, y1, x2, y2) begin //Update these for new input values
y_current <= 0;
x_current <= 0;
y_offset <= y1;
x_offset <= x1;
x2_shift <= x2 - x_offset;
y2_shift <= y2 - y_offset;
ready <= 0;
end

always @(posedge clk) begin
if (~ready) begin //If the module is not in standbye mode...
    error_unchanged = pixelCheck(x_current, y_current, x2_shift, y2_shift);
    error_above = pixelCheck(x_current, y_current-1, x2_shift, y2_shift); //If y_current is 0, it will pass 2048 which is fine (returns a high value) as we don't want to use a negative pixel.
    error_below = pixelCheck(x_current, y_current+1, x2_shift, y2_shift);

    if (error_unchanged <= error_above & error_unchanged <= error_below) begin //If the unchanged value is the lowest error
        x_out <= x_current + x_offset;
        y_out <= y_current + y_offset;
    end
    else if (error_above <= error_unchanged & error_above <= error_below) begin //If the above value is the lowest error
        x_out <= x_current + x_offset;
        y_out <= y_current + y_offset - 1;
        y_current <= y_current - 1;
    end
    else begin //If the below value is the lowest error
        x_out <= x_current + x_offset;
        y_out <= y_current + y_offset + 1;
        y_current <= y_current + 1;
    end
    pixelWrite <= 1; //Enable pixel writing
    if (x_current == x2_shift) begin
        ready <= 1;
        pixelWrite <= 0;
    end
    x_current = x_current + 1; //increment x value

end
end

endmodule
