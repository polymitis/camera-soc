// Project   : camera_fpga_app
// Details   : HPSReset wrapper.
`ifndef M_HPSRESET_SV
`define M_HPSRESET_SV

`ifdef BUILD_SCRIPT

`include "HPSReset/HPSReset.v"

`endif

module tMHPSReset
( // Ports:
    input  logic       piul1Probe,
    input  logic       piul1SourceClock,
    output logic [2:0] poul3Source
);  
    
    HPSReset iHPSReset (
        .probe      (piul1Probe),
        .source_clk (piul1SourceClock),
        .source     (poul3Source)
        ); 

endmodule : tMHPSReset

`endif//M_HPSRESET_SV