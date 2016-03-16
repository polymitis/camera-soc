// Project   : VGA
// Details   : VGA driver (60Hz, 640x480).
`ifndef M_VGADRIVER_SV
`define M_VGADRIVER_SV

`include "I_VgaDriver.sv"
`include "I_ImageTransfer.sv"
`include "M_FrameBuffer_320x240.sv"

module tMVgaDriver 
( // Ports:
    input logic             piul1Clock,
    input logic             piul1Reset_n,
    input logic             piul1PixelClock,
    tIVgaDriver.driver      pIDisplayOut,
    tIFrameTransfer.dest    pIFrameIn
);
    const logic [9:0] ul10HSyncDurationCC = 96;
    const logic [9:0] ul10HBackPorchDurationCC = 48;
    const logic [9:0] ul10HDisplayDurationCC = 640;
    const logic [9:0] ul10HFrontPorchDurationCC = 15;

    typedef enum logic [3:0]
    {
        VGA_DRIVER_STATE_IDLE,
        VGA_DRIVER_STATE_VSYNC,
        VGA_DRIVER_STATE_VBACKPORCH,
        VGA_DRIVER_STATE_VDISPLAY,
        VGA_DRIVER_STATE_VFRONTPORCH,
        VGA_DRIVER_STATE_HSYNC,
        VGA_DRIVER_STATE_HBACKPORCH,
        VGA_DRIVER_STATE_HDISPLAY,
        VGA_DRIVER_STATE_HFRONTPORCH
    } teVgaDriverState;
    
    teVgaDriverState eVgaDriverState;
    
    logic [9:0] ul10VgaTimingDelayCounter;
    
    logic ul1FBWriteEnable;
    logic [16:0] ul17FBWriteAddress; 
    logic [23:0] ul24FBWriteData;
    logic [16:0] ul17FBReadAddress; 
    logic [23:0] ul24FBReadData;
    
    tMFrameBuffer_320x240 iMFrameBuffer_320x240 
    (
        .ul1Clock           (ul1Clock),
        .ul1WriteEnable     (ul1FBWriteEnable),
        .piul17WriteAddress (ul17FBWriteAddress),
        .piul24WriteData    (ul24FBWriteData),
        .piul17ReadAddress  (ul17FBReadAddress),
        .poul24ReadData     (ul24FBReadData)
    );
    
    always_ff @ (posedge ul1PixelClock) 
    begin: VGA_output_process
        if (ul1Reset_n == 1'b0) 
        begin: reset_logic
            ul10VgaTimingDelayCounter <= 'b0;
            eVgaDriverState <= VGA_DRIVER_STATE_IDLE;
        end: reset_logic
        else 
        begin: VGA_output_logic
            
            pIDisplayOut.ul1VgaHSync <= 1'b0;
            unique case (teVgaDriverState)
                VGA_DRIVER_STATE_IDLE:
                begin: IDLE_state_logic
                    
                end: IDLE_state_logic
                
                VGA_DRIVER_STATE_HSYNC:
                begin: horizontal_sync_logic
                    
                    pIDisplayOut.ul1VgaHSync <= 1'b1;
                    if (ul10VgaTimingDelayCounter == ul10HSyncDurationCC)
                        teVgaDriverState <= VGA_DRIVER_STATE_HBACKPORCH;
                        
                end: horizontal_sync_logic
                
                VGA_DRIVER_STATE_HBACKPORCH:
                begin: horizontal_back_porch_logic
                    
                    if (ul10VgaTimingDelayCounter == ul10HBackPorchDurationCC)
                        teVgaDriverState <= VGA_DRIVER_STATE_HDISPLAY;
                        
                end: horizontal_back_porch_logic
                
                VGA_DRIVER_STATE_HDISPLAY:
                begin: display_logic
                 
                    if (ul10VgaTimingDelayCounter == ul10HDisplayDurationCC)
                        teVgaDriverState <= VGA_DRIVER_STATE_HFRONTPORCH;
                        
                end: display_logic
                
                VGA_DRIVER_STATE_HFRONTPORCH:
                begin: horizontal_front_porch_logic
                    
                    if (ul10VgaTimingDelayCounter == ul10HFrontPorchDurationCC)
                        teVgaDriverState <= VGA_DRIVER_STATE_HSYNC;
                        
                end: horizontal_front_porch_logic
            endcase
        end: VGA_output_logic
    end: VGA_output_process

endmodule : tMVgaDriver

`endif//M_VGADRIVER_SV
