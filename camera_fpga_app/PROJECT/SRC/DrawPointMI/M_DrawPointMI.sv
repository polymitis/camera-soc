// Project   : Camera FPGA
// Details   : DrawPoint master interface
`ifndef M_DRAWPOINTMI_SV
`define M_DRAWPOINTMI_SV

`timescale 1 ps / 1 ps
module tMDrawPointMI (
        // Command interface
        input  wire        csi_cmd_clock_clk,          // cmd_clock.clk
        input  wire        rsi_cmd_reset_reset,        // cmd_reset.reset
		input  wire [15:0] avs_cmd_address,            //       cmd.address
		input  wire        avs_cmd_read,               //          .read
		output wire [15:0] avs_cmd_readdata,           //          .readdata
		input  wire        avs_cmd_write,              //          .write
		input  wire [15:0] avs_cmd_writedata,          //          .writedata
		input  wire        avs_cmd_beginbursttransfer, //          .beginbursttransfer
		input  wire [9:0]  avs_cmd_burstcount,         //          .ul10BurstCount
		output wire        avs_cmd_readdatavalid,      //          .readdatavalid
		output wire        avs_cmd_waitrequest,        //          .waitrequest
        input  wire [1:0]  avs_cmd_byteenable,         //          .byteenable
        // DrawPoint external interface
        output wire        coe_dpm_ul1Clock,           //       dpm.dpm_ul1Clock   
        output wire        coe_dpm_ul1Reset_n,         //          .dpm_ul1Reset_n   
        output wire        coe_dpm_ul1Update,          //          .dpm_ul1Update   
        output wire [8:0]  coe_dpm_ul9PosX,            //          .dpm_ul9PosX     
        output wire [8:0]  coe_dpm_ul9PosY,            //          .dpm_ul9PosY     
        output wire [11:0] coe_dpm_ul12Rgb12Data       //          .dpm_ul12Rgb12Data
	);
    
    const logic [15:0] cul16MajorVersionRegisterAddress   = 16'h0000; 
    const logic [15:0] cul16MinorVersionRegisterAddress   = 16'h0001; 
    const logic [15:0] cul16RevisionNumberRegisterAddress = 16'h0002;
    const logic [15:0] cul16BuildNumberRegisterAddress    = 16'h0003; 
    
    const logic [7:0] cul8MajorVersionRegister   = 8'hFF;
    const logic [7:0] cul8MinorVersionRegister   = 8'h00;
    const logic [7:0] cul8RevisionNumberRegister = 8'h00;
    const logic [7:0] cul8BuildNumberRegister    = 8'h01;
    
    typedef enum logic [1:0]
    {
        BURST_STATE_IDLE = 3'b01,
        BURST_STATE_RUN  = 3'b10
        
    } teBurstState;
    
    teBurstState eBurstState = BURST_STATE_IDLE;
    
    logic [15:0] ul16ReadAddress;
    
    logic        ul1BurstActive;
    logic [9:0]  ul10BurstCount;
    logic [15:0] ul16BurstReadAddress;
    
    logic [15:0] ul16VersionReadData;
    logic        ul1VersionReadDataValid;
    
    // Burst controller
    always_ff @ (posedge csi_cmd_clock_clk)
    begin: p_burst_controller
        if (rsi_cmd_reset_reset == 1'b1)
        begin
            ul1BurstActive <= 1'b0;
            ul16BurstReadAddress <= 16'd0;
            ul10BurstCount <= 10'd0;
            eBurstState <= BURST_STATE_IDLE;
        end
        else
        begin
            unique case (eBurstState)
            
                BURST_STATE_IDLE:
                begin
                    ul16BurstReadAddress <= 16'd0;
                    if (avs_cmd_beginbursttransfer == 1'b1 && avs_cmd_burstcount > 10'd1)
                    begin
                        ul1BurstActive <= 1'b1;
                        ul16BurstReadAddress <= avs_cmd_address + 1'd1;
                        ul10BurstCount <= avs_cmd_burstcount - 1'd1;
                        eBurstState <= BURST_STATE_RUN;
                    end
                end
                
                BURST_STATE_RUN:
                begin
                    if (ul10BurstCount != 10'd0)
                    begin
                        ul16BurstReadAddress <= ul16BurstReadAddress + 1'd1;
                        ul10BurstCount <= ul10BurstCount - 1'd1;
                    end
                    else
                    begin
                        ul1BurstActive <= 1'b0;
                        eBurstState <= BURST_STATE_IDLE;
                    end
                end
            endcase
        end
    end: p_burst_controller
    
    // Address mux
    always_comb
    begin: p_adress_mux
        ul16ReadAddress <= avs_cmd_address;
        if (ul1BurstActive == 1'b1)
        begin
            ul16ReadAddress <= ul16BurstReadAddress;
        end
    end: p_adress_mux
    
    // Version registers (Read only)
    always_ff @ (posedge csi_cmd_clock_clk) 
    begin: p_version_regs
        if (rsi_cmd_reset_reset == 1'b1) 
        begin
            ul16VersionReadData <= 16'h0000;
            ul1VersionReadDataValid <= 1'b0;
        end
        else 
        begin
            if (avs_cmd_byteenable[0] == 1'b1)
            begin
                ul16VersionReadData <= 16'h0000;
                ul1VersionReadDataValid <= 1'b0;
                // Address decoder
                unique case (ul16ReadAddress)
                
                    cul16MajorVersionRegisterAddress:
                    begin
                        ul16VersionReadData <= {8'h00,cul8MajorVersionRegister};
                        ul1VersionReadDataValid <= 1'b1;
                    end
                    
                    cul16MinorVersionRegisterAddress:
                    begin
                        ul16VersionReadData <= {8'h00,cul8MinorVersionRegister};
                        ul1VersionReadDataValid <= 1'b1;
                    end
                    
                    cul16RevisionNumberRegisterAddress:
                    begin
                        ul16VersionReadData <= {8'h00,cul8RevisionNumberRegister};
                        ul1VersionReadDataValid <= 1'b1;
                    end
                    
                    cul16BuildNumberRegisterAddress:
                    begin
                        ul16VersionReadData <= {8'h00,cul8BuildNumberRegister};
                        ul1VersionReadDataValid <= 1'b1;
                    end
                    
                    default:
                    begin
                        // Do nothing - just for avoiding the enormous number of warning in altera-modelsim
                    end
                endcase
            end
        end
    end: p_version_regs

	// TODO: translate Avalon MM to DrawPoint M

    assign avs_cmd_readdata = ul16VersionReadData;

    assign avs_cmd_waitrequest = 1'b0;

    assign avs_cmd_readdatavalid = ul1VersionReadDataValid;
    
    assign coe_dpm_ul1Clock = csi_cmd_clock_clk;
    
    assign coe_dpm_ul1Reset_n = ~rsi_cmd_reset_reset;
    
    assign coe_dpm_ul1Update = 1'b0;  
    
    assign coe_dpm_ul9PosX = 9'b000000000;      
    
    assign coe_dpm_ul9PosY = 9'b000000000;      
    
    assign coe_dpm_ul12Rgb12Data = 12'b000000000000;
    
endmodule : tMDrawPointMI

`endif//M_DRAWPOINTMI_SV
