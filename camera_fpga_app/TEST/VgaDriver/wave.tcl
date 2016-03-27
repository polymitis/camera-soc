onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group VgaOut -radix binary /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1Clock
add wave -noupdate -expand -group VgaOut /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1Reset_n
add wave -noupdate -expand -group VgaOut -radix hexadecimal /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul8Red
add wave -noupdate -expand -group VgaOut -radix hexadecimal /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul8Green
add wave -noupdate -expand -group VgaOut -radix hexadecimal /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul8Blue
add wave -noupdate -expand -group VgaOut /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1PixelClock
add wave -noupdate -expand -group VgaOut /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1Blank_n
add wave -noupdate -expand -group VgaOut /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1Sync_n
add wave -noupdate -expand -group VgaOut /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1HSync
add wave -noupdate -expand -group VgaOut /t_tMVgaDriver/iMVgaDriver/pIVgaOut/ul1VSync
add wave -noupdate -expand -group FrameTransfer -radix binary /t_tMVgaDriver/iMVgaDriver/pIFrameIn/ul1Clock
add wave -noupdate -expand -group FrameTransfer /t_tMVgaDriver/iMVgaDriver/pIFrameIn/ul1Reset_n
add wave -noupdate -expand -group FrameTransfer /t_tMVgaDriver/iMVgaDriver/pIFrameIn/ul1Active
add wave -noupdate -expand -group FrameTransfer -radix unsigned /t_tMVgaDriver/iMVgaDriver/pIFrameIn/eMacroBlockType
add wave -noupdate -expand -group FrameTransfer -radix hexadecimal /t_tMVgaDriver/iMVgaDriver/pIFrameIn/ul24Rgb24Data
add wave -noupdate -expand -group FrameTransfer /t_tMVgaDriver/iMVgaDriver/pIFrameIn/ul1MacroBlockEnd
add wave -noupdate -expand -group FrameTransfer /t_tMVgaDriver/iMVgaDriver/pIFrameIn/ul1Ready
add wave -noupdate -divider Internal
add wave -noupdate /t_tMVgaDriver/iMVgaDriver/eHSyncState
add wave -noupdate /t_tMVgaDriver/iMVgaDriver/eVSyncState
add wave -noupdate -radix unsigned /t_tMVgaDriver/iMVgaDriver/ul10HSyncClockCounter
add wave -noupdate -radix unsigned /t_tMVgaDriver/iMVgaDriver/ul10VSyncLineCounter
add wave -noupdate /t_tMVgaDriver/iMVgaDriver/ul1HSyncDisplayActive
add wave -noupdate /t_tMVgaDriver/iMVgaDriver/ul1VSyncDisplayActive
add wave -noupdate /t_tMVgaDriver/iMVgaDriver/ul1EndOfLine
add wave -noupdate -radix unsigned /t_tMVgaDriver/iMVgaDriver/ul19PixelAddr
add wave -noupdate -radix unsigned /t_tMVgaDriver/iMVgaDriver/ul17PixelAddr
add wave -noupdate -radix hexadecimal -childformat {{{/t_tMVgaDriver/iMVgaDriver/ul12RgbOut[2]} -radix unsigned} {{/t_tMVgaDriver/iMVgaDriver/ul12RgbOut[1]} -radix unsigned} {{/t_tMVgaDriver/iMVgaDriver/ul12RgbOut[0]} -radix unsigned}} -subitemconfig {{/t_tMVgaDriver/iMVgaDriver/ul12RgbOut[2]} {-height 15 -radix unsigned} {/t_tMVgaDriver/iMVgaDriver/ul12RgbOut[1]} {-height 15 -radix unsigned} {/t_tMVgaDriver/iMVgaDriver/ul12RgbOut[0]} {-height 15 -radix unsigned}} /t_tMVgaDriver/iMVgaDriver/ul12RgbOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 158
configure wave -valuecolwidth 145
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
WaveRestoreZoom {3459793183 ps} {34554747728 ps}
