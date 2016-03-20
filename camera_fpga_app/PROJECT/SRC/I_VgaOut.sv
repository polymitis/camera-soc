// Project   : VGA 
// Details   : VGA out interface.
`ifndef I_VGAOUT_SV
`define I_VGAOUT_SV

// VGA out interface
interface tIVgaOut 
( // Clocks:
  input logic ul1Clock,
  input logic ul1Reset_n
);
    logic [7:0] ul8Red;         // VGA Red
    logic [7:0] ul8Green;       // VGA Green
    logic [7:0] ul8Blue;        // VGA Blue
    logic       ul1PixelClock;  // VGA Clock
    logic       ul1Blank_n;     // 
    logic       ul1Sync_n;      // 
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
        
endinterface : tIVgaOut

`endif//I_VGAOUT_SV
