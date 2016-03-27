// Project   : camera_fpga_app
// Details   : PLL wrapper.
`ifndef M_PLL_SV
`define M_PLL_SV

`include "PLL/PLL.v"

module tMPLL
( // Ports:
    input  logic    piul1RefClock,
    input  logic    piul1Reset_n,
    output logic    poul1ClockOut,
    output logic    poul1Locked
);  
    
    PLL iPLL (
        .refclk     (piul1RefClock),
        .rst        (piul1Reset_n),
        .outclk_0   (poul1ClockOut),
        .locked     (poul1Locked)
        ); 

endmodule : tMPLL

`endif//M_PLL_SV