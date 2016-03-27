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
    
    typedef enum logic [3:0]
    {
        HSYNC_STATE_SYNC        = 4'b0001,
        HSYNC_STATE_BACKPORCH   = 4'b0010,
        HSYNC_STATE_DISPLAY     = 4'b0100,
        HSYNC_STATE_FRONTPORCH  = 4'b1000
        
    } teHSyncState;
    
    typedef enum logic [3:0]
    {
        VSYNC_STATE_SYNC        = 4'b0001,
        VSYNC_STATE_BACKPORCH   = 4'b0010,
        VSYNC_STATE_DISPLAY     = 4'b0100,
        VSYNC_STATE_FRONTPORCH  = 4'b1000
        
    } teVSyncState;
    
    teHSyncState eHSyncState;
    teVSyncState eVSyncState;
    
    logic [9:0]      ul10HSyncClockCounter;
    logic [9:0]      ul10VSyncLineCounter;
    
    logic            ul1HSyncDisplayActive;
    logic            ul1VSyncDisplayActive;
    
    logic            ul1EndOfLine;
    
    logic [18:0]     ul19PixelAddr;
    logic [16:0]     ul17PixelAddr; 
    logic [2:0][3:0] ul12RgbOut;
    
    // Frame buffer   
    tMFrameBuffer_320x240 iMFrameBuffer_320x240 
    (
        .piul1WClock  (pIFrameIn.ul1Clock),
        .piul1RClock  (pIVgaOut.ul1Clock),
        .piul1WEnable (1'b0),
        .piul17WAddr  (17'b0),
        .piul12WData  (12'b0),
        .piul17RAddr  (ul17PixelAddr),
        .poul12RData  (ul12RgbOut)
    );
    
    // Select pixel in sub-frame buffer.
    //
    // @param [in]  piul19PixelAddr is the pixel address in 640x480 resolution.
    // @param [out] poul4FrameBufferI is the sub-frame buffer index.
    // @param [out] poul17PixelAddr is the sub-frame buffer pixel address.
    function automatic void SelectPixelInSubFrameBuffer(
        input  logic [18:0] piul19PixelAddr,
        output logic [16:0] poul17PixelAddr);
        
        logic [18:0] ul19Address = 19'b0;
        logic [8:0] ul19HAdjAddress = 9'b0;
        logic [8:0] ul19VAdjAddress = 9'b0;
        
        ul19Address = piul19PixelAddr;
        // horizontal adjustment
        ul9HAdjAddress = piul19PixelAddr(2:0);
        // vertical adjustment
        ul9VAdjAddress = (ul19HAdjAddress >> 4) + piul19PixelAddr(0);
        poul17PixelAddr = ul19Address[16:0];
        
    endfunction : SelectPixelInSubFrameBuffer

    always_ff @ (posedge pIFrameIn.ul1Clock)
    begin: p_frame_bus_ctrl
        if (pIFrameIn.ul1Reset_n == 1'b0)
        begin
            pIFrameIn.ul1Ready <= 1'b0;
        end
        else
        begin
            pIFrameIn.ul1Ready <= 1'b0;
        end 
    end: p_frame_bus_ctrl
    
    // Display output
    always_comb
    begin: p_display_output
        // select output pixel in sub-frame buffers 
        SelectPixelInSubFrameBuffer(ul19PixelAddr,ul17PixelAddr);
        
        pIVgaOut.ul1Sync_n = 1'b1; // always in sync
        pIVgaOut.ul1PixelClock = pIVgaOut.ul1Clock; // pass the pll clock to the pixel clock
        
        // RGB output
        pIVgaOut.ul8Red   = {ul12RgbOut[2], 4'hF};
        pIVgaOut.ul8Green = {ul12RgbOut[1], 4'hF};
        pIVgaOut.ul8Blue  = {ul12RgbOut[0], 4'hF};
    end: p_display_output
    
    // Display output control 
    always_ff @ (posedge pIVgaOut.ul1Clock)
    begin: p_display_output_ctrl
        if (pIVgaOut.ul1Reset_n == 1'b0)
        begin
            ul19PixelAddr <= 'b0;
        end
        else
        begin
            pIVgaOut.ul1Blank_n <= 1'b1;
            if (ul1HSyncDisplayActive == 1'b1 && ul1VSyncDisplayActive == 1'b1)
            begin
                pIVgaOut.ul1Blank_n <= 1'b0;
                ul19PixelAddr <= ul19PixelAddr + 1'b1;
            end
        end
    end: p_display_output_ctrl
    
    // Horizontal synchronization control 
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
                        ul10HSyncClockCounter <= 'b0;
                        eHSyncState <= HSYNC_STATE_BACKPORCH;
                    end 
                end
                
                HSYNC_STATE_BACKPORCH:
                begin
                    if (ul10HSyncClockCounter == cul10HBackPorchDurationCC)
                    begin
                        ul10HSyncClockCounter <= 'b0;
                        eHSyncState <= HSYNC_STATE_DISPLAY;
                    end    
                end
                
                HSYNC_STATE_DISPLAY:
                begin
                    ul1HSyncDisplayActive <= 1'b1;
                    if (ul10HSyncClockCounter == cul10HDisplayDurationCC)
                    begin
                        ul10HSyncClockCounter <= 'b0;
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
    
    // Vertical synchronization control 
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
                        ul10VSyncLineCounter <= 'b0;
                        eVSyncState <= VSYNC_STATE_BACKPORCH;
                    end 
                end
                
                VSYNC_STATE_BACKPORCH:
                begin
                    if (ul10VSyncLineCounter == cul10VBackPorchDurationLC)
                    begin
                        ul10VSyncLineCounter <= 'b0;
                        eVSyncState <= VSYNC_STATE_DISPLAY;
                    end 
                end
                
                VSYNC_STATE_DISPLAY:
                begin
                    ul1VSyncDisplayActive <= 1'b1;
                    if (ul10VSyncLineCounter == cul10VDisplayDurationLC)
                    begin
                        ul10VSyncLineCounter <= 'b0;
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
