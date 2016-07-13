// Project   : Camera FPGA
// Details   : VGA driver (60Hz, 640x480).
`ifndef M_VGADRIVER_SV
`define M_VGADRIVER_SV

`include "I_VgaOut.sv"
`include "I_DrawPoint.sv"
`include "M_FrameBuffer_320x240.sv"

module tMVgaDriver 
( // Ports:
    tIVgaOut.driver pIVgaOut,
    tIDrawPoint.slv pIDrawPoint
);

    const logic [9:0] cul10HSyncDurationCC       = 10'd96;  // 3.810 us
    const logic [9:0] cul10HBackPorchDurationCC  = 10'd48;  // 1.910 us
    const logic [9:0] cul10HDisplayDurationCC    = 10'd640; // 25.40 us
    const logic [9:0] cul10HFrontPorchDurationCC = 10'd16;  // 0.636 us
    
    const logic [9:0] cul10VSyncDurationLC       = 10'd2;
    const logic [9:0] cul10VBackPorchDurationLC  = 10'd33;
    const logic [9:0] cul10VDisplayDurationLC    = 10'd480;
    const logic [9:0] cul10VFrontPorchDurationLC = 10'd10;
    
    const logic [9:0] cul10HRes = 10'd640; 
    const logic [9:0] cul10VRes = 10'd480;
    const logic [18:0] cul19Res = cul10HRes * cul10VRes;
    
    const logic [9:0] cul10BufHRes = 10'd320; 
    const logic [9:0] cul10BufVRes = 10'd240;
    const logic [18:0] cul19BufRes = cul10BufHRes * cul10BufVRes;
    
    const logic [3:0] cul4ZoomFactor = 4'd2;
    
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
    
    teHSyncState eHSyncState = HSYNC_STATE_SYNC;
    teVSyncState eVSyncState = VSYNC_STATE_SYNC;
    
    logic [9:0]      ul10HSyncClockCounter;
    logic [9:0]      ul10VSyncLineCounter;
    
    logic            ul1HSyncDisplayActive;
    logic            ul1VSyncDisplayActive;
    
    logic            ul1EndOfLine;
    
    logic [18:0]     ul19PixelAddr;
    logic [16:0]     ul17PixelInAddr;
    logic [16:0]     ul17PixelOutAddr; 
    logic [2:0][3:0] ul12RgbOut;
    
    // Frame buffer 320x240 RGB12
    tMFrameBuffer_320x240 iMFrameBuffer_320x240 
    (
        .piul1WClock  (pIDrawPoint.ul1Clock),
        .piul1RClock  (pIVgaOut.ul1Clock),
        .piul1WEnable (pIDrawPoint.ul1Update),
        .piul17WAddr  (ul17PixelInAddr),
        .piul12WData  (pIDrawPoint.ul12Rgb12Data),
        .piul17RAddr  (ul17PixelOutAddr),
        .poul12RData  (ul12RgbOut)
    );
    
    // Convert [X,Y] point to pixel address in sub-frame buffer.
    // 
    // @param [in]  piul9PosX is the pixel horizontal position.
    // @param [in]  piul9PosY is the pixel vertical position.
    // @param [out] poul17PixelAddr is the sub-frame buffer pixel address in 320x240 resolution.
    function automatic void CovertPointToPixelAddressInSubFrameBuffer(
        input  logic [8:0] piul9PosX,
        input  logic [8:0] piul9PosY,
        output logic [16:0] poul17PixelAddr);
        
        // frame buffer pixel address 
        poul17PixelAddr = (piul9PosY * cul10BufHRes) + piul9PosY;
        
    endfunction : CovertPointToPixelAddressInSubFrameBuffer
    
    // Select pixel in sub-frame buffer.
    // 
    // @param [in]  piul19PixelAddr is the pixel address in 640x480 resolution.
    // @param [out] poul17PixelAddr is the sub-frame buffer pixel address in 320x240 resolution.
    function automatic void SelectPixelInSubFrameBuffer(
        input  logic [18:0] piul19PixelAddr,
        output logic [16:0] poul17PixelAddr);
        
        logic [18:0] ul19Address     = 19'b0;
        logic [18:0] ul19HAdjAddress = 19'b0;
        logic [18:0] ul19VAdjAddress = 19'b0;
        
        ul19Address = piul19PixelAddr;
        // horizontal adjustment
        ul19HAdjAddress = (ul19Address % cul10HRes) / cul4ZoomFactor; 
        // vertical adjustment
        ul19VAdjAddress = ul19Address / (cul4ZoomFactor * cul10HRes); 
        // sub-frame pixel address 
        poul17PixelAddr = (ul19VAdjAddress[8:0] * cul10BufHRes) + ul19HAdjAddress[8:0];
        
    endfunction : SelectPixelInSubFrameBuffer
    
    // Display input
    always_comb
    begin: p_display_input
        // convert [X,Y] point to pixel address in sub-frame buffer
        CovertPointToPixelAddressInSubFrameBuffer(pIDrawPoint.ul9PosX,pIDrawPoint.ul9PosY,ul17PixelInAddr);

    end: p_display_input
    
    // Display output
    always_comb
    begin: p_display_output
        // select output pixel in sub-frame buffers 
        SelectPixelInSubFrameBuffer(ul19PixelAddr,ul17PixelOutAddr);
        
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
            ul19PixelAddr <= 19'b0;
        end
        else
        begin
            pIVgaOut.ul1Blank_n <= 1'b0;
            
            if (ul19PixelAddr == cul19Res)
            begin
                ul19PixelAddr <= 19'b0;
            end
            else if (ul1HSyncDisplayActive == 1'b1 && ul1VSyncDisplayActive == 1'b1)
            begin
                pIVgaOut.ul1Blank_n <= 1'b1;
                ul19PixelAddr <= ul19PixelAddr + 1'd1;
            end
        end
    end: p_display_output_ctrl
    
    // Horizontal synchronization control 
    always_ff @ (posedge pIVgaOut.ul1Clock) 
    begin: p_horizontal_sync_ctrl
        if (pIVgaOut.ul1Reset_n == 1'b0) 
        begin
            ul10HSyncClockCounter <= 10'b0;            
            pIVgaOut.ul1HSync <= 1'b1;
            ul1HSyncDisplayActive <= 1'b0;
            ul1EndOfLine <= 1'b0;
            eHSyncState <= HSYNC_STATE_SYNC;
        end
        else 
        begin
            
            ul10HSyncClockCounter <= ul10HSyncClockCounter + 1'd1;
            
            pIVgaOut.ul1HSync <= 1'b1;
            
            ul1HSyncDisplayActive <= 1'b0;
            
            ul1EndOfLine <= 1'b0;
            
            unique case (eHSyncState)
            
                HSYNC_STATE_SYNC:
                begin
                    pIVgaOut.ul1HSync <= 1'b0;
                    if (ul10HSyncClockCounter == cul10HSyncDurationCC)
                    begin
                        ul10HSyncClockCounter <= 10'b0;
                        eHSyncState <= HSYNC_STATE_BACKPORCH;
                    end 
                end
                
                HSYNC_STATE_BACKPORCH:
                begin
                    if (ul10HSyncClockCounter == cul10HBackPorchDurationCC)
                    begin
                        ul10HSyncClockCounter <= 10'b0;
                        eHSyncState <= HSYNC_STATE_DISPLAY;
                    end    
                end
                
                HSYNC_STATE_DISPLAY:
                begin
                    ul1HSyncDisplayActive <= 1'b1;
                    if (ul10HSyncClockCounter == cul10HDisplayDurationCC-1)
                    begin
                        ul10HSyncClockCounter <= 10'b0;
                        eHSyncState <= HSYNC_STATE_FRONTPORCH;
                    end                      
                end
                
                HSYNC_STATE_FRONTPORCH:
                begin
                    if (ul10HSyncClockCounter == cul10HFrontPorchDurationCC)
                    begin
                        ul1EndOfLine <= 1'b1;
                        ul10HSyncClockCounter <= 10'b0;
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
            ul10VSyncLineCounter <= 10'b0;
            pIVgaOut.ul1VSync <= 1'b1;
            ul1VSyncDisplayActive <= 1'b0;
            eVSyncState <= VSYNC_STATE_SYNC;
        end
        else 
        begin
        
            if (ul1EndOfLine == 1'b1)
            begin
                ul10VSyncLineCounter <= ul10VSyncLineCounter + 1'd1;
            end
            
            pIVgaOut.ul1VSync <= 1'b1;
            
            ul1VSyncDisplayActive <= 1'b0;
            
            unique case (eVSyncState)
            
                VSYNC_STATE_SYNC:
                begin
                    pIVgaOut.ul1VSync <= 1'b0;
                    if (ul10VSyncLineCounter == cul10VSyncDurationLC)
                    begin
                        ul10VSyncLineCounter <= 10'b0;
                        eVSyncState <= VSYNC_STATE_BACKPORCH;
                    end 
                end
                
                VSYNC_STATE_BACKPORCH:
                begin
                    if (ul10VSyncLineCounter == cul10VBackPorchDurationLC)
                    begin
                        ul10VSyncLineCounter <= 10'b0;
                        eVSyncState <= VSYNC_STATE_DISPLAY;
                    end 
                end
                
                VSYNC_STATE_DISPLAY:
                begin
                    ul1VSyncDisplayActive <= 1'b1;
                    if (ul10VSyncLineCounter == cul10VDisplayDurationLC)
                    begin
                        ul10VSyncLineCounter <= 10'b0;
                        eVSyncState <= VSYNC_STATE_FRONTPORCH;
                    end
                end
                
                VSYNC_STATE_FRONTPORCH:
                begin
                    if (ul10VSyncLineCounter == cul10VFrontPorchDurationLC)
                    begin
                        ul10VSyncLineCounter <= 10'b0;
                        eVSyncState <= VSYNC_STATE_SYNC;
                    end
                end
            endcase
        end
    end: p_vertical_sync_ctrl

endmodule : tMVgaDriver

`endif//M_VGADRIVER_SV
