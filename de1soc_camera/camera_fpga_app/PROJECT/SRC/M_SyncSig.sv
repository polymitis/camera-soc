// Project   : Generic
// Details   : Signal synchronization using a variable lenght shift register.
`ifndef M_SYNCSIG_SV
`define M_SYNCSIG_SV

module tMSyncSig
#(// Parameters
    parameter int unsigned SYNC_DELAY_CC = 2 // 2 clock cycles
)
( // Ports:
    input  logic piul1SyncClock,
    input  logic piul1SigIn,
    output logic poul1SigOut
);
    localparam int unsigned SR_BITS = SYNC_DELAY_CC + 1; // Synchronization register length
    
    logic [SR_BITS-1:0] ulvSyncReg;
    
    // Reset synchronization
    always_ff @ (posedge(piul1SyncClock))
    begin: p_sync
        ulvSyncReg[SR_BITS-1:1] <= ulvSyncReg[SR_BITS-2:0];
        ulvSyncReg[0] <= piul1SigIn;
    end: p_sync
    
    assign poul1SigOut = ulvSyncReg[SR_BITS-1];

endmodule : tMSyncSig

`endif//M_SYNCSIG_SV
