// Project   : ADV7123 VGA DAC
// Details   : Frame 320x240 buffer.
`ifndef M_FRAMEBUFFER_320x240_SV
`define M_FRAMEBUFFER_320x240_SV

module tMFrameBuffer_320x240  
( // Ports:
    input  logic            piul1WClock,
    input  logic            piul1RClock,
    input  logic            piul1WEnable,
    input  logic [16:0]     piul17WAddr, 
    input  logic [2:0][3:0] piul12WData, 
    input  logic [16:0]     piul17RAddr, 
    output logic [2:0][3:0] poul12RData 
);

    (* ramstyle = "M10K, no_rw_check" *) logic [2:0][3:0] aul12RgbBuffer[0:76799];
    
    // RGB buffer initialisation
    initial
    begin: mem_init_proc
        $readmemh("FrameBuffer_320x240.meminit", aul12RgbBuffer);
    end: mem_init_proc
    
    // Write control
    always_ff @ (posedge piul1WClock)
    begin: write_ctrl_proc
    
        if (piul1WEnable == 1'b1)
        begin
            aul12RgbBuffer[piul17WAddr] <= piul12WData;
        end
        
    end: write_ctrl_proc
    
    // Read control
    always_ff @ (posedge piul1RClock)
    begin: read_ctrl_proc
        
        poul12RData <= aul12RgbBuffer[piul17RAddr];
        
    end: read_ctrl_proc
    
endmodule : tMFrameBuffer_320x240

`endif//M_FRAMEBUFFER_320x240_SV
