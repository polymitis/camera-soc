// Project   : camera_fpga_app
// Details   : Top module for Terasic DE1-SOC rev.D board.
`ifndef M_CAMERAFPGA_SV
`define M_CAMERAFPGA_SV

`include "I_TRDB_D5M.sv"
`include "I_VgaOut.sv"
`include "I_FrameTransfer.sv"
`include "M_PLL.sv"
`include "M_ResetSync.sv"
`include "M_TRDB_D5M_Driver.sv"
`include "M_VgaDriver.sv"

module tMCameraFpga 
( // Ports:
    input  logic        piul1FpgaClock,
    input  logic        piul1FpgaReset_n,
    output logic [9:0]  poul10LEDR,
    tITRDB_D5M.conx     pITRDB_D5M,
    tIVgaOut.conx       pIVgaOut
); 
    localparam int unsigned RESET_DELAY_CC = 50000;
    
    logic ul1SysClock;
    logic ul1SysReset_n;
    
    logic ul1PllClock;
    logic ul1PllLocked;
    logic ul1PllReset_n;
    
    // Image sensor interface
    tITRDB_D5M iITRDB_D5M(ul1SysClock);
    
    // VGA output interface
    tIVgaOut iIVgaOut(ul1PllClock);
     
    // Frame transfer bus
    tIFrameTransfer iIFrameTransfer(ul1SysClock);
    
    // System reset
    tMResetSync  
    #(// Parameters:
        .RESET_DELAY_CC (RESET_DELAY_CC)
    )
    iMSysResetSync
    ( // Ports:
        .piul1Clock     (ul1SysClock),
        .piul1ResetIn   (piul1FpgaReset_n),
        .poul1ResetOut  (ul1SysReset_n)
    );

    // PLL clock
    tMPLL iMPLL 
    ( // Ports:
        .piul1RefClock  (ul1SysClock),
        .piul1Reset_n   (ul1SysReset_n),
        .poul1ClockOut  (ul1PllClock),
        .poul1Locked    (ul1PllLocked)
    );
    
    // Pll reset
    tMResetSync  
    #(// Parameters:
        .RESET_DELAY_CC (RESET_DELAY_CC)
    )
    iMPllResetSync
    ( // Ports:
        .piul1Clock     (ul1PllClock),
        .piul1ResetIn   (piul1FpgaReset_n),
        .poul1ResetOut  (ul1PllReset_n)
    );
    
    // Image sensor driver
    tMTRDB_D5M_Driver iMTRDB_D5M_Driver 
    ( // Ports:
        .pISensor       (iITRDB_D5M),
        .pIFrameOut     (iIFrameTransfer)
    );
    
    // VGA driver
    tMVgaDriver iMVgaDriver 
    ( // Ports:
        .pIVgaOut       (iIVgaOut),
        .pIFrameIn      (iIFrameTransfer)
    );
    
    // dim unused leds
    assign poul10LEDR[8:0] = 'b0;
    
    // System clock
    assign ul1SysClock = piul1FpgaClock;
    
    // export reset indicator
    assign poul10LEDR[9] = ul1SysReset_n;
    
    // export Image sensor interface
    assign iIFrameTransfer.ul1Reset_n    = ul1SysReset_n;
    assign iITRDB_D5M.ul1PixelClock      = pITRDB_D5M.ul1PixelClock;
    assign iITRDB_D5M.ul12PixelData      = pITRDB_D5M.ul12PixelData;
    assign pITRDB_D5M.ul1ExtClockInput   = iITRDB_D5M.ul1ExtClockInput;
    assign pITRDB_D5M.ul1Resetn          = iITRDB_D5M.ul1Resetn;
    assign pITRDB_D5M.ul1SnapshotTrigger = iITRDB_D5M.ul1SnapshotTrigger;
    assign iITRDB_D5M.ul1SnapshotStrobe  = pITRDB_D5M.ul1SnapshotStrobe;
    assign iITRDB_D5M.ul1LineValid       = pITRDB_D5M.ul1LineValid;
    assign iITRDB_D5M.ul1FrameValid      = pITRDB_D5M.ul1FrameValid;
    assign iITRDB_D5M.ul1SdaIn           = (iITRDB_D5M.ul1SdaOEn == 1'b0)? pITRDB_D5M.ul1Sda    : 1'b0;
    assign pITRDB_D5M.ul1Sda             = (iITRDB_D5M.ul1SdaOEn == 1'b1)? iITRDB_D5M.ul1SdaOut : 1'bZ;
    assign pITRDB_D5M.ul1Scl             = iITRDB_D5M.ul1Scl;
    
    // export VGA output interface
    assign iIVgaOut.ul1Reset_n    = ul1PllReset_n & ul1PllLocked; // release reset only after PLL has locked
    assign pIVgaOut.ul8Red        = iIVgaOut.ul8Red;    
    assign pIVgaOut.ul8Green      = iIVgaOut.ul8Green;  
    assign pIVgaOut.ul8Blue       = iIVgaOut.ul8Blue;
    assign pIVgaOut.ul1PixelClock = iIVgaOut.ul1PixelClock;
    assign pIVgaOut.ul1Blank_n    = iIVgaOut.ul1Blank_n;
    assign pIVgaOut.ul1Sync_n     = iIVgaOut.ul1Sync_n; 
    assign pIVgaOut.ul1HSync      = iIVgaOut.ul1HSync;  
    assign pIVgaOut.ul1VSync      = iIVgaOut.ul1VSync; 
    
endmodule : tMCameraFpga

`endif//M_CAMERAFPGA_SV
