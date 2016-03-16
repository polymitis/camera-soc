// Project   : Terasic TRDB_D5M daughter board
// Details   : TRDB_D5M driver.
`ifndef M_TRDB_D5M_DRIVER_SV
`define M_TRDB_D5M_DRIVER_SV

`include "I_TRDB_D5M.sv"
`include "I_FrameTransfer.sv"

module tMTRDB_D5M_Driver 
( // Ports:
    input logic             piul1Clock,
    input logic             piul1Reset_n,
    tITRDB_D5M.driver       pIDriver,
    tIFrameTransfer.src     pIFrameTransfer
);  
    
    

endmodule : tMTRDB_D5M_Driver

`endif//M_TRDB_D5M_DRIVER_SV
