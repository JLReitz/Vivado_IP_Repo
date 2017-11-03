`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2017 12:21:43 PM
// Design Name: 
// Module Name: PWM_Counter
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


module PWM_Counter(
        input               clk,
        input               en,
        output  reg [9:0]   cntr
    );
    
    initial
    begin
        cntr <= 0;
    end
    
    always @ (posedge(clk))
    begin
        if(en)
        begin
            if(cntr == 10'd1023)
                cntr <= 10'd0;
            else
                cntr <= cntr + 10'd1;
        end
        else
            cntr <= 10'd1023; //So that the comparator drives the PWM signal low but will reset at the next clock cycle
    end
    
endmodule
