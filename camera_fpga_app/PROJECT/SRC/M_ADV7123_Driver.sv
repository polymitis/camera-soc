// Project   : ADV7123 VGA DAC
// Details   : ADV7123 VGA DAC driver.
`ifndef M_ADV7123_DRIVER_SV
`define M_ADV7123_DRIVER_SV

`include "I_ADV7123.sv"
`include "I_ImageTransfer.sv"
`include "M_FrameBuffer_320x240.sv"

module tMADV7123_Driver 
( // Ports:
    input logic             ul1Clock,
    input logic             ul1Reset_n,
    tIADV7123.driver        pIDriver,
    tIImageTransfer.dest    pIImageTransfer
);  
    
    logic ul1FBWriteEnable;
    logic [16:0] ul17FBWriteAddress; 
    logic [23:0] ul24FBWriteData;
    logic [16:0] ul17FBReadAddress; 
    logic [23:0] ul24FBReadData;
    
    tMFrameBuffer_320x240 iMFrameBuffer_320x240 
    (
        .ul1Clock           (ul1Clock),
        .ul1WriteEnable     (ul1FBWriteEnable),
        .piul17WriteAddress (ul17FBWriteAddress),
        .piul24WriteData    (ul24FBWriteData),
        .piul17ReadAddress  (ul17FBReadAddress),
        .poul24ReadData     (ul24FBReadData)
    );

endmodule : tMADV7123_Driver

`endif//M_ADV7123_DRIVER_SV
