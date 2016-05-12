onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1Clock
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1Reset_n
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1PixelClock
add wave -noupdate -group pITRDB_D5M -radix hexadecimal /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul12PixelData
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1ExtClockInput
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1Resetn
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1SnapshotTrigger
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1SnapshotStrobe
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1LineValid
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1FrameValid
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/wl1Sda
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1SdaIn
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1SdaOut
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1SdaOEn
add wave -noupdate -group pITRDB_D5M /tMCameraFpgaTB/M_CameraFpga/pITRDB_D5M/ul1Scl
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1Clock
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1Reset_n
add wave -noupdate -expand -group pIVgaOut -radix hexadecimal /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul8Red
add wave -noupdate -expand -group pIVgaOut -radix hexadecimal /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul8Green
add wave -noupdate -expand -group pIVgaOut -radix hexadecimal /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul8Blue
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1PixelClock
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1Blank_n
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1Sync_n
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1HSync
add wave -noupdate -expand -group pIVgaOut /tMCameraFpgaTB/M_CameraFpga/pIVgaOut/ul1VSync
add wave -noupdate -expand -group iMSysResetSync /tMCameraFpgaTB/M_CameraFpga/iMSysResetSync/piul1SyncClock
add wave -noupdate -expand -group iMSysResetSync /tMCameraFpgaTB/M_CameraFpga/iMSysResetSync/piul1SigIn
add wave -noupdate -expand -group iMSysResetSync /tMCameraFpgaTB/M_CameraFpga/iMSysResetSync/poul1SigOut
add wave -noupdate -expand -group iMSysResetSync /tMCameraFpgaTB/M_CameraFpga/iMSysResetSync/ulvSyncReg
add wave -noupdate -expand -group iPLL /tMCameraFpgaTB/M_CameraFpga/iMPLL/piul1RefClock
add wave -noupdate -expand -group iPLL /tMCameraFpgaTB/M_CameraFpga/iMPLL/piul1Reset_n
add wave -noupdate -expand -group iPLL /tMCameraFpgaTB/M_CameraFpga/iMPLL/poul1ClockOut
add wave -noupdate -expand -group iPLL /tMCameraFpgaTB/M_CameraFpga/iMPLL/poul1Locked
add wave -noupdate -expand -group iMPllResetSync /tMCameraFpgaTB/M_CameraFpga/iMPllResetSync/piul1SyncClock
add wave -noupdate -expand -group iMPllResetSync /tMCameraFpgaTB/M_CameraFpga/iMPllResetSync/piul1SigIn
add wave -noupdate -expand -group iMPllResetSync /tMCameraFpgaTB/M_CameraFpga/iMPllResetSync/poul1SigOut
add wave -noupdate -expand -group iMPllResetSync /tMCameraFpgaTB/M_CameraFpga/iMPllResetSync/ulvSyncReg
add wave -noupdate -expand -group iVgaDriver /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/eHSyncState
add wave -noupdate -expand -group iVgaDriver /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/eVSyncState
add wave -noupdate -expand -group iVgaDriver -radix unsigned /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul10HSyncClockCounter
add wave -noupdate -expand -group iVgaDriver -radix unsigned /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul10VSyncLineCounter
add wave -noupdate -expand -group iVgaDriver /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul1HSyncDisplayActive
add wave -noupdate -expand -group iVgaDriver /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul1VSyncDisplayActive
add wave -noupdate -expand -group iVgaDriver /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul1EndOfLine
add wave -noupdate -expand -group iVgaDriver -radix unsigned /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul19PixelAddr
add wave -noupdate -expand -group iVgaDriver -radix unsigned /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul17PixelAddr
add wave -noupdate -expand -group iVgaDriver -radix hexadecimal /tMCameraFpgaTB/M_CameraFpga/iMVgaDriver/ul12RgbOut
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
