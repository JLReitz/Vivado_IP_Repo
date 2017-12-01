`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 03:41:30 PM
// Design Name: 
// Module Name: VGA_Sim
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


module VGA_Sim();

// Instantiate Wires and Registers
reg         Disp_En_w, pixel_clk;
reg  [31:0] H_Sync_w, H_BP_w, H_FP_w, H_Range_w, H_LR_Border_w, V_Sync_w, V_BP_w, V_FP_w, V_Range_w, V_TB_Border_w, Char_XLoc_w, Char_YLoc_w;
reg  [15:0] Background_Color_w, Font_Color_w;
reg  [6:0]  Character_w;
wire [4:0]  VGA_R;
wire [4:0]  VGA_B;
wire [5:0]  VGA_G;
wire        VGA_HS;
wire        VGA_VS;

// Instantiate Unit Under Test
VGA_Controller UUT(
        .Disp_En(Disp_En_w),
        .H_Sync(H_Sync_w),
        .H_BP(H_BP_w),
        .H_FP(H_FP_w),
        .H_Range(H_Range_w),
        .H_LR_Border(H_LR_Border_w),
        .V_Sync(V_Sync_w),
        .V_BP(V_BP_w),
        .V_FP(V_FP_w),
        .V_Range(V_Range_w),
        .V_TB_Border(V_TB_Border_w),
        .Character(Character_w),
        .Background_Color(Background_Color_w),
        .Font_Color(Font_Color_w),
        .Char_XLoc(Char_XLoc_w),
        .Char_YLoc(Char_YLoc_w),
        .pixel_clk(pixel_clk),
        .VGA_R(VGA_R),
        .VGA_B(VGA_B),
        .VGA_G(VGA_G),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS)
    );
    
always @ *
begin
    #5 pixel_clk <= ~pixel_clk;
end

initial
begin
    Disp_En_w = 0;
    pixel_clk = 0;
    
    H_Sync_w = 96;
    H_BP_w = 48;
    H_FP_w = 16;
    H_Range_w = 640;
    H_LR_Border_w = 0;
    V_Sync_w = 2;
    V_BP_w = 33;
    V_FP_w = 10;
    V_Range_w = 480;
    V_TB_Border_w = 0;
    Background_Color_w = 0;
    Font_Color_w = 16'hFFFF;
    Character_w = 48;
    Char_XLoc_w = 192;
    Char_YLoc_w = 41;
    
    #10 Disp_En_w = 1;
end

endmodule
