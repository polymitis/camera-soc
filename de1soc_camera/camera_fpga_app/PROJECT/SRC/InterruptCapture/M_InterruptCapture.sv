// Project   : Generic
// Details   : This component capture interrupt inputs and presents them as registers readable via Avalon Slave port.
`ifndef M_INTERRUPTCAPTURE_SV
`define M_INTERRUPTCAPTURE_SV

`timescale 1 ps / 1 ps
module tMInterruptCapture 
#(//Parameters:
    parameter int unsigned NUM_INTR = 32 // active high level interrupt is expected for the input of this capturer module
)(//Ports :
    input  wire        rsi_mem_reset_reset_n, // mem_reset.reset_n
    input  wire        avs_mem_address,       //       mem.address
    input  wire        avs_mem_read,          //          .read
    output wire [31:0] avs_mem_readdata,      //          .readdata
    input  wire        csi_mem_clock_clock,   // mem_clock.clk
    input  wire [31:0] irn_interrupt_irq      // interrupt.irq
);

  logic [NUM_INTR-1:0] ulvInterruptReg;
  logic [31:0]         ul32ReaddataWithWaitstate;
  logic [31:0]         ul32ActReaddata;
  logic [31:0]         ul32ReaddataLowerIrq;
  logic [31:0]         ul32ReaddataHigherIrq;
  logic                ul1AccessLower32;
  logic                ul1AccessHigher32;

  generate if (NUM_INTR > 32) 
  begin : two_intr_reg_needed
        assign ul1AccessHigher32     = avs_mem_read & (avs_mem_address == 1);
        
        assign ul32ReaddataLowerIrq  = ulvInterruptReg[31:0] & {(32){ul1AccessLower32}};
        
        assign ul32ReaddataHigherIrq = ulvInterruptReg[NUM_INTR-1:32] & {(NUM_INTR-32){ul1AccessHigher32}};
  end
  else 
  begin : only_1_reg
        assign ul32ReaddataLowerIrq  = ulvInterruptReg & {(NUM_INTR){ul1AccessLower32}};
        
        assign ul32ReaddataHigherIrq = {32{1'b0}};
  end
  endgenerate

  always_ff @(posedge csi_mem_clock_clock) 
  begin
    if (rsi_mem_reset_reset_n == 1'b0) 
    begin
        ulvInterruptReg <= 'b0;
    end
    else
    begin
        ulvInterruptReg <= irn_interrupt_irq;
    end
  end

  always_ff @(posedge csi_mem_clock_clock) 
  begin
    if (rsi_mem_reset_reset_n == 1'b0)
    begin
        ul32ReaddataWithWaitstate <= 32'b0;
    end
    else
    begin    
        ul32ReaddataWithWaitstate <= ul32ActReaddata;
    end
  end

  assign ul1AccessLower32 = avs_mem_read & (avs_mem_address == 0);
  
  assign ul32ActReaddata = ul32ReaddataLowerIrq | ul32ReaddataHigherIrq;
  
  assign avs_mem_readdata = ul32ReaddataWithWaitstate;
  
endmodule

`endif//M_INTERRUPTCAPTURE_SV
