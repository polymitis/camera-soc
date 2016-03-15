// Project   : Terasic TRDB_D5M daughter board
// Details   : TRDB_D5M interface.
`ifndef I_TRDB_D5M_SV
`define I_TRDB_D5M_SV

// TRDB_D5M interface
interface tITRDB_D5M;

    logic        ul1PixelClock;
    logic [11:0] ul12PixelData;
    logic        ul1ExtClockInput;
    logic        ul1Resetn;
    logic        ul1SnapshotTrigger;
    logic        ul1SnapshotStrobe;
    logic        ul1LineValid;
    logic        ul1FrameValid;
    logic        ul1Sda;
    logic        ul1Scl;

    modport device (
        output ul1PixelClock,
        output ul12PixelData,
        input  ul1ExtClockInput,
        input  ul1Resetn,
        input  ul1SnapshotTrigger,
        output ul1SnapshotStrobe,
        output ul1LineValid,
        output ul1FrameValid,
        inout  ul1Sda,
        input  ul1Scl
        );
             
    modport driver (
        input  ul1PixelClock,
        input  ul12PixelData,
        output ul1ExtClockInput,
        output ul1Resetn,
        output ul1SnapshotTrigger,
        input  ul1SnapshotStrobe,
        input  ul1LineValid,
        input  ul1FrameValid,
        inout  ul1Sda,
        output ul1Scl
        ); 
        
endinterface//tITRDB_D5M

`endif//I_TRDB_D5M_SV
