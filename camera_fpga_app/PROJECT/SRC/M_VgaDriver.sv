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
    
    logic [9:0]      ul10HSyncClockCounter;
    logic [9:0]      ul10VSyncLineCounter;
    
    logic            ul1HSyncDisplayActive;
    logic            ul1VSyncDisplayActive;
    
    logic            ul1EndOfLine;
    
    logic [18:0]     ul19PixelAddr;
    logic [1:0]      ul2FrameBufferI;
    logic [17:0]     ul17PixelAddr; 
    logic [2:0][3:0] ul12RgbOut[4];
    
    // Frame buffer
    genvar gvI;
    generate for (gvI = 0; gvI <= 3; gvI = gvI + 1)
    begin: g_sub_frame_buffer
        
        tMFrameBuffer_320x240 iMFrameBuffer_320x240 
        (
            .piul1WClock  (pIFrameIn.ul1Clock),
            .piul1RClock  (pIVgaOut.ul1Clock),
            .piul1WEnable (1'b0),
            .piul17WAddr  ('b0),
            .piul12WData  ('b0),
            .piul17RAddr  (ul17PixelAddr),
            .poul12RData  (ul12RgbOut[gvI])
        );
        
    end: g_sub_frame_buffer
    endgenerate
    
    // Select pixel in sub-frame buffer.
    //
    // There are 4 subframes encoded as:
    //
    //        0px    320px  640px
    //            -----------
    //            | 00 | 01 |
    //  153600px  |----|----|
    //            | 10 | 11 |
    //  307200px  -----------
    //
    // @param [in]  piul19PixelAddr is the pixel address in 640x480 resolution.
    // @param [out] poul4FrameBufferI is the sub-frame buffer index.
    // @param [out] poul17PixelAddr is the sub-frame buffer pixel address.
    function automatic void SelectPixelInSubFrameBuffer(
        input  logic [18:0] piul19PixelAddr,
        output logic [1:0]  poul2FrameBufferI,
        output logic [17:0] poul17PixelAddr);
        
        logic [18:0] ul19Address = piul19PixelAddr;
        
        poul2FrameBufferI = 2'b00; 
        if (piul19PixelAddr > 153599)
        begin
            poul2FrameBufferI[1] = 1'b1;
            ul19Address = ul19Address - 19'd153599;
        end 
        if (piul19PixelAddr[9:0] > 319)
        begin
            poul2FrameBufferI[0] = 1'b1; 
            ul19Address = ul19Address - 19'd320;
        end
        
        poul17PixelAddr = ul19Address[17:0];
        
    endfunction

    assign pIFrameIn.ul1Ready = 1'b0; // DEBUG
    
    // Display output
    always_comb
    begin: p_display_output
        // select output pixel in sub-frame buffers 
        SelectPixelInSubFrameBuffer(ul19PixelAddr,ul2FrameBufferI,ul17PixelAddr);
        
        pIVgaOut.ul1Sync_n = 1'b1; // always in sync
        pIVgaOut.ul1PixelClock = pIVgaOut.ul1Clock; // pass the pll clock to the pixel clock
        
        // RGB output
        pIVgaOut.ul8Red   = {ul12RgbOut[ul2FrameBufferI][2], 4'hF};
        pIVgaOut.ul8Green = {ul12RgbOut[ul2FrameBufferI][1], 4'hF};
        pIVgaOut.ul8Blue  = {ul12RgbOut[ul2FrameBufferI][0], 4'hF};
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
