`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2022 03:31:27 PM
// Design Name: 
// Module Name: blank_screen
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


module blank_screen(
input wire rts,
output reg rtr,
output reg [9:0] x_out,
output reg [9:0] y_out,
input wire clk,
input wire reset
    );
// Define state machine parameters
reg state;
parameter idle = 1'b0;
parameter busy = 1'b1;

always @(posedge clk) begin
    if (reset) begin //If reset is pressed, reset everything.
    x_out <= -1;
    y_out <= 0;
    rtr <= 1;
    state <= idle;
    end
    
    case (state)
        idle: begin
            if (rts) begin
                rtr <= 0;
                state <= busy;
            end else begin
                rtr <= 1;
            end
        end

        busy: begin
            if ((x_out == 1023) | (x_out < 799)) begin
                x_out <= x_out + 1;
            end
            else if (y_out < 599) begin
                x_out <= 0;
                y_out <= y_out + 1;
            end
            else begin
                y_out <= 0;
                x_out <= -1;
                state <= idle;
            end
        end

        default: begin
        x_out <= -1;
        y_out <= 0;
        state <= idle; 
        end
    endcase

end

endmodule
