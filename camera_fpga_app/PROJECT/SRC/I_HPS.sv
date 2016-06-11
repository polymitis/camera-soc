// Project   : Camera FPGA
// Details   : HPS interface.
`ifndef I_HPS_SV
`define I_HPS_SV

// HPS interface
interface tIHPS ();
    
    wire         CONV_USB_N;
    logic [14:0] DDR3_ADDR;
    logic [2:0]  DDR3_BA;
    logic        DDR3_CAS_N;
    logic        DDR3_CKE;
    logic        DDR3_CK_N;
    logic        DDR3_CK_P;
    logic        DDR3_CS_N;
    logic [3:0]  DDR3_DM;
    wire  [31:0] DDR3_DQ;
    wire  [3:0]  DDR3_DQS_N;
    wire  [3:0]  DDR3_DQS_P;
    logic        DDR3_ODT;
    logic        DDR3_RAS_N;
    logic        DDR3_RESET_N;
    logic        DDR3_RZQ;
    logic        DDR3_WE_N;
    logic        ENET_GTX_CLK;
    wire         ENET_INT_N;
    logic        ENET_MDC;
    wire         ENET_MDIO;
    logic        ENET_RX_CLK;
    logic [3:0]  ENET_RX_DATA;
    logic        ENET_RX_DV;
    logic [3:0]  ENET_TX_DATA;
    logic        ENET_TX_EN;
    wire  [3:0]  FLASH_DATA;
    logic        FLASH_DCLK;
    logic        FLASH_NCSO;
    wire         GSENSOR_INT;
    wire         I2C1_SCLK;
    wire         I2C1_SDAT;
    wire         I2C2_SCLK;
    wire         I2C2_SDAT;
    wire         I2C_CONTROL;
    wire         KEY;
    wire         LED;
    wire         LTC_GPIO;
    logic        SD_CLK;
    wire         SD_CMD;
    wire  [3:0]  SD_DATA;
    logic        SPIM_CLK;
    logic        SPIM_MISO;
    logic        SPIM_MOSI;
    wire         SPIM_SS;
    logic        UART_RX;
    logic        UART_TX;
    logic        USB_CLKOUT;
    wire  [7:0]  USB_DATA;
    logic        USB_DIR;
    logic        USB_NXT;
    logic        USB_STP;
    
    modport conx (
        inout  CONV_USB_N,
        output DDR3_ADDR,
        output DDR3_BA,
        output DDR3_CAS_N,
        output DDR3_CKE,
        output DDR3_CK_N,
        output DDR3_CK_P,
        output DDR3_CS_N,
        output DDR3_DM,
        inout  DDR3_DQ,
        inout  DDR3_DQS_N,
        inout  DDR3_DQS_P,
        output DDR3_ODT,
        output DDR3_RAS_N,
        output DDR3_RESET_N,
        input  DDR3_RZQ,
        output DDR3_WE_N,
        output ENET_GTX_CLK,
        inout  ENET_INT_N,
        output ENET_MDC,
        inout  ENET_MDIO,
        input  ENET_RX_CLK,
        input  ENET_RX_DATA,
        input  ENET_RX_DV,
        output ENET_TX_DATA,
        output ENET_TX_EN,
        inout  FLASH_DATA,
        output FLASH_DCLK,
        output FLASH_NCSO,
        inout  GSENSOR_INT,
        inout  I2C1_SCLK,
        inout  I2C1_SDAT,
        inout  I2C2_SCLK,
        inout  I2C2_SDAT,
        inout  I2C_CONTROL,
        inout  KEY,
        inout  LED,
        inout  LTC_GPIO,
        output SD_CLK,
        inout  SD_CMD,
        inout  SD_DATA,
        output SPIM_CLK,
        input  SPIM_MISO,
        output SPIM_MOSI,
        inout  SPIM_SS,
        input  UART_RX,
        output UART_TX,
        input  USB_CLKOUT,
        inout  USB_DATA,
        input  USB_DIR,
        input  USB_NXT,
        output USB_STP
        );
        
endinterface : tIHPS

`endif//I_HPS_SV