// Project   : Camera FPGA
// Details   : Camera FPGA interface.
`ifndef I_CAMERAFPGA_SV
`define I_CAMERAFPGA_SV

// CameraFpga interface
interface tICameraFpga;

    logic       piul1FpgaClock;
    logic       piul1FpgaResetN;

    modport device (
        input               piul1FpgaClock,
        input               piul1FpgaResetN,
        tITRDB_D5M.driver   pIImageSensor,
        tIADV7123.driver    pIDisplay
        );
             
    modport driver (
        output              piul1FpgaClock,
        output              piul1FpgaResetN,
        tITRDB_D5M.device   pIImageSensor,
        tIADV7123.device    pIDisplay
        ); 
        
endinterface//CameraFpga

`endif//I_CAMERAFPGA_SV
