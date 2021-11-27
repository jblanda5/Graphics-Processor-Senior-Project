`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2021 07:33:44 PM
// Design Name: 
// Module Name: InterfaceModule
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


module InterfaceModule(
input wire clk, 
//input wire reset_raw, 
input wire pi_rts_raw, 
input wire [7:0] PMOD,
output reg [70:0] dataIn,
output reg write_en,
output reg fpga_rtr
);

//reg reset, reset_p1;
reg pi_rts, pi_rts_p1;
reg [3:0]counter;

reg [2:0]state;
parameter reset = 3'b000;
parameter idle = 3'b001;
parameter instruction = 3'b010;
parameter delayState = 3'b011;
parameter delayState2 = 3'b100;

always @ (posedge clk) begin
pi_rts_p1 <= pi_rts_raw;
pi_rts <= pi_rts_p1;
    case(state)
        reset: begin
            fpga_rtr <= 0;
            write_en <= 0;
            state <= idle;
            counter <= 0;
        end

        idle: begin
            fpga_rtr <= 1;
            if (pi_rts == 1) begin //Pi is ready to send.
                state <= instruction;
            end
        end
        
        instruction: begin
            dataIn <= (dataIn << 8) | PMOD;
            fpga_rtr <= 0;
            if (counter == 8) begin
                write_en <= 1;
                state <= delayState;
                counter <= 0;
            end
            else begin
                counter <= counter + 1;
                state <= idle;
            end
        end
        delayState: begin
            state <= delayState2;
            write_en <= 0;
        end
        delayState2: begin
            state <= idle;
        end
        default: state <= reset;

    endcase
end
endmodule