// Project   : VGA 
// Details   : VGA out interface.
`ifndef I_VGAOUT_SV
`define I_VGAOUT_SV

// VGA out interface
interface tIVgaOut 
( // Clocks:
  input logic ul1Clock // External clock for vga output (frequency depends on VGA specification)
);
    logic       ul1Reset_n;     // Synchronous active-low reset
    logic [7:0] ul8Red;         // VGA Red
    logic [7:0] ul8Green;       // VGA Green
    logic [7:0] ul8Blue;        // VGA Blue
    logic       ul1PixelClock;  // VGA Clock
    logic       ul1Blank_n;     // Blank screen
    logic       ul1Sync_n;      // Sync 
    logic       ul1HSync;       // VGA Horizontal synchronization
    logic       ul1VSync;       // VGA Vertical synchronization  
          
    modport conx (
        output ul8Red,
        output ul8Green,
        output ul8Blue,
        output ul1PixelClock,
        output ul1Blank_n,
        output ul1Sync_n,
        output ul1HSync,
        output ul1VSync
        );
    
    modport driver (
        input  ul1Clock, 
        input  ul1Reset_n,
        output ul8Red,
        output ul8Green,
        output ul8Blue,
        output ul1PixelClock,
        output ul1Blank_n,
        output ul1Sync_n,
        output ul1HSync,
        output ul1VSync
        );

`ifdef TEST

    clocking cb @ (posedge ul1Clock);
        output ul1Reset_n;
        input  ul8Red;
        input  ul8Green;
        input  ul8Blue;
        input  ul1PixelClock;
        input  ul1Blank_n;
        input  ul1Sync_n;
        input  ul1HSync;
        input  ul1VSync;
    endclocking
    
    modport t_driver (clocking cb);

`endif
        
endinterface : tIVgaOut

`endif//I_VGAOUT_SV
