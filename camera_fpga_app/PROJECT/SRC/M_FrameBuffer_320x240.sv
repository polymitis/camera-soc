// Project   : ADV7123 VGA DAC
// Details   : Frame 320x240 buffer.
`ifndef M_FRAMEBUFFER_320x240_SV
`define M_FRAMEBUFFER_320x240_SV

module tMFrameBuffer_320x240  
( // Ports:
    input  logic piul1Clock,
    input  logic piul1WriteEnable,
    input  logic [16:0] piul17WriteAddress, 
    input  logic [23:0] piul24WriteData, 
    input  logic [16:0] piul17ReadAddress, 
    output logic [23:0] poul24ReadData 
);

    (* ramstyle = "M10K, no_rw_check" *) logic [23:0] aul24RamBuffer[0:76799];
    
    initial
    begin: RAM_initialisation_proc
        $readmemh("FrameBuffer_320x240.meminit", aul24RamBuffer);
    end: RAM_initialisation_proc
    
    always_ff @ (posedge ul1Clock)
    begin: RAM_controller_proc
        if (ul1WriteEnable) 
            aul24RamBuffer[piul17WriteAddress] <= piul24WriteData;
        
        poul24ReadData <= aul24RamBuffer[piul17ReadAddress];
    end: RAM_controller_proc
    
endmodule : tMFrameBuffer_320x240

`endif//M_FRAMEBUFFER_320x240_SV
