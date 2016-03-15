// Project   : ADV7123 VGA DAC
// Details   : ADV7123 VGA DAC driver.
`ifndef ADV7123_DRIVER_SV
`define ADV7123_DRIVER_SV

`include "I_ADV7123.sv"
`include "I_ImageTransfer.sv"

module tMADV7123_Driver (
    input logic             ul1Clock,
    input logic             ul1ResetN,
    tIADV7123.driver        pIDriver,
    tIImageTransfer.dest    pIImageTransfer
    );  
    
    

endmodule

`endif//M_ADV7123_DRIVER_SV