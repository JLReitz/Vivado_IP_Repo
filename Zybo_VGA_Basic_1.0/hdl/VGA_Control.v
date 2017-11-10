`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 02:27:36 PM
// Design Name: 
// Module Name: VGA_Control
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


module VGA_Control(
        input  wire [31:0] H_Sync,
        input  wire [31:0] H_BP,
        input  wire [31:0] H_FP,
        input  wire [31:0] H_Range,
        input  wire [31:0] H_LR_Border,
        input  wire [31:0] V_Sync,
        input  wire [31:0] V_BP,
        input  wire [31:0] V_FP,
        input  wire [31:0] V_Range,
        input  wire [31:0] V_TB_Border,
        input  wire [15:0] InImage_Color,
        input  wire [15:0] OutImage_Color,
        input  wire        pixel_clk,    
        output  reg [4:0]  VGA_R,
        output  reg [4:0]  VGA_B,
        output  reg [5:0]  VGA_G,
        output  reg        VGA_HS,
        output  reg        VGA_VS
    );
    
    wire    H_Start, H_End, V_Start, V_End;
    reg    H_InRange, V_InRange;
    integer H_Counter, V_Counter;
    
    assign H_Start = H_Sync+H_BP+H_LR_Border;
    assign H_End = H_Start + H_Range;
    assign V_Start = V_Sync+V_BP+V_TB_Border;
    assign V_End = V_Start + V_Range;
    
    initial
    begin
        H_Counter <= 32'd0;
        V_Counter <= 32'd0;
        H_InRange <= 1'd0;
        V_InRange <= 1'd0;
    end
    
    always @ (posedge(pixel_clk))
    begin
        //Increment the horizontal and vertical counters
        if(H_Counter >= (H_Sync+H_BP+H_FP+H_Range+H_LR_Border-1))
        begin
            H_Counter <= 32'd0;
            
            if(V_Counter >= (V_Sync+V_BP+V_FP+V_Range+V_TB_Border-1))
            begin
                V_Counter <= 32'd0;
            end
            else
                V_Counter <= V_Counter + 32'd1;
        end
        else
            H_Counter = H_Counter + 32'd1;
            
        //Enable the image if within the image range
        if((H_Counter >= (H_Start-1)) && (H_Counter <= (H_End-1)))
            H_InRange <= 1'd1;
        else
            H_InRange <= 1'd0;
            
        if((V_Counter >= (V_Start-1)) && (V_Counter <= (V_End-1)))
            V_InRange <= 1'd1;
        else
            V_InRange <= 1'd0;
            
        //Display image if in range
        if(H_InRange && V_InRange)
        begin
            if((H_Counter >= (H_Start+49)) && (H_Counter <= (H_End-51)) &&
                (V_Counter >= (V_Start+49)) && (V_Counter <= (V_End-51)))
            begin
                VGA_R <= InImage_Color[4:0];
                VGA_B <= InImage_Color[9:5];
                VGA_G <= InImage_Color[15:10];
            end
            else
            begin
                VGA_R <= OutImage_Color[4:0];
                VGA_B <= OutImage_Color[9:5];
                VGA_G <= OutImage_Color[15:10];
            end
        end
        else
        begin
            VGA_R <= 5'd0;
            VGA_B <= 5'd0;
            VGA_G <= 6'd0;
        end
    end
    
endmodule
