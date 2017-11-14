`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 02:03:34 PM
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


module VGA_Sim;

// Instantiate Wires and parameters
reg [31:0] H_Sync = 96;
reg [31:0] H_BP = 48;
reg [31:0] H_FP = 16;
reg [31:0] H_Range = 640;
reg [31:0] H_LR_Border = 0;
reg [31:0] V_Sync = 2;
reg [31:0] V_BP = 33;
reg [31:0] V_FP = 10;
reg [31:0] V_Range = 480;
reg [31:0] V_TB_Border = 0;
reg [15:0] InImage_Color = 0;
reg [15:0] OutImage_Color = 0;
reg        pixel_clk = 0;
wire [4:0]  VGA_R;
wire [4:0]  VGA_B;
wire [5:0]  VGA_G;
wire        VGA_HS;
wire        VGA_VS;
//output  reg        VGA_VS;

//Instantiation of User-Defined Modules
VGA_Control uut(
    .H_Sync(H_Sync),
    .H_BP(H_BP),
    .H_FP(H_FP),
    .H_Range(H_Range),
    .H_LR_Border(H_LR_Border),
    .V_Sync(V_Sync),
    .V_BP(V_BP),
    .V_FP(V_FP),
    .V_Range(V_Range),
    .V_TB_Border(V_TB_Border),
    .InImage_Color(InImage_Color),
    .OutImage_Color(OutImage_Color),
    .pixel_clk(pixel_clk),
    .VGA_R(VGA_R),
    .VGA_B(VGA_B),
    .VGA_G(VGA_G),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS)
);
// Run Simulation

always @ *
begin
    #1 pixel_clk <= ~pixel_clk;
end
    
endmodule
