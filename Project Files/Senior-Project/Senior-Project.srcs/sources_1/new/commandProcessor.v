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
input wire[70:0] Instruction,
input wire empty,
input wire rtr_triangle,
input wire rtr_drawLine,
input wire rtr_blankScreen,
input wire done,
input wire [9:0]x_curr1,
input wire [9:0]x_curr2,
input wire [9:0]y_curr,
output reg next,
output reg rts_triangle,
output reg rts_drawLine,
output reg rts_blankScreen,
output reg read_en,
output reg [9:0]x1,
output reg [9:0]x2,
output reg [9:0]x3,
output reg [9:0]y1,
output reg [9:0]y2,
output reg [9:0]y3,
output reg [7:0]color
);

reg [2:0]state;
parameter reset = 3'b000;
parameter idle = 3'b001;
parameter instruction = 3'b010;
parameter intermediate = 3'b011;
parameter busy = 3'b100;
parameter intermediate_triangle = 3'b101;
parameter busy_triangle = 3'b110;

always @(posedge clk) begin
    case(state)

        reset: begin //Reset state.
            read_en <= 0;
            rts_drawLine <= 0;
            rts_triangle <= 0;
            rts_blankScreen <= 0;
            state <= idle;
            x1 <= 0;
            x2 <= 0;
            y1 <= 0;
            y2 <= 0;
            color <= 0;
        end

        idle: begin //Idle state, no instructions available.
            if (~empty) begin
                state <= instruction; //GoTo instruction state
            end
        end

        instruction: begin //Instruction state
            case(Instruction[70:68])
                3'b010: begin //This instruction is the DrawLine instruction
                    if (rtr_drawLine) begin
                        color <= Instruction[67:60];
                        x1 <= Instruction[59:50];
                        y1 <= Instruction[49:40];
                        x2 <= Instruction[39:30];
                        y2 <= Instruction[29:20];
                        rts_drawLine <= 1;
                        state <= intermediate;
                        read_en <= 1;
                    end //This will latch until rtr is high.
                end
                
                3'b011: begin //This instruction is the blank screen instruction
                    if (rtr_drawLine) begin
                        color <= Instruction[67:60];
                        rts_blankScreen <= 1;
                        state <= intermediate;
                        read_en <= 1;
                    end //This will latch until rtr is high.
                end
                
                3'b100: begin //This instruction is the triangle drawing instrcution
                    if (rtr_triangle) begin
                        color <= Instruction[67:60];
                        x1 <= Instruction[59:50];
                        y1 <= Instruction[49:40];
                        x2 <= Instruction[39:30];
                        y2 <= Instruction[29:20];
                        x3 <= Instruction[19:10];
                        y3 <= Instruction[9:0];
                        state <= intermediate_triangle;
                        rts_triangle <= 1;
                        read_en <= 1;
                    end //This will latch until rtr is high
                end

                default: begin
                state <= reset; //Bad instruction, go to reset
                read_en <= 1; //Read next instruction
                end
            endcase
        end

        intermediate: begin // Disable FIFO read, RTS, and move to busy state.
            read_en <= 0;
            rts_drawLine <= 0;
            rts_blankScreen <= 0;
            state <= busy;
        end

        intermediate_triangle: begin // Disable FIFO read, RTS, and move to busy state.
            read_en <= 0;
            rts_drawLine <= 0;
            rts_blankScreen <= 0;
            rts_triangle <= 0;
            state <= busy_triangle;
        end

        busy: begin //Busy state
            if(rtr_drawLine & rtr_blankScreen) begin //If the draw line and blank screen is rtr, it is done.
                if (~empty) begin //Instruction ready, go to instruction state
                    state <= instruction;
                    end
                else begin
                    state <= idle;
                    end
                end
            end

        busy_triangle: begin
            case(done)
                0: begin//Not Done
                    if (rtr_drawLine) begin //Ready to draw...
                        rts_drawLine <= 1;
                        x1 <= x_curr1;
                        y1 <= y_curr;
                        x2 <= x_curr2;
                        y2 <= y_curr;
                    end
                    else begin //Currently drawing, in busy state.
                        rts_drawLine <= 0;
                    end
                end
                1: begin//Done
                    rts_drawLine <= 0;
                    if (~empty) begin //Instruction ready, go to instruction state
                        state <= instruction;
                        end
                    else begin
                        state <= idle;
                    end
                end               
            endcase
        end

        default: begin
            state <= reset;
        end
    endcase
end
endmodule
