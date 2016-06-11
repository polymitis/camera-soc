// Project   : Camera FPGA
// Details   : DrawPoint master interface.
`ifndef M_DRAWPOINTMI_SV
`define M_DRAWPOINTMI_SV

`timescale 1 ps / 1 ps
module tMVDrawPointMI (
        // Command interface
        input  wire        csi_cmd_clock_clk,          // cmd_clock.clk
        input  wire        rsi_cmd_reset_reset,        // cmd_reset.reset
		input  wire [16:0] avs_cmd_address,            //       cmd.address
		input  wire        avs_cmd_read,               //          .read
		output wire [15:0] avs_cmd_readdata,           //          .readdata
		input  wire        avs_cmd_write,              //          .write
		input  wire [15:0] avs_cmd_writedata,          //          .writedata
		input  wire        avs_cmd_beginbursttransfer, //          .beginbursttransfer
		input  wire [15:0] avs_cmd_burstcount,         //          .burstcount
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

	// TODO: translate Avalon MM to DrawPoint M

    assign avs_cmd_readdata = 16'b0000000000000000;

    assign avs_cmd_waitrequest = 1'b0;

    assign avs_cmd_readdatavalid = 1'b0;
    
    assign coe_dpm_ul1Clock = csi_cmd_clock_clk;
    
    assign coe_dpm_ul1Reset_n = ~rsi_cmd_reset_reset;
    
    assign coe_dpm_ul1Update = 1'b0;  
    
    assign coe_dpm_ul9PosX = 9'b000000000;      
    
    assign coe_dpm_ul9PosY = 9'b000000000;      
    
    assign coe_dpm_ul12Rgb12Data = 12'b000000000000;
    
endmodule : tMVDrawPointMI

`endif//M_DRAWPOINTMI_SV
