// Project   : ADV7123 VGA DAC
// Details   : ADV7123 VGA DAC interface.
`ifndef I_ADV7123_SV
`define I_ADV7123_SV

// ADV7123 interface
interface tIADV7123;

    logic       ul1VgaClock;
    logic [7:0] ul8VgaRed;
    logic [7:0] ul8VgaGreen;
    logic [7:0] ul8VgaBlue;
    logic       ul1VgaBlank_n;
    logic       ul1VgaHSync;
    logic       ul1VgaVSync;
    logic       ul1VgaSync_n;

    modport device (
        input ul1VgaClock,
        input ul8VgaRed,
        input ul8VgaGreen,
        input ul8VgaBlue,
        input ul1VgaBlank_n,
        input ul1VgaHSync,
        input ul1VgaVSync,
        input ul1VgaSync_n
        );
             
    modport driver (
        output ul1VgaClock,
        output ul8VgaRed,
        output ul8VgaGreen,
        output ul8VgaBlue,
        output ul1VgaBlank_n,
        output ul1VgaHSync,
        output ul1VgaVSync,
        output ul1VgaSync_n
        ); 
        
endinterface : tIADV7123

`endif//I_ADV7123_SV
