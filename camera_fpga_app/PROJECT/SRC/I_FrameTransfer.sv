// Project   : FPGA Library\Image Processing
// Details   : Frame transfer interface.
`ifndef I_FRAMETRANSFER_SV
`define I_FRAMETRANSFER_SV

`include "P_ImageProcessing.sv"

// Image transfer interface
interface tIFrameTransfer(
    input logic ul1Clock,   // Common clock for synchronous trasfer
    input logic ul1Reset_n  // Common synchronous active-low reset
    );
    
    logic               ul1Active;          // Active-high when transfering frame.
    teMacroBlockType    eMacroBlockType;    // Type of macroblock being transfered.
    logic [23:0]        ul24Rgb24Data;      // RGB24 pixel color data.
    logic               ul1MacroBlockEnd;   // Active-high when last pixel color data of macroblock is transfered.
    logic               ul1Ready;           // Active-high when ready to receive frame
    
    modport src (
        input  ul1Clock,
        input  ul1Reset_n,
        output ul1Active,
        output eMacroBlockType,
        output ul24Rgb24Data,
        output ul1MacroBlockEnd,
        input  ul1Ready
        );
             
    modport dest (
        input  ul1Clock,
        input  ul1Reset_n, 
        input  ul1Active,
        input  eMacroBlockType,
        input  ul24Rgb24Data,
        input  ul1MacroBlockEnd,
        output ul1Ready
        ); 
    
endinterface : tIFrameTransfer

`endif//I_FRAMETRANSFER_SV