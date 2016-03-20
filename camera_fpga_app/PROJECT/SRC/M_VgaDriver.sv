// Project   : VGA
// Details   : VGA driver (60Hz, 640x480).
`ifndef M_VGADRIVER_SV
`define M_VGADRIVER_SV

`include "I_VgaOut.sv"
`include "I_FrameTransfer.sv"
`include "M_FrameBuffer_320x240.sv"

module tMVgaDriver 
( // Ports:
    tIVgaOut.driver         pIVgaOut,
    tIFrameTransfer.dest    pIFrameIn
);
    const logic [9:0] cul10HSyncDurationCC       = 96;  // 3.810 us
    const logic [9:0] cul10HBackPorchDurationCC  = 48;  // 1.910 us
    const logic [9:0] cul10HDisplayDurationCC    = 640; // 25.40 us
    const logic [9:0] cul10HFrontPorchDurationCC = 16;  // 0.636 us
    
    const logic [9:0] cul10VSyncDurationLC       = 2;
    const logic [9:0] cul10VBackPorchDurationLC  = 33;
    const logic [9:0] cul10VDisplayDurationLC    = 480;
    const logic [9:0] cul10VFrontPorchDurationLC = 10;

    typedef enum logic [1:0]
    {
        HSYNC_STATE_SYNC,
        HSYNC_STATE_BACKPORCH,
        HSYNC_STATE_DISPLAY,
        HSYNC_STATE_FRONTPORCH
        
    } teHSyncState;
    
    typedef enum logic [1:0]
    {
        VSYNC_STATE_SYNC,
        VSYNC_STATE_BACKPORCH,
        VSYNC_STATE_DISPLAY,
        VSYNC_STATE_FRONTPORCH
        
    } teVSyncState;
    
    teHSyncState eHSyncState;
    teVSyncState eVSyncState;
    
    logic [9:0]  ul10HSyncClockCounter;
    logic [9:0]  ul10VSyncLineCounter;
    
    logic        ul1HSyncDisplayActive;
    logic        ul1VSyncDisplayActive;
    
    logic        ul1EndOfLine;
    
    logic [16:0] ul17FBReadAddress; 
    logic [23:0] ul24FBReadData;
    
    // Frame buffer
    tMFrameBuffer_320x240 iMFrameBuffer_320x240 
    (
        .piul1WriteClock    (pIFrameIn.ul1Clock),
        .piul1ReadClock     (pIVgaOut.ul1Clock),
        .piul1WriteEnable   (1'b0),
        .piul17WriteAddress ('b0),
        .piul24WriteData    ('b0),
        .piul17ReadAddress  (ul17FBReadAddress),
        .poul24ReadData     (ul24FBReadData)
    );
    
    assign pIVgaOut.ul1Sync_n = 1'b0;
    
    assign pIVgaOut.ul1Blank_n = 1'b1;
    
    assign pIVgaOut.ul1PixelClock = pIVgaOut.ul1Clock;
    
    assign pIFrameIn.ul1Ready = 1'b0; 
    
    // RGB output
    assign pIVgaOut.ul8Red = ul24FBReadData[23:16];
    assign pIVgaOut.ul8Green = ul24FBReadData[15:8];
    assign pIVgaOut.ul8Blue = ul24FBReadData[7:0];
    
    // Pixel output control process
    always_ff @ (posedge pIVgaOut.ul1Clock)
    begin: p_pixel_output_ctrl
        if (pIVgaOut.ul1Reset_n == 1'b0)
        begin
            ul17FBReadAddress <= 'b0;
        end
        else
        begin
            if (ul1HSyncDisplayActive == 1'b1 && ul1VSyncDisplayActive == 1'b1)
            begin
                ul17FBReadAddress <= ul17FBReadAddress + 1'b1;
            end
        end
    end: p_pixel_output_ctrl
    
    // Horizontal synchronization control process
    always_ff @ (posedge pIVgaOut.ul1Clock) 
    begin: p_horizontal_sync_ctrl
        if (pIVgaOut.ul1Reset_n == 1'b0) 
        begin
            ul10HSyncClockCounter <= 'b0;
            eHSyncState <= HSYNC_STATE_SYNC;
        end
        else 
        begin
            
            ul10HSyncClockCounter <= ul10HSyncClockCounter + 1'b1;
            
            pIVgaOut.ul1HSync <= 1'b1;
            
            ul1HSyncDisplayActive <= 1'b0;
            
            ul1EndOfLine <= 1'b0;
            
            unique case (eHSyncState)
            
                HSYNC_STATE_SYNC:
                begin
                    pIVgaOut.ul1HSync <= 1'b0;
                    if (ul10HSyncClockCounter == cul10HSyncDurationCC)
                    begin
                        eHSyncState <= HSYNC_STATE_BACKPORCH;
                    end 
                end
                
                HSYNC_STATE_BACKPORCH:
                begin
                    if (ul10HSyncClockCounter == cul10HBackPorchDurationCC)
                    begin
                        eHSyncState <= HSYNC_STATE_DISPLAY;
                    end    
                end
                
                HSYNC_STATE_DISPLAY:
                begin
                    ul1HSyncDisplayActive <= 1'b1;
                    if (ul10HSyncClockCounter == cul10HDisplayDurationCC)
                    begin
                        eHSyncState <= HSYNC_STATE_FRONTPORCH;
                    end                      
                end
                
                HSYNC_STATE_FRONTPORCH:
                begin
                    if (ul10HSyncClockCounter == cul10HFrontPorchDurationCC)
                    begin
                        ul1EndOfLine <= 1'b1;
                        ul10HSyncClockCounter <= 'b0;
                        eHSyncState <= HSYNC_STATE_SYNC;
                    end
                end
            endcase
        end
    end: p_horizontal_sync_ctrl
    
    // Vertical synchronization control process
    always_ff @ (posedge pIVgaOut.ul1Clock) 
    begin: p_vertical_sync_ctrl
        if (pIVgaOut.ul1Reset_n == 1'b0) 
        begin
            ul10VSyncLineCounter <= 'b0;
            eVSyncState <= VSYNC_STATE_SYNC;
        end
        else 
        begin
        
            if (ul1EndOfLine == 1'b1)
            begin
                ul10VSyncLineCounter <= ul10VSyncLineCounter + 1'b1;
            end
            
            pIVgaOut.ul1VSync <= 1'b1;
            
            ul1VSyncDisplayActive <= 1'b0;
            
            unique case (eVSyncState)
            
                VSYNC_STATE_SYNC:
                begin
                    pIVgaOut.ul1VSync <= 1'b0;
                    if (ul10VSyncLineCounter == cul10VSyncDurationLC)
                    begin
                        eVSyncState <= VSYNC_STATE_BACKPORCH;
                    end 
                end
                
                VSYNC_STATE_BACKPORCH:
                begin
                    if (ul10VSyncLineCounter == cul10VBackPorchDurationLC)
                    begin
                        eVSyncState <= VSYNC_STATE_DISPLAY;
                    end 
                end
                
                VSYNC_STATE_DISPLAY:
                begin
                    ul1VSyncDisplayActive <= 1'b1;
                    if (ul10VSyncLineCounter == cul10VDisplayDurationLC)
                    begin
                        eVSyncState <= VSYNC_STATE_FRONTPORCH;
                    end
                end
                
                VSYNC_STATE_FRONTPORCH:
                begin
                    if (ul10VSyncLineCounter == cul10VFrontPorchDurationLC)
                    begin
                        ul10VSyncLineCounter <= 'b0;
                        eVSyncState <= VSYNC_STATE_SYNC;
                    end
                end
            endcase
        end
    end: p_vertical_sync_ctrl

endmodule : tMVgaDriver

`endif//M_VGADRIVER_SV
