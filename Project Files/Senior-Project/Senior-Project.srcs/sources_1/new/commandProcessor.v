`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 09:31:43 AM
// Design Name: 
// Module Name: commandProcessor
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


module commandProcessor(
input wire clk,
input wire finished,
input wire[70:0] dataOut,
input wire empty,
output reg[2:0] instruction,
output reg[7:0] color,
output reg[9:0] x1,x2,x3,
output reg[9:0] y1,y2,y3,
output reg read_en
);
reg [1:0]state;


always @(posedge clk) begin
    case(state)
        2'b00: begin //Idle state
            instruction <= 3'b0;
            color <= 8'b0;
            x1 <= 10'b0;
            y1 <= 10'b0;
            x2 <= 10'b0;
            y2 <= 10'b0;
            x3 <= 10'b0;
            y3 <= 10'b0;
            if(~empty) begin
                state <= 2'b01;
                read_en <= 1; //next clock cycle we'll read data from the FIFO.
            end
        end
        
        2'b01: begin //Read state
            instruction <= dataOut[70:68];
            color <= dataOut[67:60];
            x1 <= dataOut[59:50];
            y1 <= dataOut[49:40];
            x2 <= dataOut[39:30];
            y2 <= dataOut[29:20];
            x3 <= dataOut[19:10];
            y3 <= dataOut[9:0];
            //Move to busy state and turn off read
            read_en <= 0;
            state <= 2'b10;
        end

        2'b10: begin //busy state
            if (finished) begin
                if (~empty) begin
                    state <= 2'b01; //Have instructions in the FIFO
                end
                else begin
                    state <= 2'b00; //No instructions ready, go to idle...
                end
            end
        end

        default: state <= 2'b00; //Default reset
    endcase
end
endmodule
