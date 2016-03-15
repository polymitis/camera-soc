// Project   : FPGA Library\Image Processing
// Details   : MacroBlock transfer interface.
`ifndef I_MACROBLOCKTRANSFER_SV
`define I_MACROBLOCKTRANSFER_SV

`include "P_ImageProcessing.sv"

// MacroBlock transfer interface
interface tIMacroBlockTransfer (
    input logic ul1Clock
    );
    
    logic               ul1EnTransfer;
    teMacroBlockType    eMacroBlockType;
    logic [23:0]        ul24Rgb24Data;

    modport src (
        output ul1EnTransfer,
        output eMacroblockType,
        output ul24Rgb24Data
        );
             
    modport dest (
        input ul1EnTransfer,
        input eMacroblockType,
        input ul24Rgb24Data
        ); 
    
endinterface//MacroBlockTransfer

`endif//I_CAMERAFPGA_SV