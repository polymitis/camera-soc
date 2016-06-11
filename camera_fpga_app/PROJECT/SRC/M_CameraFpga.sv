// Project   : camera_fpga_app
// Details   : Top module for Terasic DE1-SOC rev.D board.
`ifndef M_CAMERAFPGA_SV
`define M_CAMERAFPGA_SV

`include "I_HPS.sv"
`include "I_TRDB_D5M.sv"
`include "I_VgaOut.sv"
`include "I_FrameTransfer.sv"
`include "I_DrawPoint.sv"
`include "M_PLL.sv"
`include "M_SyncSig.sv"
`include "M_TRDB_D5M_Driver.sv"
`include "M_VgaDriver.sv"

module tMCameraFpga 
( // Ports:
    input  logic        piul1FpgaClock, // 50 MHz
    output logic [9:0]  poul10LEDR,
    tITRDB_D5M.conx     pITRDB_D5M,
    tIVgaOut.conx       pIVgaOut,
    tIHPS               pIHPS
); 
    
    logic ul1SysClock;
    logic ul1SysReset;
    logic ul1SysReset_n;
    
    logic ul1PllClock;
    logic ul1PllLocked;
    logic ul1PllReset_n;
    
    logic ul1DrawPointClock;
    
    logic [2:0]  ul3HpsResetReq;
    logic        ul1HpsColdReset;
    logic        ul1HpsWarmReset;
    logic        ul1HpsDebugReset;
    logic [27:0] ul28StmHwEvents;
    logic [31:0] ul32HpsPIO;
    
    // Image sensor interface
    tITRDB_D5M iITRDB_D5M
    ( // Ports:
        .ul1Clock   (ul1SysClock),
        .ul1Reset_n (ul1SysReset_n)
    );
    
    // VGA output interface
    tIVgaOut iIVgaOut
    ( //Ports:
        .ul1Clock (ul1PllClock)
    );
     
    // Frame transfer bus
    tIFrameTransfer iIFrameTransfer
    ( // Ports:
        .ul1Clock (ul1SysClock)
    );
    
    // Draw point interface
    tIDrawPoint iIDrawPoint
    ( // Ports:
        .ul1Clock (ul1DrawPointClock)
    );

    // PLL clock
    tMPLL iMPLL 
    ( // Ports:
        .piul1RefClock  (ul1SysClock), // 50 MHz
        .piul1Reset_n   (ul1SysReset),
        .poul1ClockOut  (ul1PllClock), // 25.175644 MHz
        .poul1Locked    (ul1PllLocked)
    );
    
    // Pll reset
    tMSyncSig 
    #(// Parameters:
        .SYNC_DELAY_CC  (2)
    )
    iMPllResetSync
    ( // Ports:
        .piul1SyncClock (ul1PllClock),
        .piul1SigIn     (piul1SysReset_n),
        .poul1SigOut    (ul1PllReset_n)
    );
    
    // Image sensor driver
    tMTRDB_D5M_Driver iMTRDB_D5M_Driver 
    ( // Ports:
        .pISensor       (iITRDB_D5M),
        .pIFrameOut     (iIFrameTransfer)
    );
    
    // VGA driver
    tMVgaDriver iMVgaDriver 
    ( // Ports:
        .pIVgaOut       (iIVgaOut),
        .pIDrawPoint    (iIDrawPoint)
    );
    
    CameraHPS iCameraHPS 
    ( // Ports:
		.clk_clk                            (ul1SysClock),               //                     clk.clk
        .reset_reset_n                      (ul1SysReset_n),             //                   reset.reset_n
                                                                         
		.hps_h2f_reset_reset_n              (ul1SysReset_n),             //           hps_h2f_reset.reset_n
		.hps_f2h_cold_reset_req_reset_n     (~ul1HpsColdReset),          //  hps_f2h_cold_reset_req.reset_n
		.hps_f2h_debug_reset_req_reset_n    (~ul1HpsDebugReset),         // hps_f2h_debug_reset_req.reset_n
		.hps_f2h_warm_reset_req_reset_n     (~ul1HpsWarmReset),          //  hps_f2h_warm_reset_req.reset_n
		.hps_f2h_stm_hw_events_stm_hwevents (ul28StmHwEvents),           //   hps_f2h_stm_hw_events.stm_hwevents
		                                                                 
        .hps_io_hps_io_emac1_inst_TX_CLK    (pIHPS.ENET_GTX_CLK),        //                  hps_io.hps_io_emac1_inst_TX_CLK
		.hps_io_hps_io_emac1_inst_TXD0      (pIHPS.ENET_TX_DATA[0]),     //                        .hps_io_emac1_inst_TXD0
		.hps_io_hps_io_emac1_inst_TXD1      (pIHPS.ENET_TX_DATA[1]),     //                        .hps_io_emac1_inst_TXD1
		.hps_io_hps_io_emac1_inst_TXD2      (pIHPS.ENET_TX_DATA[2]),     //                        .hps_io_emac1_inst_TXD2
		.hps_io_hps_io_emac1_inst_TXD3      (pIHPS.ENET_TX_DATA[3]),     //                        .hps_io_emac1_inst_TXD3
		.hps_io_hps_io_emac1_inst_RXD0      (pIHPS.ENET_RX_DATA[0]),     //                        .hps_io_emac1_inst_RXD0
		.hps_io_hps_io_emac1_inst_MDIO      (pIHPS.ENET_MDIO),           //                        .hps_io_emac1_inst_MDIO
		.hps_io_hps_io_emac1_inst_MDC       (pIHPS.ENET_MDC),            //                        .hps_io_emac1_inst_MDC
		.hps_io_hps_io_emac1_inst_RX_CTL    (pIHPS.ENET_RX_DV),          //                        .hps_io_emac1_inst_RX_CTL
		.hps_io_hps_io_emac1_inst_TX_CTL    (pIHPS.ENET_TX_EN),          //                        .hps_io_emac1_inst_TX_CTL
		.hps_io_hps_io_emac1_inst_RX_CLK    (pIHPS.ENET_RX_CLK),         //                        .hps_io_emac1_inst_RX_CLK
		.hps_io_hps_io_emac1_inst_RXD1      (pIHPS.ENET_RX_DATA[1]),     //                        .hps_io_emac1_inst_RXD1
		.hps_io_hps_io_emac1_inst_RXD2      (pIHPS.ENET_RX_DATA[2]),     //                        .hps_io_emac1_inst_RXD2
		.hps_io_hps_io_emac1_inst_RXD3      (pIHPS.ENET_RX_DATA[3]),     //                        .hps_io_emac1_inst_RXD3
		                                                                 
        .hps_io_hps_io_qspi_inst_IO0        (pIHPS.FLASH_DATA[0]),       //                        .hps_io_qspi_inst_IO0
		.hps_io_hps_io_qspi_inst_IO1        (pIHPS.FLASH_DATA[1]),       //                        .hps_io_qspi_inst_IO1
		.hps_io_hps_io_qspi_inst_IO2        (pIHPS.FLASH_DATA[2]),       //                        .hps_io_qspi_inst_IO2
		.hps_io_hps_io_qspi_inst_IO3        (pIHPS.FLASH_DATA[3]),       //                        .hps_io_qspi_inst_IO3
		.hps_io_hps_io_qspi_inst_SS0        (pIHPS.FLASH_NCSO),          //                        .hps_io_qspi_inst_SS0
		.hps_io_hps_io_qspi_inst_CLK        (pIHPS.FLASH_DCLK),          //                        .hps_io_qspi_inst_CLK
		                                                                 
        .hps_io_hps_io_sdio_inst_CMD        (pIHPS.SD_CMD),              //                        .hps_io_sdio_inst_CMD
		.hps_io_hps_io_sdio_inst_D0         (pIHPS.SD_DATA[0]),          //                        .hps_io_sdio_inst_D0
		.hps_io_hps_io_sdio_inst_D1         (pIHPS.SD_DATA[1]),          //                        .hps_io_sdio_inst_D1
		.hps_io_hps_io_sdio_inst_CLK        (pIHPS.SD_CLK),              //                        .hps_io_sdio_inst_CLK
		.hps_io_hps_io_sdio_inst_D2         (pIHPS.SD_DATA[2]),          //                        .hps_io_sdio_inst_D2
		.hps_io_hps_io_sdio_inst_D3         (pIHPS.SD_DATA[3]),          //                        .hps_io_sdio_inst_D3
		                                                                 
        .hps_io_hps_io_usb1_inst_D0         (pIHPS.USB_DATA[0]),         //                        .hps_io_usb1_inst_D0
		.hps_io_hps_io_usb1_inst_D1         (pIHPS.USB_DATA[1]),         //                        .hps_io_usb1_inst_D1
		.hps_io_hps_io_usb1_inst_D2         (pIHPS.USB_DATA[2]),         //                        .hps_io_usb1_inst_D2
		.hps_io_hps_io_usb1_inst_D3         (pIHPS.USB_DATA[3]),         //                        .hps_io_usb1_inst_D3
		.hps_io_hps_io_usb1_inst_D4         (pIHPS.USB_DATA[4]),         //                        .hps_io_usb1_inst_D4
		.hps_io_hps_io_usb1_inst_D5         (pIHPS.USB_DATA[5]),         //                        .hps_io_usb1_inst_D5
		.hps_io_hps_io_usb1_inst_D6         (pIHPS.USB_DATA[6]),         //                        .hps_io_usb1_inst_D6
		.hps_io_hps_io_usb1_inst_D7         (pIHPS.USB_DATA[7]),         //                        .hps_io_usb1_inst_D7
		.hps_io_hps_io_usb1_inst_CLK        (pIHPS.USB_CLKOUT),          //                        .hps_io_usb1_inst_CLK
		.hps_io_hps_io_usb1_inst_STP        (pIHPS.USB_STP),             //                        .hps_io_usb1_inst_STP
		.hps_io_hps_io_usb1_inst_DIR        (pIHPS.USB_DIR),             //                        .hps_io_usb1_inst_DIR
		.hps_io_hps_io_usb1_inst_NXT        (pIHPS.USB_NXT),             //                        .hps_io_usb1_inst_NXT
		                                                                 
        .hps_io_hps_io_spim1_inst_CLK       (pIHPS.SPIM_CLK),            //                        .hps_io_spim1_inst_CLK
		.hps_io_hps_io_spim1_inst_MOSI      (pIHPS.SPIM_MOSI),           //                        .hps_io_spim1_inst_MOSI
		.hps_io_hps_io_spim1_inst_MISO      (pIHPS.SPIM_MISO),           //                        .hps_io_spim1_inst_MISO
		.hps_io_hps_io_spim1_inst_SS0       (pIHPS.SPIM_SS),             //                        .hps_io_spim1_inst_SS0
		                                                                 
        .hps_io_hps_io_uart0_inst_RX        (pIHPS.UART_RX),             //                        .hps_io_uart0_inst_RX
		.hps_io_hps_io_uart0_inst_TX        (pIHPS.UART_TX),             //                        .hps_io_uart0_inst_TX
		                                                                 
        .hps_io_hps_io_i2c0_inst_SDA        (pIHPS.I2C1_SDAT),           //                        .hps_io_i2c0_inst_SDA
		.hps_io_hps_io_i2c0_inst_SCL        (pIHPS.I2C1_SCLK),           //                        .hps_io_i2c0_inst_SCL
		                                                                 
        .hps_io_hps_io_i2c1_inst_SDA        (pIHPS.I2C2_SDAT),           //                        .hps_io_i2c1_inst_SDA
		.hps_io_hps_io_i2c1_inst_SCL        (pIHPS.I2C2_SCLK),           //                        .hps_io_i2c1_inst_SCL
		                                                                 
        .hps_io_hps_io_gpio_inst_GPIO09     (pIHPS.CONV_USB_N),          //                        .hps_io_gpio_inst_GPIO09
		.hps_io_hps_io_gpio_inst_GPIO35     (pIHPS.ENET_INT_N),          //                        .hps_io_gpio_inst_GPIO35
		.hps_io_hps_io_gpio_inst_GPIO40     (pIHPS.LTC_GPIO),            //                        .hps_io_gpio_inst_GPIO40
		.hps_io_hps_io_gpio_inst_GPIO48     (pIHPS.I2C_CONTROL),         //                        .hps_io_gpio_inst_GPIO48
		.hps_io_hps_io_gpio_inst_GPIO53     (pIHPS.LED),                 //                        .hps_io_gpio_inst_GPIO53
		.hps_io_hps_io_gpio_inst_GPIO54     (pIHPS.KEY),                 //                        .hps_io_gpio_inst_GPIO54
		.hps_io_hps_io_gpio_inst_GPIO61     (pIHPS.GSENSOR_INT),         //                        .hps_io_gpio_inst_GPIO61
		                                                                 
        .memory_mem_a                       (pIHPS.DDR3_ADDR),           //                  memory.mem_a
		.memory_mem_ba                      (pIHPS.DDR3_BA),             //                        .mem_ba
		.memory_mem_ck                      (pIHPS.DDR3_CK_P),           //                        .mem_ck
		.memory_mem_ck_n                    (pIHPS.DDR3_CK_N),           //                        .mem_ck_n
		.memory_mem_cke                     (pIHPS.DDR3_CKE),            //                        .mem_cke
		.memory_mem_cs_n                    (pIHPS.DDR3_CS_N),           //                        .mem_cs_n
		.memory_mem_ras_n                   (pIHPS.DDR3_RAS_N),          //                        .mem_ras_n
		.memory_mem_cas_n                   (pIHPS.DDR3_CAS_N),          //                        .mem_cas_n
		.memory_mem_we_n                    (pIHPS.DDR3_WE_N),           //                        .mem_we_n
		.memory_mem_reset_n                 (pIHPS.DDR3_RESET_N),        //                        .mem_reset_n
		.memory_mem_dq                      (pIHPS.DDR3_DQ),             //                        .mem_dq
		.memory_mem_dqs                     (pIHPS.DDR3_DQS_P),          //                        .mem_dqs
		.memory_mem_dqs_n                   (pIHPS.DDR3_DQS_N),          //                        .mem_dqs_n
		.memory_mem_odt                     (pIHPS.DDR3_ODT),            //                        .mem_odt
		.memory_mem_dm                      (pIHPS.DDR3_DM),             //                        .mem_dm
		.memory_oct_rzqin                   (pIHPS.DDR3_RZQ),            //                        .oct_rzqin
		                                                                 
        .pio_external_connection_export     (ul32HpsPIO),                // pio_external_connection.export
		
        .drawpoint_dpm_dpm_ul1reset_n       (iIDrawPoint.ul1Reset_n),    //           drawpoint_dpm.dpm_ul1reset_n
		.drawpoint_dpm_dpm_ul1update        (iIDrawPoint.ul1Update),     //                        .dpm_ul1update
		.drawpoint_dpm_dpm_ul9posx          (iIDrawPoint.ul9PosX),       //                        .dpm_ul9posx
		.drawpoint_dpm_dpm_ul9posy          (iIDrawPoint.ul9PosY),       //                        .dpm_ul9posy
		.drawpoint_dpm_dpm_ul12rgb12data    (iIDrawPoint.ul12Rgb12Data), //                        .dpm_ul12rgb12data
		.drawpoint_dpm_dpm_ul1clock         (ul1DrawPointClock),         //                        .dpm_ul1clock	
	);
    
    // Source/Probe megawizard instance
    hps_reset hps_reset_inst (
      .source_clk (ul1SysClock),
      .source     (ul3HpsResetReq)
    );

    altera_edge_detector 
    #(// Parameters:
        .PULSE_EXT (6),
        .EDGE_TYPE (1),
        .IGNORE_RST_WHILE_BUSY (1)
    ) 
    pulse_cold_reset 
    ( // Ports:
        .clk       (ul1SysClock),
        .rst_n     (ul1SysReset_n),
        .signal_in (ul3HpsResetReq[0]),
        .pulse_out (ul1HpsColdReset)
    );

    altera_edge_detector 
    #(// Parameters:
        .PULSE_EXT (2),
        .EDGE_TYPE (1),
        .IGNORE_RST_WHILE_BUSY (1)
    )
    pulse_warm_reset 
    ( // Ports:
        .clk       (ul1SysClock),
        .rst_n     (ul1SysReset_n),
        .signal_in (ul3HpsResetReq[1]),
        .pulse_out (ul1HpsWarmReset)
    );
    
    altera_edge_detector 
    #(// Parameters:
        .PULSE_EXT (32),
        .EDGE_TYPE (1),
        .IGNORE_RST_WHILE_BUSY (1)
    )
    pulse_debug_reset 
    ( // Ports:
      .clk       (ul1SysClock),
      .rst_n     (ul1SysReset_n),
      .signal_in (ul3HpsResetReq[2]),
      .pulse_out (ul1HpsDebugReset)
    );
    
    // connect LEDs to HPS
    assign poul10LEDR[8:0] = ul32HpsPIO[8:0];
    
    // System clock
    assign ul1SysClock = piul1FpgaClock;
    
    // System reset (Active-High)
    assign ul1SysReset = ~ul1SysReset_n;
    
    // export reset indicator
    assign poul10LEDR[9] = ul1SysReset_n;
    
    // export Image sensor interface
    assign iITRDB_D5M.ul1PixelClock = pITRDB_D5M.ul1PixelClock;
    assign iITRDB_D5M.ul12PixelData = pITRDB_D5M.ul12PixelData;
    assign pITRDB_D5M.ul1ExtClockInput = iITRDB_D5M.ul1ExtClockInput;
    assign pITRDB_D5M.ul1Resetn = iITRDB_D5M.ul1Resetn;
    assign pITRDB_D5M.ul1SnapshotTrigger = iITRDB_D5M.ul1SnapshotTrigger;
    assign iITRDB_D5M.ul1SnapshotStrobe = pITRDB_D5M.ul1SnapshotStrobe;
    assign iITRDB_D5M.ul1LineValid = pITRDB_D5M.ul1LineValid;
    assign iITRDB_D5M.ul1FrameValid = pITRDB_D5M.ul1FrameValid;
    assign iITRDB_D5M.ul1SdaIn = (iITRDB_D5M.ul1SdaOEn == 1'b0)? pITRDB_D5M.wl1Sda : 1'b0;
    assign pITRDB_D5M.wl1Sda = (iITRDB_D5M.ul1SdaOEn == 1'b1)? iITRDB_D5M.ul1SdaOut : 1'bZ;
    assign pITRDB_D5M.ul1Scl = iITRDB_D5M.ul1Scl;
    
    // export VGA output interface
    assign iIVgaOut.ul1Reset_n = ul1PllReset_n & ul1PllLocked; // release reset only after PLL has locked
    assign pIVgaOut.ul8Red = iIVgaOut.ul8Red;    
    assign pIVgaOut.ul8Green = iIVgaOut.ul8Green;  
    assign pIVgaOut.ul8Blue = iIVgaOut.ul8Blue;
    assign pIVgaOut.ul1PixelClock = iIVgaOut.ul1PixelClock;
    assign pIVgaOut.ul1Blank_n = iIVgaOut.ul1Blank_n;
    assign pIVgaOut.ul1Sync_n = iIVgaOut.ul1Sync_n; 
    assign pIVgaOut.ul1HSync = iIVgaOut.ul1HSync;  
    assign pIVgaOut.ul1VSync = iIVgaOut.ul1VSync;
    
endmodule : tMCameraFpga

`endif//M_CAMERAFPGA_SV
