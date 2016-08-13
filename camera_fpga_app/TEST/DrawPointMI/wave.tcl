onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {HPS DPM interface}
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/csi_cmd_clock_clk
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/rsi_cmd_reset_reset
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_address
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_read
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_readdata
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_write
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_writedata
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_beginbursttransfer
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_burstcount
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_readdatavalid
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_waitrequest
add wave -noupdate -radix binary /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_byteenable
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul1Clock
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul1Reset_n
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul1Update
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul9PosX
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul9PosY
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul12Rgb12Data
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16ConfigRegister
add wave -noupdate /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/eReadState
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/eBurstState
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16Address
add wave -noupdate /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul2ByteEnable
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1ReadDataValid
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1BurstActive
add wave -noupdate /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1BurstReadActive
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul10BurstCount
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16BurstAddress
add wave -noupdate /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul2BurstReadByteEnable
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16VersionReadData
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1VersionReadAddressValid
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16ParamReadData
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1ParamReadAddressValid
add wave -noupdate /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1ReadAddressValid
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul9PosX
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul9PosY
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16PosX
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16PosY
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul12Rgb12Data
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1Update
add wave -noupdate -divider {VgaOut Port}
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1Clock
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1Reset_n
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul8Red
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul8Green
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul8Blue
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1PixelClock
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1Blank_n
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1Sync_n
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1HSync
add wave -noupdate /tMDrawPointMI_tb/iIVgaOut/ul1VSync
add wave -noupdate -divider {VgaDriver module}
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/eHSyncState
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/eVSyncState
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul10HSyncClockCounter
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul10VSyncLineCounter
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul1HSyncDisplayActive
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul1VSyncDisplayActive
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul1EndOfLine
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul19PixelAddr
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul17PixelInAddr
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul17PixelOutAddr
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/ul12RgbOut
add wave -noupdate -divider {Frame buffer}
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/piul1WClock
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/piul1RClock
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/piul1WEnable
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/piul17WAddr
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/piul12WData
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/piul17RAddr
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/poul12RData
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iMVgaDriver/iMFrameBuffer_320x240/aul12RgbBuffer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {270000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {133125 ps} {526875 ps}
