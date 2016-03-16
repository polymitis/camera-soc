// Project   : FPGA Library\Image Processing
// Details   : Image transfer interface.
`ifndef I_IMAGETRANSFER_SV
`define I_IMAGETRANSFER_SV

`include "P_ImageProcessing.sv"

// Image transfer interface
interface tIImageTransfer(
    input logic ul1Clock // Common clock for synchronous trasfer
    );
    
    logic               ul1Active;          // Active-high when transfering image.
    teMacroBlockType    eMacroBlockType;    // Type of macroblock being transfered.
    logic [23:0]        ul24Rgb24Data;      // RGB24 pixel color data.
    logic               ul1MacroBlockEnd;   // Active-high when last pixel color data of macroblock is transfered.

    modport src (
        output ul1Active,
        output eMacroBlockType,
        output ul24Rgb24Data,
        output ul1MacroBlockEnd
        );
             
    modport dest (
        input ul1Active,
        input eMacroBlockType,
        input ul24Rgb24Data,
        input ul1MacroBlockEnd
        ); 
    
endinterface : tIImageTransfer

`endif//I_IMAGETRANSFER_SV