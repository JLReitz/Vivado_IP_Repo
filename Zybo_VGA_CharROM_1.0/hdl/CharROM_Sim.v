`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 02:45:00 PM
// Design Name: 
// Module Name: CharROM_Sim
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


module CharROM_Sim();

wire [15:0] DO;
reg pix_clk = 1'b1;
reg [10:0] addr = 11'd0;

// Generate pix_clk
always
begin
    #5 pix_clk <= ~pix_clk;
end

// Increment Address every clock cycle
always @ (posedge pix_clk)
begin
    addr <= addr + 1'b1;
end

char_rom char_rom_inst (
    .DO(DO),       // Output data, width defined by READ_WIDTH parameter
    .ADDR(addr),   // Input address, width defined by read/write port depth
    .CLK(pix_clk),     // 1-bit input clock
    .DI(16'h0),       // Input data port, width defined by WRITE_WIDTH parameter
    .EN(1'b1),       // 1-bit input RAM enable
    .REGCE(1'b0), // 1-bit input output register enable
    .RST(1'b0),     // 1-bit input reset
    .WE(2'd0)        // Input write enable, width defined by write port depth
    );

endmodule
