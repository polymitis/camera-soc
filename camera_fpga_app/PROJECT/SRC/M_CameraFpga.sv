// Project   : camera_fpga_app
// Details   : Top module for Terasic DE1-SOC rev.D board.
`ifndef M_CAMERAFPGA_SV
`define M_CAMERAFPGA_SV

`include "I_TRDB_D5M.sv"
`include "I_VgaOut.sv"
`include "I_FrameTransfer.sv"
`include "I_DrawPoint.sv"
`include "M_PLL.sv"
`include "M_SyncSig.sv"
`include "M_TRDB_D5M_Driver.sv"
`include "M_VgaDriver.sv"

module tMCameraFpga 
( // Ports:
    input  logic        piul1FpgaClock, // 50 MHz
    input  logic        piul1FpgaReset_n,
    output logic [9:0]  poul10LEDR,
    tITRDB_D5M.conx     pITRDB_D5M,
    tIVgaOut.conx       pIVgaOut
); 
    
    logic ul1SysClock;
    logic ul1SysReset;
    logic ul1SysReset_n;
    
    logic ul1PllClock;
    logic ul1PllLocked;
    logic ul1PllReset_n;
    
    // Image sensor interface
    tITRDB_D5M iITRDB_D5M
    ( // Ports:
        .ul1Clock (ul1SysClock),
        .ul1Reset_n (ul1SysReset_n)
    );
    
    // VGA output interface
    tIVgaOut iIVgaOut
    ( //Ports:
        .ul1Clock (ul1PllClock)
    );
     
    // Frame transfer bus
    tIFrameTransfer iIFrameTransfer
    ( // Ports:
        .ul1Clock (ul1SysClock)
    );
    
    // Draw point interface
    tIDrawPoint iIDrawPoint
    ( // Ports:
        .ul1Clock (ul1SysClock)
    );
    
    // System reset
    tMSyncSig  
    #(// Parameters:
        .SYNC_DELAY_CC  (3)
    )
    iMSysResetSync
    ( // Ports:
        .piul1SyncClock (ul1SysClock),
        .piul1SigIn     (piul1FpgaReset_n),
        .poul1SigOut    (ul1SysReset_n)
    );

    // PLL clock
    tMPLL iMPLL 
    ( // Ports:
        .piul1RefClock  (ul1SysClock), // 50 MHz
        .piul1Reset_n   (ul1SysReset),
        .poul1ClockOut  (ul1PllClock), // 25.175644 MHz
        .poul1Locked    (ul1PllLocked)
    );
    
    // Pll reset
    tMSyncSig 
    #(// Parameters:
        .SYNC_DELAY_CC  (3)
    )
    iMPllResetSync
    ( // Ports:
        .piul1SyncClock (ul1PllClock),
        .piul1SigIn     (piul1FpgaReset_n),
        .poul1SigOut    (ul1PllReset_n)
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
        .pIDrawPoint    (iIDrawPoint)
    );
    
    // dim unused leds
    assign poul10LEDR[8:0] = 'b0;
    
    // System clock
    assign ul1SysClock = piul1FpgaClock;
    
    // System reset (Active-High)
    assign ul1SysReset = ~ul1SysReset_n;
    
    // export reset indicator
    assign poul10LEDR[9] = ul1SysReset_n;
    
    // export Image sensor interface
    assign iITRDB_D5M.ul1PixelClock = pITRDB_D5M.ul1PixelClock;
    assign iITRDB_D5M.ul12PixelData = pITRDB_D5M.ul12PixelData;
    assign pITRDB_D5M.ul1ExtClockInput = iITRDB_D5M.ul1ExtClockInput;
    assign pITRDB_D5M.ul1Resetn = iITRDB_D5M.ul1Resetn;
    assign pITRDB_D5M.ul1SnapshotTrigger = iITRDB_D5M.ul1SnapshotTrigger;
    assign iITRDB_D5M.ul1SnapshotStrobe = pITRDB_D5M.ul1SnapshotStrobe;
    assign iITRDB_D5M.ul1LineValid = pITRDB_D5M.ul1LineValid;
    assign iITRDB_D5M.ul1FrameValid = pITRDB_D5M.ul1FrameValid;
    assign iITRDB_D5M.ul1SdaIn = (iITRDB_D5M.ul1SdaOEn == 1'b0)? pITRDB_D5M.wl1Sda : 1'b0;
    assign pITRDB_D5M.wl1Sda = (iITRDB_D5M.ul1SdaOEn == 1'b1)? iITRDB_D5M.ul1SdaOut : 1'bZ;
    assign pITRDB_D5M.ul1Scl = iITRDB_D5M.ul1Scl;
    
    // export VGA output interface
    assign iIVgaOut.ul1Reset_n = ul1PllReset_n & ul1PllLocked; // release reset only after PLL has locked
    assign pIVgaOut.ul8Red = iIVgaOut.ul8Red;    
    assign pIVgaOut.ul8Green = iIVgaOut.ul8Green;  
    assign pIVgaOut.ul8Blue = iIVgaOut.ul8Blue;
    assign pIVgaOut.ul1PixelClock = iIVgaOut.ul1PixelClock;
    assign pIVgaOut.ul1Blank_n = iIVgaOut.ul1Blank_n;
    assign pIVgaOut.ul1Sync_n = iIVgaOut.ul1Sync_n; 
    assign pIVgaOut.ul1HSync = iIVgaOut.ul1HSync;  
    assign pIVgaOut.ul1VSync = iIVgaOut.ul1VSync;
    
endmodule : tMCameraFpga

`endif//M_CAMERAFPGA_SV
