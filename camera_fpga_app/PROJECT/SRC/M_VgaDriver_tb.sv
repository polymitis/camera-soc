// Project   : VGA
// Details   : VGA driver (60Hz, 640x480) testbench.
`ifndef M_VGADRIVER_TB_SV
`define M_VGADRIVER_TB_SV

`include "I_FrameTransfer.sv"
`include "M_VgaDriver.sv"
`include "M_FrameBuffer_640x480.sv"

module tMVgaDriver_tb;
    timeunit 1ns;
    timeprecision 1ps;

    localparam time SYS_CLOCK_PERIOD = 20ns;
    localparam time PLL_CLOCK_PERIOD = 39.722ns;
    
    // System clock
    logic ul1SysClock; // 50 MHz
    always #(SYS_CLOCK_PERIOD/2) ul1SysClock <= ~ul1SysClock;
    
    // Pll clock 
    logic ul1PllClock; // 25.175 MHz
    always #(PLL_CLOCK_PERIOD/2) ul1PllClock <= ~ul1PllClock;
    
    localparam int unsigned RESET_DELAY_CC = 50000; // 1 ms delay with a 50 MHz clock
    
    logic ul1Reset_n; // asynchronous reset    
    logic ul1SysReset_n; // reset in sync with SysClock
    logic ul1PllReset_n; // reset in sync with PllClock
    
    // VGA output interface
    tIVgaOut iIVgaOut
    ( // Ports:
        .ul1Clock       (ul1PllClock),
        .ul1Reset_n     (ul1PllReset_n)
    );
     
    // Frame transfer bus
    tIFrameTransfer iIFrameTransfer 
    ( // Ports:
        .ul1Clock       (ul1SysClock),
        .ul1Reset_n     (ul1SysReset_n)
    );
    
    // System reset
    tMResetSync  
    #(// Parameters:
        .RESET_DELAY_CC (RESET_DELAY_CC)
    )
    iMSysResetSync
    ( // Ports:
        .piul1Clock     (ul1SysClock),
        .piul1ResetIn   (ul1Reset_n),
        .poul1ResetOut  (ul1SysReset_n)
    );
    
    // Pll reset
    tMResetSync  
    #(// Parameters:
        .RESET_DELAY_CC (RESET_DELAY_CC)
    )
    iMPllResetSync
    ( // Ports:
        .piul1Clock     (ul1PllClock),
        .piul1ResetIn   (ul1Reset_n),
        .poul1ResetOut  (ul1PllReset_n)
    );
    
    // VGA driver
    tMVgaDriver iMVgaDriver 
    ( // Ports:
        .pIVgaOut       (iIVgaOut),
        .pIFrameIn      (iIFrameTransfer)
    );

endmodule : tMVgaDriver_tb

`endif//M_VGADRIVER_TB_SV
