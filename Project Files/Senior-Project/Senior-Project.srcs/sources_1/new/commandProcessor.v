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
input wire finished,
input wire rtr_drawLine,
output reg rts_drawLine,
output reg read_en
);
reg [2:0]state;

always @(posedge clk) begin
    case(state)
        3'b000: begin //Reset state.
            read_en <= 0;
            rts_drawLine <= 0;
            state <= 3'b001;
        end
        3'b001: begin //Idle state, no instructions available.
            if (~empty) begin
                state <= 3'b101; //GoTo instruction state
                read_en <= 1;
            end
        end
        3'b010: begin //Instruction state
            case(Instruction[70:68])
                3'b010: begin //This instruction is the DrawLine instruction
                    if (rtr_drawLine) begin
                        rts_drawLine <= 1;
                        state <= 3'b011;
                    end
                    else begin
                        state <= 3'b100;
                    end
                end
                default: state <= 3'b000; //Bad instruction, go to reset
            endcase
        end
        3'b011: begin //Busy state
            rts_drawLine <= 0;
            if(finished) begin
                if (~empty) begin //Instruction ready, go to instruction state
                    state <= 3'b010;
                    read_en <= 1;
                    end
                else begin
                    state <= 3'b001;
                end
            end
        end
        3'b100: begin //Neutral state, module is not RTR.
        case (Instruction[70:68]) //Read Instruction
            3'b010: begin //drawLine
                if (rtr_drawLine) begin
                    rts_drawLine <= 1;
                    state <= 3'b011;
                end
            end
        endcase
        end
        3'b101: begin //Temp state, let FIFO data propogate
        read_en <= 0; //Disable read enable to stop the FIFO from outputting.
        state <= 3'b010;
        end
        default: begin
            read_en <= 0;
            state <= 3'b000; //Default reset
        end
    endcase
end
endmodule
