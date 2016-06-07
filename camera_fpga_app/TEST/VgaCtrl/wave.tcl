onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider UUT
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/csi_cmd_clock_clk
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/rsi_cmd_reset_reset
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_address
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_read
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_readdata
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_write
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_writedata
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_beginbursttransfer
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_burstcount
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_readdatavalid
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_waitrequest
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/avs_cmd_byteenable
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/csi_vga_clock_clk
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/rsi_vga_reset_reset
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_red
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_green
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_blue
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_pixelclock
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_blank_n
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_sync_n
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_hsync
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_vga_vsync
add wave -noupdate -radix hexadecimal /VgaCtrl_sim_tb/vgactrl_sim_inst/imvgactrl/coe_locked_export
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {49999996750 ps} {50000000172 ps}
