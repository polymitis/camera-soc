// Project   : Terasic TRDB_D5M daughter board
// Details   : TRDB_D5M driver.
`ifndef M_TRDB_D5M_DRIVER_SV
`define M_TRDB_D5M_DRIVER_SV

`include "I_TRDB_D5M.sv"
`include "I_FrameTransfer.sv"

module tMTRDB_D5M_Driver 
( // Ports:
    tITRDB_D5M.driver       pISensor,
    tIFrameTransfer.src     pIFrameOut
);  
    
    

endmodule : tMTRDB_D5M_Driver

`endif//M_TRDB_D5M_DRIVER_SV
