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
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/avs_cmd_byteenable
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul1Clock
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul1Reset_n
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul1Update
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul9PosX
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul9PosY
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/coe_dpm_ul12Rgb12Data
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/eBurstState
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16ReadAddress
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1BurstActive
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul10BurstCount
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16BurstReadAddress
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul16VersionReadData
add wave -noupdate -radix hexadecimal /tMDrawPointMI_tb/iDrawPointMI_sim/drawpoint/ul1VersionReadDataValid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 205
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
WaveRestoreZoom {1999162 ps} {2000045 ps}
