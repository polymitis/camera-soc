// Project   : FPGA Library\Image Processing
// Details   : Image Processing package.
`ifndef P_IMAGEPROCESSING_SV
`define P_IMAGEPROCESSING_SV

package tPImageProcessing;

    typedef enum logic [1:0]
    {
        MBLK64X64 = 2'b01,
        MBLK32X32 = 2'b10,
        MBLK16X16 = 2'b11
    } teMacroBlockType;

endpackage : tPImageProcessing

import tPImageProcessing::*;

`endif//P_IMAGEPROCESSING_SV
