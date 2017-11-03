
`timescale 1 ns / 1 ps

	module Zybo_PWMext_v1_0 #
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
        output  wire [3:0]  LED,
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
	
// Instantiation of User-Defines Wires
    
    wire        clk_div0_w, clk_div1_w, clk_div2_w, clk_div3_w;
    wire [3:0]  PWM_en_w;
    wire [9:0]  cntr0_w, cntr1_w, cntr2_w, cntr3_w;
    wire [9:0]  PWM_duty0_w, PWM_duty1_w, PWM_duty2_w, PWM_duty3_w;
    wire [15:0]  PWM_window_freq0_w, PWM_window_freq1_w, PWM_window_freq2_w, PWM_window_freq3_w;
        
	
// Instantiation of Axi Bus Interface S_AXI
	Zybo_PWMext_v1_0_S_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
	) Zybo_PWMext_v1_0_S_AXI_inst (
	    .PWM_en(PWM_en_w),
        .PWM_duty0(PWM_duty0_w),
        .PWM_duty1(PWM_duty1_w),
        .PWM_duty2(PWM_duty2_w),
        .PWM_duty3(PWM_duty3_w),
        .PWM_window_freq0(PWM_window_freq0_w),
        .PWM_window_freq1(PWM_window_freq1_w),
        .PWM_window_freq2(PWM_window_freq2_w),
        .PWM_window_freq3(PWM_window_freq3_w),
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

// Instantiation of User-Defined Modules

    Clock_Divider clock_div0(
        .clk(s_axi_aclk),
        .range(PWM_window_freq0_w),
        .clk_div(clk_div0_w)
    );
    
    Clock_Divider clock_div1(
        .clk(s_axi_aclk),
        .range(PWM_window_freq1_w),
        .clk_div(clk_div1_w)
    );
    
    Clock_Divider clock_div2(
        .clk(s_axi_aclk),
        .range(PWM_window_freq2_w),
        .clk_div(clk_div2_w)
    );
    
    Clock_Divider clock_div3(
        .clk(s_axi_aclk),
        .range(PWM_window_freq3_w),
        .clk_div(clk_div3_w)
    );
    
    PWM_Counter counter0(
        .clk(clk_div0_w),
        .en(PWM_en_w[0]),
        .cntr(cntr0_w)
    );
    
    PWM_Counter counter1(
        .clk(clk_div1_w),
        .en(PWM_en_w[1]),
        .cntr(cntr1_w)
    );
    
    PWM_Counter counter2(
        .clk(clk_div2_w),
        .en(PWM_en_w[2]),
        .cntr(cntr2_w)
    );
    
    PWM_Counter counter3(
        .clk(clk_div3_w),
        .en(PWM_en_w[3]),
        .cntr(cntr3_w)
    );
    
    PWM_Comparator comparator0(
        .clk(clk_div0_w),
        .PWM_duty(PWM_duty0_w),
        .cntr(cntr0_w),
        .PWM(LED[0])
    );
    
    PWM_Comparator comparator1(
        .clk(clk_div1_w),
        .PWM_duty(PWM_duty1_w),
        .cntr(cntr1_w),
        .PWM(LED[1])
    );
        
    PWM_Comparator comparator2(
        .clk(clk_div2_w),
        .PWM_duty(PWM_duty2_w),
        .cntr(cntr2_w),
        .PWM(LED[2])
    );
    
    PWM_Comparator comparator3(
        .clk(clk_div3_w),
        .PWM_duty(PWM_duty3_w),
        .cntr(cntr3_w),
        .PWM(LED[3])
    );

	// Add user logic here

	// User logic ends

	endmodule
