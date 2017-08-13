onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider UUT
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1Clock
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1Reset_n
add wave -noupdate -expand -group pIVgaOut -radix hexadecimal /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul8Red
add wave -noupdate -expand -group pIVgaOut -radix hexadecimal /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul8Green
add wave -noupdate -expand -group pIVgaOut -radix hexadecimal /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul8Blue
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1PixelClock
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1Blank_n
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1Sync_n
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1HSync
add wave -noupdate -expand -group pIVgaOut /tMVgaDriverTB/iMVgaDriver/pIVgaOut/ul1VSync
add wave -noupdate -expand -group pIDrawPoint /tMVgaDriverTB/iIDrawPoint/ul1Clock
add wave -noupdate -expand -group pIDrawPoint /tMVgaDriverTB/iIDrawPoint/ul1Reset_n
add wave -noupdate -expand -group pIDrawPoint /tMVgaDriverTB/iIDrawPoint/ul1Update
add wave -noupdate -expand -group pIDrawPoint -radix unsigned /tMVgaDriverTB/iIDrawPoint/ul9PosX
add wave -noupdate -expand -group pIDrawPoint -radix unsigned /tMVgaDriverTB/iIDrawPoint/ul9PosY
add wave -noupdate -expand -group pIDrawPoint -radix hexadecimal /tMVgaDriverTB/iIDrawPoint/ul12Rgb12Data
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10HSyncDurationCC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10HBackPorchDurationCC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10HDisplayDurationCC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10HFrontPorchDurationCC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10VSyncDurationLC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10VBackPorchDurationLC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10VDisplayDurationLC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10VFrontPorchDurationLC
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10HRes
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10VRes
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul19Res
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10BufHRes
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul10BufVRes
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul19BufRes
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/cul4ZoomFactor
add wave -noupdate /tMVgaDriverTB/iMVgaDriver/eHSyncState
add wave -noupdate /tMVgaDriverTB/iMVgaDriver/eVSyncState
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/ul10HSyncClockCounter
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/ul10VSyncLineCounter
add wave -noupdate /tMVgaDriverTB/iMVgaDriver/ul1HSyncDisplayActive
add wave -noupdate /tMVgaDriverTB/iMVgaDriver/ul1VSyncDisplayActive
add wave -noupdate /tMVgaDriverTB/iMVgaDriver/ul1EndOfLine
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/ul19PixelAddr
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/ul17PixelInAddr
add wave -noupdate -radix unsigned /tMVgaDriverTB/iMVgaDriver/ul17PixelOutAddr
add wave -noupdate -radix hexadecimal /tMVgaDriverTB/iMVgaDriver/ul12RgbOut
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
WaveRestoreZoom {0 ps} {52500 us}
