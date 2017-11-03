`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2017 12:39:39 PM
// Design Name: 
// Module Name: Clock_Divider
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


module Clock_Divider(
        input                   clk,
        input   wire [15:0]     range,
        output  reg             clk_div
    );
    
    integer  counter, compare;
    
    initial
    begin
        counter <= 0;
        clk_div <= 0;
    end
    
    always @ (range)
    begin
        compare <= 32'd100000000/(32'd1024*range);
    end
    
    always @ (posedge(clk))
    begin
        if(counter >= compare)
        begin
            clk_div <= ~clk_div;
            counter <= 16'd0;
        end
        else
            counter <= counter + 16'd1;
    end
    
endmodule
