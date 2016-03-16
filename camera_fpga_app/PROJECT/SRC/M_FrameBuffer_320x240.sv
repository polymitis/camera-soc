// Project   : ADV7123 VGA DAC
// Details   : Frame 320x240 buffer.
`ifndef M_FRAMEBUFFER_320x240_SV
`define M_FRAMEBUFFER_320x240_SV

module tMFrameBuffer_320x240  
( // Ports:
    input  logic ul1Clock,
    input  logic ul1WriteEnable,
    input  logic [16:0] piul17WriteAddress, 
    input  logic [23:0] piul24WriteData, 
    input  logic [16:0] piul17ReadAddress, 
    output logic [23:0] poul24ReadData 
);

    (* ramstyle = "M10K, no_rw_check" *) logic [23:0] aul24RamBuffer[0:76799];
    
    initial
    begin
        $readmemh("FrameBuffer_320x240.meminit", aul24RamBuffer);
    end
    
    always_ff @ (posedge ul1Clock)
    begin
        if (ul1WriteEnable) 
            aul24RamBuffer[piul17WriteAddress] <= piul24WriteData;
        
        poul24ReadData <= aul24RamBuffer[piul17ReadAddress];
    end
    
endmodule : tMFrameBuffer_320x240

`endif//M_FRAMEBUFFER_320x240_SV
