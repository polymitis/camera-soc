// Project   : VGA
// Details   : Draw point interface.
`ifndef I_DRAWPOINT_SV
`define I_DRAWPOINT_SV

// Image transfer interface
interface tIDrawPoint
( // Clocks:
    input logic ul1Clock // Common clock for synchronous trasfer
);
    
    logic         ul1Reset_n;    // Synchronous active-low reset.
    logic         ul1Update;     // Active-high for updating pixel.
    logic [8:0]   ul9PosX;       // Pixel horizontal position.
    logic [8:0]   ul9PosY;       // Pixel vertical position.
    logic [11:0]  ul12Rgb12Data; // RGB12 pixel color data.
    
    modport mst (
        input  ul1Clock,
        output ul1Reset_n,
        output ul1Update,
        output ul9PosX,
        output ul9PosY,
        output ul12Rgb12Data
        );
             
    modport slv (
        input ul1Clock,
        input ul1Reset_n, 
        input ul1Update,
        input ul9PosX,
        input ul9PosY,
        input ul12Rgb12Data
        ); 

`ifdef TEST

    clocking cb_mst @ (posedge ul1Clock);
        input ul1Reset_n;
        input ul1Update;
        input ul9PosX;
        input ul9PosY;
        input ul12Rgb12Data;
    endclocking

    clocking cb_slv @ (posedge ul1Clock);
        output ul1Reset_n;
        output ul1Update;
        output ul9PosX;
        output ul9PosY;
        output ul12Rgb12Data;
    endclocking
    
    modport tb_mst (clocking cb_mst);
    modport tb_slv (clocking cb_slv);

`endif
        
endinterface : tIDrawPoint

`endif//I_DRAWPOINT_SV