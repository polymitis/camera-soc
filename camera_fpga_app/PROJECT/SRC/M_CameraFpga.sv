// Project   : camera_fpga_app
// Details   : Top module for Terasic DE1-SOC rev.D board.
`ifndef M_CAMERAFPGA_SV
`define M_CAMERAFPGA_SV

`include "M_TRDB_D5M_Driver.sv"
`include "M_VgaDriver.sv"
`include "I_ImageTransfer.sv"

module tMCameraFpga 
( // Ports:
    input logic         piul1FpgaClock,
    input logic         piul1FpgaReset_n,
    tITRDB_D5M.driver   pIImageSensor,
    tIVgaDriver.driver  pIDisplayOut
); 

    logic ul1PixelClock;

    tIFrameTransfer iIFrameTransfer (
        .ul1Clock(piul1FpgaClock)
        );
    
    tMTRDB_D5M_Driver iMTRDB_D5M_Driver (
        .piul1Clock         (piul1FpgaClock),
        .piul1Reset_n       (piul1FpgaReset_n),
        .piul1PixelClock    (ul1PixelClock),
        .pIDriver           (pIImageSensor),
        .pIImageTransfer    (iIFrameTransfer)
        );
    
    tMVgaDriver iMVgaDriver (
        .piul1Clock         (piul1FpgaClock),
        .piul1Reset_n       (piul1FpgaReset_n),
        .pIDriver           (pIDisplayOut),
        .pIImageTransfer    (iIFrameTransfer)
        );

endmodule : tMCameraFpga

`endif//M_CAMERAFPGA_SV
