// Project   : camera_fpga_app
// Details   : Top module for Terasic DE1-SOC rev.D board.
`ifndef M_CAMERAFPGA_SV
`define M_CAMERAFPGA_SV

`include "M_TRDB_D5M_Driver.sv"
`include "M_ADV7123_Driver.sv"
`include "I_ImageTransfer.sv"

module tMCameraFpga (
    input logic         piul1FpgaClock,
    input logic         piul1FpgaResetN,
    tITRDB_D5M.driver   pIImageSensor,
    tIADV7123.driver    pIDisplay
    ); 

    tIImageTransfer iIImageTransfer (
        .ul1Clock(piul1FpgaClock)
        );
    
    tMTRDB_D5M_Driver iMTRDB_D5M_Driver (
        .ul1Clock           (piul1FpgaClock),
        .ul1ResetN          (piul1FpgaResetN),
        .pIDriver           (pIImageSensor),
        .pIImageTransfer    (iIImageTransfer)
        );
    
    tMADV7123_Driver iMADV7123_Driver (
        .ul1Clock           (piul1FpgaClock),
        .ul1ResetN          (piul1FpgaResetN),
        .pIDriver           (pIDisplay),
        .pIImageTransfer    (iIImageTransfer)
        );

endmodule

`endif//M_CAMERAFPGA_SV
