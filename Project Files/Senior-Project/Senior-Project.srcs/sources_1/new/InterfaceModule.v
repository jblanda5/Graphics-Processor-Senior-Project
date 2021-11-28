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
input wire pi_rts_raw, 
input wire [7:0] PMOD,
output reg [70:0] dataIn,
output reg write_en,
output reg fpga_rtr,
output reg [3:0]counter,
input wire full
);

//reg reset, reset_p1;
reg pi_rts, pi_rts_p1;

reg [2:0]state;
parameter reset = 3'b000;
parameter idle = 3'b001;
parameter instruction = 3'b010;
parameter delayState = 3'b011;
parameter delayState2 = 3'b100;
parameter waitForPi = 3'b101;

always @ (posedge clk) begin
pi_rts_p1 <= pi_rts_raw;
pi_rts <= pi_rts_p1;
    case(state)
        reset: begin
            dataIn <= 0;
            fpga_rtr <= 0;
            write_en <= 0;
            state <= idle;
            counter <= 0;
        end

        idle: begin
            fpga_rtr <= 1;
            if (pi_rts & (~full)) begin //Pi is ready to send.
                state <= instruction;
            end
        end
        
        instruction: begin
            dataIn <= (dataIn << 8) | PMOD;
            fpga_rtr <= 0;
            counter <= counter + 1;
            if (counter < 8) begin
                state <= waitForPi;
            end
            else begin
                write_en <= 1;
                counter <= 4'b0000;
                state <= delayState;
            end
        end
        delayState: begin
            write_en <= 0;
            state <= delayState2;
        end
        delayState2: begin
            state <= idle;
        end
        waitForPi: begin
            if (pi_rts == 0) begin
                state <= idle;
            end
        end
        default: state <= reset;

    endcase
end
endmodule