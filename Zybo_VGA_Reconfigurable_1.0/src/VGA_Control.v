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
        input  wire        Disp_En,
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
    
    wire [31:0] H_Start, H_End, V_Start, V_End, H_Length, V_Length;
    reg         H_InRange = 0, V_InRange = 0;
    integer     H_Counter, V_Counter;
    
    assign H_Start = H_Sync + H_BP + H_LR_Border - 1;
    assign H_End = H_Start + H_Range;
    assign V_Start = V_Sync + V_BP + V_TB_Border - 1;
    assign V_End = V_Start + V_Range;
    assign H_Length = H_Sync + H_BP + H_FP + H_Range + H_LR_Border - 1;
    assign V_Length = V_Sync + V_BP + V_FP + V_Range + V_TB_Border - 1;
    
    initial
    begin
        H_Counter <= 32'd0;
        V_Counter <= 32'd0;
        H_InRange <= 1'd0;
        V_InRange <= 1'd0;
        
        //Set initial output values
        VGA_R <= 5'd0;
        VGA_B <= 5'd0;
        VGA_G <= 5'd0;
        VGA_HS <= 0;
        VGA_VS <= 0;
    end
    
    always @ (posedge(pixel_clk))
    begin
        //Increment the horizontal and vertical counters
        if(Disp_En)
        begin
            if(H_Counter >= H_Length)
            begin
                H_Counter = 32'd0;
                
                if(V_Counter >= V_Length)
                begin
                    V_Counter = 32'd0;
                end
                else
                    V_Counter = V_Counter + 32'd1;
            end
            else
                H_Counter = H_Counter + 32'd1;
        end
        else
        begin
            H_Counter = 32'd0;
            V_Counter = 32'd0;
        end
            
        //Enable H-Sync and V-Sync if necessary
        if((H_Counter >= 0) && (H_Counter < H_Sync))
            VGA_HS = 1'd0;
        else
            VGA_HS = 1'd1;
            
        if((V_Counter >= 0) && (V_Counter < V_Sync))
            VGA_VS = 1'd0;
        else
            VGA_VS = 1'd1;
    end
    
    always @ (posedge(pixel_clk))
    begin    
        //Enable the image if within the image range
        if((H_Counter >= H_Start) && (H_Counter <= H_End))
            H_InRange <= 1'd1;
        else
            H_InRange <= 1'd0;
            
        if((V_Counter >= V_Start) && (V_Counter <= V_End))
            V_InRange <= 1'd1;
        else
            V_InRange <= 1'd0;
    end
    
    always @ (posedge(pixel_clk))
    begin    
        //Display image if in range
        if(H_InRange && V_InRange)
        begin
            if((H_Counter >= (H_Start+50)) && (H_Counter <= (H_End-50)) &&
                (V_Counter >= (V_Start+50)) && (V_Counter <= (V_End-50)))
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
