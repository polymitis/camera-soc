// Project   : Camera FPGA
// Details   : VGA controller with Avalon interface.
`ifndef M_VGACTRL_SV
`define M_VGACTRL_SV

`include "../I_DrawPoint.sv"
`include "../M_VgaDriver.sv"

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
        // External PLL locked signal 
        input  wire        coe_locked_export           //    locked.export
	);
    timeunit 1ns;
    timeprecision 1ps;
    
    logic ul1CmdClock;
    logic ul1VgaClock;
	
    // VGA output interface
    tIVgaOut iIVgaOut(ul1VgaClock);
    
    // Frame transfer bus
    tIDrawPoint iIDrawPoint(ul1CmdClock);
    
    // VGA driver
    tMVgaDriver iMVgaDriver 
    ( // Ports:
        .pIVgaOut       (iIVgaOut),
        .pIDrawPoint    (iIDrawPoint)
    );
    
    // Command interface clock
    assign ul1CmdClock = csi_cmd_clock_clk;
    
    // VGA clock
    assign ul1VgaClock = csi_vga_clock_clk;
    
    // export command interface
    assign avs_cmd_readdata = 16'b0000000000000000;
    assign avs_cmd_waitrequest = 1'b0;
    assign avs_cmd_readdatavalid = 1'b0;
    
    // export VGA output interface
    assign iIVgaOut.ul1Reset_n = (~rsi_vga_reset_reset) & coe_locked_export; // release reset only after PLL has locked
    assign coe_vga_red = iIVgaOut.ul8Red;    
    assign coe_vga_green = iIVgaOut.ul8Green;  
    assign coe_vga_blue = iIVgaOut.ul8Blue;
    assign coe_vga_pixelclock = iIVgaOut.ul1PixelClock;
    assign coe_vga_blank_n = iIVgaOut.ul1Blank_n;
    assign coe_vga_sync_n = iIVgaOut.ul1Sync_n; 
    assign coe_vga_hsync = iIVgaOut.ul1HSync;  
    assign coe_vga_vsync = iIVgaOut.ul1VSync;

endmodule : tMVgaCtrl

`endif//M_VGACTRL_SV
