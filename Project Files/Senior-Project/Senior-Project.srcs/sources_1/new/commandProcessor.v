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
input wire rtr_drawLine,
input wire rtr_blankScreen,
input wire rtr_drawTriangle,
output reg rts_drawLine,
output reg rts_blankScreen,
output reg rts_drawTriangle,
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

always @(posedge clk) begin
    case(state)

        reset: begin //Reset state.
            read_en <= 0;
            rts_blankScreen <= 0;
            rts_drawLine <= 0;
            rts_drawTriangle <= 0;
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
                
                3'b100: begin //This instruction is the draw triangle instruction
                        color <= Instruction[67:60];
                        x1 <= Instruction[59:50];
                        y1 <= Instruction[49:40];
                        x2 <= Instruction[39:30];
                        y2 <= Instruction[29:20];
                        x3 <= Instruction[19:10];
                        y3 <= Instruction[9:0];
                        rts_drawTriangle <= 1;
                        state <= intermediate;
                        read_en <= 1;
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
            rts_drawTriangle <= 0;
            state <= busy;
        end

        busy: begin //Busy state
            if(rtr_drawLine & rtr_blankScreen & rtr_drawTriangle) begin //If the draw line, draw Triangle, and blank screen is rtr, it is done.
                if (~empty) begin //Instruction ready, go to instruction state
                    state <= instruction;
                    end
                else begin
                    state <= idle;
                    end
                end
            end
        default: begin
            state <= reset;
        end
    endcase
end
endmodule