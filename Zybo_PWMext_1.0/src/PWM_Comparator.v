`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2017 12:21:43 PM
// Design Name: 
// Module Name: PWM_Comparator
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


module PWM_Comparator(
        input               clk,
        input   [9:0]       PWM_duty,
        input   [9:0]       cntr,
        output  reg         PWM   
    );
    
    initial
    begin
        PWM <= 4'd0;
    end
    
    always @ (posedge(clk))
    begin
        if(cntr < PWM_duty)
            PWM <= 1'b1;
        else
            PWM <= 1'b0;
    end
    
endmodule
