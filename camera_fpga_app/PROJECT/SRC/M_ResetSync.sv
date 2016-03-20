// Project   : Generic
// Details   : Reset synchronization with debouncing control.
`ifndef M_RESETSYNC_SV
`define M_RESETSYNC_SV

module tMResetSync 
#(// Parameters
    parameter int unsigned RESET_DELAY_CC = 50000 // 1 ms reset delay (for switch debouncing).
)
( // Ports:
    input  logic piul1Clock,
    input  logic piul1ResetIn,
    output logic poul1ResetOut
);
    
    logic        ul1ResetSync;
    logic [$clog2(RESET_DELAY_CC)-1:0] ulvResetDelayCCounter;
    
    typedef enum logic
    {
        RESET_STATE_WAIT = 1'b0,
        RESET_STATE_SYNC = 1'b1
        
    } teResetState;
    
    teResetState eResetState;
    
    // Reset synchronization
    always_ff @ (posedge(piul1Clock))
    begin: p_reset_sync
        
        unique case (eResetState)
        
        // Wait for system reset state change.   
        RESET_STATE_WAIT:
        begin
            if (poul1ResetOut != piul1ResetIn) 
            begin
                ul1ResetSync <= piul1ResetIn;
                ulvResetDelayCCounter <= 'b0;
                eResetState <= RESET_STATE_SYNC;
            end
        end
        
        // System reset state synchronization.
        RESET_STATE_SYNC:
        begin
            ulvResetDelayCCounter <= ulvResetDelayCCounter + 1'b1;
            if (ulvResetDelayCCounter == RESET_DELAY_CC)
            begin
                poul1ResetOut <= ul1ResetSync;
                eResetState <= RESET_STATE_WAIT;
            end
        end 
        endcase
    end: p_reset_sync

endmodule : tMResetSync

`endif//M_RESETSYNC_SV
