// Project   : Camera FPGA
// Details   : VGA controller with Avalon interface.
`ifndef M_VGACTRL_SV
`define M_VGACTRL_SV

`timescale 1 ps / 1 ps
module tMVgaCtrl (
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
        // VGA external interface
        input  wire        csi_vga_clock_clk,          // vga_clock.clk
        input  wire        rsi_vga_reset_reset,        // vga_reset.reset
        output wire [7:0]  coe_vga_red,                //       vga.vga_red
        output wire [7:0]  coe_vga_green,              //          .vga_green
        output wire [7:0]  coe_vga_blue,               //          .vga_blue
        output wire        coe_vga_pixelclock,         //          .vga_pixelclock
        output wire        coe_vga_blank_n,            //          .vga_blank_n
        output wire        coe_vga_sync_n,             //          .vga_sync_n
        output wire        coe_vga_hsync,              //          .vga_hsync
        output wire        coe_vga_vsync,              //          .vga_vsync
        input  wire        coe_vga_pll_locked          //          .vga_pll_locked
	);

	// TODO: integrade VgaDriver

    assign avs_cmd_readdata = 16'b0000000000000000;

    assign avs_cmd_waitrequest = 1'b0;

    assign avs_cmd_readdatavalid = 1'b0;

    assign coe_vga_pixelclock = 1'b0;

    assign coe_vga_blue = 8'b00000000;

    assign coe_vga_vsync = 1'b0;

    assign coe_vga_red = 8'b00000000;

    assign coe_vga_sync_n = 1'b0;

    assign coe_vga_hsync = 1'b0;

    assign coe_vga_green = 8'b00000000;

    assign coe_vga_blank_n = 1'b0;

endmodule : tMVgaCtrl

`endif//M_VGACTRL_SV
