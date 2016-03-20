// Project   : ADV7123 VGA DAC
// Details   : Frame 320x240 buffer.
`ifndef M_FRAMEBUFFER_320x240_SV
`define M_FRAMEBUFFER_320x240_SV

module tMFrameBuffer_320x240  
( // Ports:
    input  logic        piul1WriteClock,
    input  logic        piul1ReadClock,
    input  logic        piul1WriteEnable,
    input  logic [16:0] piul17WriteAddress, 
    input  logic [23:0] piul24WriteData, 
    input  logic [16:0] piul17ReadAddress, 
    output logic [23:0] poul24ReadData 
);

    (* ramstyle = "M10K, no_rw_check" *) logic [23:0] aul24RamBuffer[0:76799];
    
    // Memory initialisation
    initial
    begin: mem_init_proc
        $readmemh("FrameBuffer_320x240.meminit", aul24RamBuffer);
    end: mem_init_proc
    
    // Write control
    always_ff @ (posedge piul1WriteClock)
    begin: write_ctrl_proc
    
        if (piul1WriteEnable == 1'b1)
        begin
            aul24RamBuffer[piul17WriteAddress] <= piul24WriteData;
        end
        
    end: write_ctrl_proc
    
    // Read control
    always_ff @ (posedge piul1ReadClock)
    begin: read_ctrl_proc
        
        poul24ReadData <= aul24RamBuffer[piul17ReadAddress];
        
    end: read_ctrl_proc
    
endmodule : tMFrameBuffer_320x240

`endif//M_FRAMEBUFFER_320x240_SV
