// Project   : Generic
// Details   : Edge detection.
// Modified from Terasic DE1-SOC GHRD altera_edge_detector.v 
`ifndef M_EDGEDETECT_SV
`define M_EDGEDETECT_SV

module tMEdgeDetect
#( // Parameters
    parameter int unsigned PULSE_EXT = 0,             // 0, 1 = edge detection generate single cycle pulse, >1 = pulse extended for specified clock cycle
    parameter int unsigned EDGE_TYPE = 0,             // 0 = falling edge, 1 or else = rising edge
    parameter int unsigned IGNORE_RST_WHILE_BUSY = 0  // 0 = module internal reset will be default whenever ul1Reset_n asserted, 1 = ul1Reset_n request will be ignored while generating pulse out
) (// Ports
    input  logic ul1Clock,
    input  logic ul1Reset_n,
    input  logic ul1SignalIn,
    output logic ul1PulseOut
);

    localparam logic SIGNAL_ASSERT   = EDGE_TYPE ? 1'b1 : 1'b0;
    localparam logic SIGNAL_DEASSERT = EDGE_TYPE ? 1'b0 : 1'b1;

    logic ul1PulseDetect;
    logic ul1BusyPulsing;
    logic ul1ResetEqual_n;
    
    typedef enum logic [3:0]
    {
        STATE_IDLE    = 4'b001,
        STATE_ARM     = 4'b010,
        STATE_CAPTURE = 4'b100
        
    } teState;
    
    teState eState = STATE_IDLE;

    assign ul1BusyPulsing = (IGNORE_RST_WHILE_BUSY)? ul1PulseOut : 1'b0;
    assign ul1ResetEqual_n = ul1Reset_n | ul1BusyPulsing;

    generate if (PULSE_EXT > 1) 
    begin : g_pulse_extend
    
        integer i;
        
        logic [PULSE_EXT-1:0] ulvExtendPulse;
        
        always_ff @(posedge ul1Clock) 
        begin : p_extend_pulse
            if (ul1ResetEqual_n == 1'b0)
                ulvExtendPulse <= {{PULSE_EXT}{1'b0}};
            else 
            begin
                for (i = 1; i < PULSE_EXT; i = i+1) begin
                    ulvExtendPulse[i] <= ulvExtendPulse[i-1];
                end
                ulvExtendPulse[0] <= ul1PulseDetect;
            end
        end : p_extend_pulse
        
        assign ul1PulseOut = |ulvExtendPulse;
    end
    else 
    begin : g_single_pulse
    
        logic ul1PulseReg;
        
        always_ff @(posedge ul1Clock) 
        begin : p_pulse_register
            if (!ul1ResetEqual_n)
            begin
                ul1PulseReg <= 1'b0;
            end
            else
            begin
                ul1PulseReg <= ul1PulseDetect;
            end
        end : p_pulse_register
        
        assign ul1PulseOut = ul1PulseReg;
    
    end
    endgenerate

    // Edge detection controller
    always_ff @(posedge ul1Clock) 
    begin : p_edge_detection_ctrl
        if (ul1ResetEqual_n == 1'b0) 
        begin
            ul1PulseDetect <= 1'b0;
            eState <= STATE_IDLE;
        end
        else
        begin
            ul1PulseDetect <= 1'b0;
            unique case (eState)
                STATE_IDLE : 
                begin
                    ul1PulseDetect <= 1'b0;
                    if (ul1SignalIn == SIGNAL_DEASSERT)
                    begin                    
                        eState <= STATE_ARM;
                    end
                end
                
                STATE_ARM : 
                begin
                    ul1PulseDetect <= 1'b0;
                    if (ul1SignalIn == SIGNAL_ASSERT) 
                    begin
                        eState <= STATE_CAPTURE;
                    end
                end
                
                STATE_CAPTURE : 
                begin
                    ul1PulseDetect <= 1'b1;
                    eState <= (ul1SignalIn == SIGNAL_DEASSERT) ? STATE_ARM : STATE_IDLE;
                end
            endcase
        end
    end : p_edge_detection_ctrl

endmodule : tMEdgeDetect

`endif//M_EDGEDETECT_SV
