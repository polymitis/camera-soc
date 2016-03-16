// Project   : Terasic TRDB_D5M daughter board
// Details   : TRDB_D5M driver.
`ifndef M_TRDB_D5M_DRIVER_SV
`define M_TRDB_D5M_DRIVER_SV

`include "I_TRDB_D5M.sv"
`include "I_ImageTransfer.sv"

module tMTRDB_D5M_Driver 
( // Ports:
    input logic             ul1Clock,
    input logic             ul1Reset_n,
    tITRDB_D5M.driver       pIDriver,
    tIImageTransfer.src     pIImageTransfer
);  
    
    

endmodule : tMTRDB_D5M_Driver

`endif//M_TRDB_D5M_DRIVER_SV
