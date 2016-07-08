# TCL File Generated by Component Editor 16.0
# Fri Jul 08 16:11:27 BST 2016
# DO NOT MODIFY


# 
# tMDrawPointMI "DrawPoint master interface" v16.0
# Petros Fountas 2016.07.08.16:11:27
# DrawPoint master interface
# 

# 
# request TCL package from ACDS 16.0
# 
package require -exact qsys 16.0


# 
# module tMDrawPointMI
# 
set_module_property DESCRIPTION "DrawPoint master interface"
set_module_property NAME tMDrawPointMI
set_module_property VERSION 16.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Application Specific"
set_module_property AUTHOR "Petros Fountas"
set_module_property ICON_PATH tMDrawPoint_icon.png
set_module_property DISPLAY_NAME "DrawPoint master interface"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL tMVDrawPointMI
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS true
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file M_DrawPointMI.sv SYSTEM_VERILOG PATH M_DrawPointMI.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL tMVDrawPointMI
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file M_DrawPointMI.sv SYSTEM_VERILOG PATH M_DrawPointMI.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point cmd_clock
# 
add_interface cmd_clock clock end
set_interface_property cmd_clock clockRate 0
set_interface_property cmd_clock ENABLED true
set_interface_property cmd_clock EXPORT_OF ""
set_interface_property cmd_clock PORT_NAME_MAP ""
set_interface_property cmd_clock CMSIS_SVD_VARIABLES ""
set_interface_property cmd_clock SVD_ADDRESS_GROUP ""

add_interface_port cmd_clock csi_cmd_clock_clk clk Input 1


# 
# connection point cmd_reset
# 
add_interface cmd_reset reset end
set_interface_property cmd_reset associatedClock cmd_clock
set_interface_property cmd_reset synchronousEdges DEASSERT
set_interface_property cmd_reset ENABLED true
set_interface_property cmd_reset EXPORT_OF ""
set_interface_property cmd_reset PORT_NAME_MAP ""
set_interface_property cmd_reset CMSIS_SVD_VARIABLES ""
set_interface_property cmd_reset SVD_ADDRESS_GROUP ""

add_interface_port cmd_reset rsi_cmd_reset_reset reset Input 1


# 
# connection point cmd
# 
add_interface cmd avalon end
set_interface_property cmd addressUnits WORDS
set_interface_property cmd associatedClock cmd_clock
set_interface_property cmd associatedReset cmd_reset
set_interface_property cmd bitsPerSymbol 8
set_interface_property cmd burstOnBurstBoundariesOnly false
set_interface_property cmd burstcountUnits WORDS
set_interface_property cmd explicitAddressSpan 0
set_interface_property cmd holdTime 0
set_interface_property cmd linewrapBursts false
set_interface_property cmd maximumPendingReadTransactions 1
set_interface_property cmd maximumPendingWriteTransactions 0
set_interface_property cmd readLatency 0
set_interface_property cmd readWaitTime 1
set_interface_property cmd setupTime 0
set_interface_property cmd timingUnits Cycles
set_interface_property cmd writeWaitTime 0
set_interface_property cmd ENABLED true
set_interface_property cmd EXPORT_OF ""
set_interface_property cmd PORT_NAME_MAP ""
set_interface_property cmd CMSIS_SVD_VARIABLES ""
set_interface_property cmd SVD_ADDRESS_GROUP ""

add_interface_port cmd avs_cmd_address address Input 17
add_interface_port cmd avs_cmd_read read Input 1
add_interface_port cmd avs_cmd_readdata readdata Output 16
add_interface_port cmd avs_cmd_write write Input 1
add_interface_port cmd avs_cmd_writedata writedata Input 16
add_interface_port cmd avs_cmd_beginbursttransfer beginbursttransfer Input 1
add_interface_port cmd avs_cmd_burstcount burstcount Input 16
add_interface_port cmd avs_cmd_readdatavalid readdatavalid Output 1
add_interface_port cmd avs_cmd_waitrequest waitrequest Output 1
add_interface_port cmd avs_cmd_byteenable byteenable Input 2
set_interface_assignment cmd embeddedsw.configuration.isFlash 0
set_interface_assignment cmd embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment cmd embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment cmd embeddedsw.configuration.isPrintableDevice 0


# 
# connection point dpm
# 
add_interface dpm conduit end
set_interface_property dpm associatedClock cmd_clock
set_interface_property dpm associatedReset ""
set_interface_property dpm ENABLED true
set_interface_property dpm EXPORT_OF ""
set_interface_property dpm PORT_NAME_MAP ""
set_interface_property dpm CMSIS_SVD_VARIABLES ""
set_interface_property dpm SVD_ADDRESS_GROUP ""

add_interface_port dpm coe_dpm_ul1Reset_n dpm_ul1reset_n Output 1
add_interface_port dpm coe_dpm_ul1Update dpm_ul1update Output 1
add_interface_port dpm coe_dpm_ul9PosX dpm_ul9posx Output 9
add_interface_port dpm coe_dpm_ul9PosY dpm_ul9posy Output 9
add_interface_port dpm coe_dpm_ul12Rgb12Data dpm_ul12rgb12data Output 12
add_interface_port dpm coe_dpm_ul1Clock dpm_ul1clock Output 1

