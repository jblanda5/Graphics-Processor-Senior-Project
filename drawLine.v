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
    input wire [9:0]x1,  //starting x value
    input wire [9:0]y1,  //starting y value
    input wire [9:0]x2,  //ending x value
    input wire [9:0]y2,  //ending y value
    input clk,
    input reset,
    output complete, //determinent variable
    output wire [9:0]x_out,
    output wire [9:0]y_out
);

    reg [9:0]dx;
    reg [9:0]dy;
    reg [9:0]potential_d;
    reg [9:0]new_d;
    reg [9:0]y_current;
    reg [9:0]x_current;
    reg increment_x;
    reg increment_y;
    
    assign x_out = x_current;
    assign y_out = y_current;
    
    //determining when to stop the cases
    //false when x_current < x2 
    //true when x_current == x2
    assign complete = (x_current == x2) ? 0 : 1;
    assign x_out = x_current;
    assign y_out = y_current;
    
    //one hot encoding:
    //assign parameters to distinct binary values
    //will assist in determining specific case
    reg [6:0] state; //6 case states
    
    parameter start = 6'b000001;
    parameter idle = 6'b000010;
    parameter initialV = 6'b000100;
    parameter big_x = 6'b001000;
    parameter big_y = 6'b010000;
    parameter finish = 6'b100000; 
    
    always @ (posedge clk)
    begin
        if(reset) //at reset: initial values are placed
        begin
            dx <= 0;
            dy <= 0;
            potential_d <= 0;
            new_d <= 0;
            y_current <= 0;
            x_current <= 0;
            increment_x <= 0;
            increment_y <= 0;
            
            state <= idle; //set state to start
        end
        else
        begin
            case(state)
            idle://idle 
                state <= start;
                //rtr = 1 everything else = 0
                start:
                begin
                    dx <= x2 - x1;
                    dy <= y2 - y1;
                    state <= initialV;
                end
                initialV:
                begin
                    if(dx > dy)//check if big_x
                    begin
                        new_d <= dx;
                        state <= big_x; //state will go to big_x
                  
                        if(dy > y2)//check to see if pos or neg slope
                        begin
                            increment_x <= 0; //set variable to 0 when neg
                            dy = ~(dy) + 1; //complement of dy
                        end
                        else
                        begin
                            increment_x <= 1; //slope is pos
                        end
                    end    

                    if (dy > dx)//check if big_y 
                    begin
                        potential_d <= dy;
                        state <= big_y; //state will go to big_y
                        
                        if (dx > x2) //check to see if pos or neg slope
                        begin
                            increment_y = 0; //set variable to 0 when neg
                            dx <= ~(dx) + 1; //complement of dx
                        end
                        else 
                        begin
                            increment_y = 1; //slope is pos
                        end
                    end
                end
             big_x:
                begin
                    //d <= dx + (dy + dy); //how to properly iterate this
                    potential_d <= new_d + dx + dx;
                    
                    if(potential_d > (dx + dx))
                    begin
                        if(increment_x)
                        begin
                            y_current <= y_current + 1; //pos slope (add)
                        end
                        else
                        begin
                            y_current <= y_current - 1; //neg slope (subtract)
                        end                    
                   // d <= (dy + dy) - dx; //how to properly iterate this
                   new_d <= potential_d - (dx+dx);
                    end
                    
                    if(!complete) //creating loop to complete big_x
                    begin
                        x_current <= x_current + 1; //iterating through x
                        state <= big_x;
                    end
                    else
                    begin
                        state <= finish;
                    end
                end
                
                big_y:
                begin
                    //d <= dy + dx + dx; //how to properly iterate this
                    if (potential_d > (dy + dy)) 
                        begin
                            if (increment_y) 
                            begin
                                x_current <= x_current + 1;
                            end
                            else 
                            begin
                                x_current <= x_current - 1;
                            end

                    //d <= d - (dy + dy); //how to properly iterate this
                    end
                    if(!complete)
                    begin
                        y_current <= y_current + 1;
                        state <= big_y;
                    end
                    else
                    begin
                        state <= finish;
                    end
                end
                
                finish:
                begin
                    state <= finish;
                end
            endcase
        end
    end
    
endmodule