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
		input  wire [9:0]  avs_cmd_burstcount,         //          .burstcount
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
    
    logic [15:0] version_readdata;
    logic        version_readdatavalid;
    
    always_ff @ (posedge csi_cmd_clock_clk) 
    begin: p_version_regs
        if (rsi_cmd_reset_reset == 1'b1) 
        begin
            version_readdata <= 16'h0000;
            version_readdatavalid <= 1'b0;
        end
        else 
        begin
            if (avs_cmd_byteenable[0] == 1'b1)
            begin
                version_readdata <= 16'h0000;
                version_readdatavalid <= 1'b0;
                // Address decoder
                unique case (avs_cmd_address)
                
                    cul16MajorVersionRegisterAddress:
                    begin
                        version_readdata <= {8'h00,cul8MajorVersionRegister};
                        version_readdatavalid <= 1'b1;
                    end
                    
                    cul16MinorVersionRegisterAddress:
                    begin
                        version_readdata <= {8'h00,cul8MinorVersionRegister};
                        version_readdatavalid <= 1'b1;
                    end
                    
                    cul16RevisionNumberRegisterAddress:
                    begin
                        version_readdata <= {8'h00,cul8RevisionNumberRegister};
                        version_readdatavalid <= 1'b1;
                    end
                    
                    cul16BuildNumberRegisterAddress:
                    begin
                        version_readdata <= {8'h00,cul8BuildNumberRegister};
                        version_readdatavalid <= 1'b1;
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

    assign avs_cmd_readdata = version_readdata;

    assign avs_cmd_waitrequest = 1'b0;

    assign avs_cmd_readdatavalid = version_readdatavalid;
    
    assign coe_dpm_ul1Clock = csi_cmd_clock_clk;
    
    assign coe_dpm_ul1Reset_n = ~rsi_cmd_reset_reset;
    
    assign coe_dpm_ul1Update = 1'b0;  
    
    assign coe_dpm_ul9PosX = 9'b000000000;      
    
    assign coe_dpm_ul9PosY = 9'b000000000;      
    
    assign coe_dpm_ul12Rgb12Data = 12'b000000000000;
    
endmodule : tMDrawPointMI

`endif//M_DRAWPOINTMI_SV
