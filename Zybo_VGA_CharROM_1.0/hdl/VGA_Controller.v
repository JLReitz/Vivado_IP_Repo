module VGA_Controller(
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
        input  wire [6:0]  Character,
        input  wire [15:0] Background_Color,
        input  wire [15:0] Font_Color,
        input  wire [31:0] Char_XLoc,
        input  wire [31:0] Char_YLoc,
        input  wire        pixel_clk,    
        output  reg [4:0]  VGA_R,
        output  reg [4:0]  VGA_B,
        output  reg [5:0]  VGA_G,
        output  reg        VGA_HS,
        output  reg        VGA_VS
    );
    
    // Wires, Registers, and LocalParams
    
    wire        FontWire;
    wire  [15:0] Data;
    wire [31:0] H_Start, H_End, V_Start, V_End, H_Length, V_Length;
    reg         H_InRange = 0, V_InRange = 0, Shift_Rst;
    reg  [10:0] Address;
    integer     H_Counter, V_Counter, Shift_Counter;
    
    assign H_Start = H_Sync + H_BP + H_LR_Border - 1;
    assign H_End = H_Start + H_Range;
    assign V_Start = V_Sync + V_BP + V_TB_Border - 1;
    assign V_End = V_Start + V_Range;
    assign H_Length = H_Sync + H_BP + H_FP + H_Range + H_LR_Border - 1;
    assign V_Length = V_Sync + V_BP + V_FP + V_Range + V_TB_Border - 1;
    
    // Modules
    
    char_rom CharROM (
        .DO(Data),       // Output data, width defined by READ_WIDTH parameter
        .ADDR(Address),   // Input address, width defined by read/write port depth
        .CLK(pixel_clk),     // 1-bit input clock
        .DI(16'h0),       // Input data port, width defined by WRITE_WIDTH parameter
        .EN(1'b1),       // 1-bit input RAM enable
        .REGCE(1'b0), // 1-bit input output register enable
        .RST(1'b0),     // 1-bit input reset
        .WE(2'd0)        // Input write enable, width defined by write port depth
        );
    
    // Behavior
    
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
    
    //Increment the horizontal and vertical counters
    //Enable H-Sync and V-Sync if necessary
    always @ (posedge(pixel_clk))
    begin
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
                
            if((H_Counter >= 0) && (H_Counter < H_Sync))
                VGA_HS = 1'd0;
            else
                VGA_HS = 1'd1;
                
            if((V_Counter >= 0) && (V_Counter < V_Sync))
                VGA_VS = 1'd0;
            else
                VGA_VS = 1'd1;
        end
        else
        begin
            VGA_HS = 1'd0;
            VGA_VS = 1'd0;
            H_Counter = 32'd0;
            V_Counter = 32'd0;
        end
    end
    
    //Enable the image if within the image range
    always @ (posedge(pixel_clk))
    begin    
        if((H_Counter >= H_Start) && (H_Counter <= H_End))
            H_InRange <= 1'd1;
        else
            H_InRange <= 1'd0;
            
        if((V_Counter >= V_Start) && (V_Counter <= V_End))
            V_InRange <= 1'd1;
        else
            V_InRange <= 1'd0;
    end
    
    //Display image if in range
    always @ (posedge(pixel_clk))
    begin    
        if(H_InRange && V_InRange)
        begin
            if(FontWire)
            begin
                VGA_R <= Font_Color[4:0];
                VGA_B <= Font_Color[9:5];
                VGA_G <= Font_Color[15:10];
            end
            else
            begin
                VGA_R <= Background_Color[4:0];
                VGA_B <= Background_Color[9:5];
                VGA_G <= Background_Color[15:10];
            end
        end
        else
        begin
            VGA_R <= 5'd0;
            VGA_B <= 5'd0;
            VGA_G <= 6'd0;
        end
    end
    
    //Apply next character address
    always @ (posedge(pixel_clk))
    begin
        if(((H_Counter >= Char_XLoc) && (H_Counter <= (Char_XLoc+14))) &&
            ((V_Counter >= Char_YLoc) && (V_Counter <= (Char_YLoc+15))))
        begin
            Address[10:4] <= Character;
            Address[3:0] <= V_Counter - Char_YLoc;
            Shift_Rst <= 1'd0;
        end    
        else
        begin
            Address <= 11'd0;
            Shift_Rst <= 1'd1;
        end   
    end
    
    //Logic to shift through Data and grab the correct pixel bit
    always @ (posedge(pixel_clk))
    begin
        if(Shift_Rst)
            Shift_Counter <= 32'd0;
        else
            Shift_Counter <= Shift_Counter + 32'd1;
    end
    
    // Logic
    assign FontWire = Data[Shift_Counter];
    
endmodule
