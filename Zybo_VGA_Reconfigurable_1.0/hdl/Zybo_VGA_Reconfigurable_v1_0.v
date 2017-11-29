
`timescale 1 ns / 1 ps

	module Zybo_VGA_Reconfigurable_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here
        input   wire        pixel_clk,    
        output  wire [4:0]  VGA_R,
        output  wire [4:0]  VGA_B,
        output  wire [5:0]  VGA_G,
        output  wire        VGA_HS,
        output  wire        VGA_VS,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S_AXI
		input wire  s_axi_aclk,
		input wire  s_axi_aresetn,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
		input wire [2 : 0] s_axi_awprot,
		input wire  s_axi_awvalid,
		output wire  s_axi_awready,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_wdata,
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
		input wire  s_axi_wvalid,
		output wire  s_axi_wready,
		output wire [1 : 0] s_axi_bresp,
		output wire  s_axi_bvalid,
		input wire  s_axi_bready,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_araddr,
		input wire [2 : 0] s_axi_arprot,
		input wire  s_axi_arvalid,
		output wire  s_axi_arready,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
		output wire [1 : 0] s_axi_rresp,
		output wire  s_axi_rvalid,
		input wire  s_axi_rready
	);

// Instantiation of User-Defined Wires
wire        Disp_En_w;	
wire [31:0] H_Sync_w, H_BP_w, H_FP_w, H_Range_w, H_LR_Border_w, V_Sync_w, V_BP_w, V_FP_w, V_Range_w, V_TB_Border_w;
wire [15:0] InImage_Color_w, OutImage_Color_w;

// Instantiation of Axi Bus Interface S_AXI
	Zybo_VGA_Reconfigurable_v1_0_S_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
	) Zybo_VGA_Reconfigurable_v1_0_S_AXI_inst (
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
        .InImage_Color(InImage_Color_w),
        .OutImage_Color(OutImage_Color_w),
		.S_AXI_ACLK(s_axi_aclk),
		.S_AXI_ARESETN(s_axi_aresetn),
		.S_AXI_AWADDR(s_axi_awaddr),
		.S_AXI_AWPROT(s_axi_awprot),
		.S_AXI_AWVALID(s_axi_awvalid),
		.S_AXI_AWREADY(s_axi_awready),
		.S_AXI_WDATA(s_axi_wdata),
		.S_AXI_WSTRB(s_axi_wstrb),
		.S_AXI_WVALID(s_axi_wvalid),
		.S_AXI_WREADY(s_axi_wready),
		.S_AXI_BRESP(s_axi_bresp),
		.S_AXI_BVALID(s_axi_bvalid),
		.S_AXI_BREADY(s_axi_bready),
		.S_AXI_ARADDR(s_axi_araddr),
		.S_AXI_ARPROT(s_axi_arprot),
		.S_AXI_ARVALID(s_axi_arvalid),
		.S_AXI_ARREADY(s_axi_arready),
		.S_AXI_RDATA(s_axi_rdata),
		.S_AXI_RRESP(s_axi_rresp),
		.S_AXI_RVALID(s_axi_rvalid),
		.S_AXI_RREADY(s_axi_rready)
	);

//Instantiation of User-Defined Modules
VGA_Control controller(
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
    .InImage_Color(InImage_Color_w),
    .OutImage_Color(OutImage_Color_w),
    .pixel_clk(pixel_clk),
    .VGA_R(VGA_R),
    .VGA_B(VGA_B),
    .VGA_G(VGA_G),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS)
);

	// Add user logic here

	// User logic ends

	endmodule
