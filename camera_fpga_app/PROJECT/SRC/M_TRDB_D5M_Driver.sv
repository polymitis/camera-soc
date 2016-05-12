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

    assign pISensor.ul1ExtClockInput = 1'b0;
    assign pISensor.ul1Resetn = 1'b0;
    assign pISensor.ul1SnapshotTrigger = 1'b0;

    assign pISensor.ul1SdaOut = 1'b0; 
    assign pISensor.ul1SdaOEn = 1'b0;
    assign pISensor.ul1Scl = 1'b0;
    
    assign pIFrameOut.ul1Reset_n = pISensor.ul1Reset_n;
    assign pIFrameOut.ul1Active = 1'b0;
    assign pIFrameOut.eMacroBlockType = MBLK16X16;
    assign pIFrameOut.ul24Rgb24Data = 'b0;
    assign pIFrameOut.ul1MacroBlockEnd = 1'b0;
    

endmodule : tMTRDB_D5M_Driver

`endif//M_TRDB_D5M_DRIVER_SV
