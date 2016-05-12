// Project   : Terasic TRDB_D5M daughter board
// Details   : TRDB_D5M interface.
`ifndef I_TRDB_D5M_SV
`define I_TRDB_D5M_SV

// TRDB_D5M interface
interface tITRDB_D5M
( // Ports:
    input logic ul1Clock,
    input logic ul1Reset_n
);

    logic        ul1PixelClock;
    logic [11:0] ul12PixelData;
    logic        ul1ExtClockInput;
    logic        ul1Resetn;
    logic        ul1SnapshotTrigger;
    logic        ul1SnapshotStrobe;
    logic        ul1LineValid;
    logic        ul1FrameValid;
    wire logic   wl1Sda;
    logic        ul1SdaIn;
    logic        ul1SdaOut;
    logic        ul1SdaOEn;
    logic        ul1Scl;

    modport conx (
        input  ul1PixelClock,
        input  ul12PixelData,
        output ul1ExtClockInput,
        output ul1Resetn,
        output ul1SnapshotTrigger,
        input  ul1SnapshotStrobe,
        input  ul1LineValid,
        input  ul1FrameValid,
        inout  wl1Sda,
        output ul1Scl
        );
             
    modport driver (
        input  ul1Clock,
        input  ul1Reset_n,
        input  ul1PixelClock,
        input  ul12PixelData,
        output ul1ExtClockInput,
        output ul1Resetn,
        output ul1SnapshotTrigger,
        input  ul1SnapshotStrobe,
        input  ul1LineValid,
        input  ul1FrameValid,
        input  ul1SdaIn,
        output ul1SdaOut,
        output ul1SdaOEn,
        output ul1Scl
        ); 

`ifdef TEST
    
    clocking cb_conx @ (posedge ul1Clock);
        output ul1PixelClock;
        output ul12PixelData;
        input  ul1ExtClockInput;
        input  ul1Resetn;
        input  ul1SnapshotTrigger;
        output ul1SnapshotStrobe;
        output ul1LineValid;
        output ul1FrameValid;
        inout  wl1Sda;
        input  ul1Scl;
    endclocking
    
    modport tb_conx (
        clocking cb_conx
        );
    
    clocking cb_driver @ (posedge ul1Clock);
        output ul1Reset_n;
        output ul1PixelClock;
        output ul12PixelData;
        input  ul1ExtClockInput;
        input  ul1Resetn;
        input  ul1SnapshotTrigger;
        output ul1SnapshotStrobe;
        output ul1LineValid;
        output ul1FrameValid;
        output ul1SdaIn;
        input  ul1SdaOut;
        input  ul1SdaOEn;
        input  ul1Scl;
    endclocking
    
    modport tb_driver (
        clocking cb_driver
        );
    
`endif
        
endinterface : tITRDB_D5M

`endif//I_TRDB_D5M_SV
