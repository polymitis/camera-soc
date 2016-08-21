# TCL File Generated by Component Editor 16.0
# Sun Jul 10 19:44:31 BST 2016
# DO NOT MODIFY


# 
# InterruptCapture "Interrupt Capture Module" v16.0
# Petros Fountas 2016.07.10.19:44:31
# This component capture interrupt inputs and presents them as registers readable via Avalon Slave port
# 

# 
# request TCL package from ACDS 16.0
# 
package require -exact qsys 16.0


# 
# module InterruptCapture
# 
set_module_property DESCRIPTION "This component capture interrupt inputs and presents them as registers readable via Avalon Slave port"
set_module_property NAME InterruptCapture
set_module_property VERSION 16.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Generic
set_module_property AUTHOR "Petros Fountas"
set_module_property DISPLAY_NAME "Interrupt Capture Module"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL tMInterruptCapture
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file M_InterruptCapture.sv SYSTEM_VERILOG PATH M_InterruptCapture.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL tMInterruptCapture
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file M_InterruptCapture.sv SYSTEM_VERILOG PATH M_InterruptCapture.sv


# 
# parameters
# 
add_parameter NUM_INTR INTEGER 32 ""
set_parameter_property NUM_INTR DEFAULT_VALUE 32
set_parameter_property NUM_INTR DISPLAY_NAME NUM_INTR
set_parameter_property NUM_INTR WIDTH ""
set_parameter_property NUM_INTR TYPE INTEGER
set_parameter_property NUM_INTR UNITS None
set_parameter_property NUM_INTR ALLOWED_RANGES -2147483648:2147483647
set_parameter_property NUM_INTR DESCRIPTION ""
set_parameter_property NUM_INTR HDL_PARAMETER true


# 
# display items
# 


# 
# connection point mem_reset
# 
add_interface mem_reset reset end
set_interface_property mem_reset associatedClock mem_clock
set_interface_property mem_reset synchronousEdges DEASSERT
set_interface_property mem_reset ENABLED true
set_interface_property mem_reset EXPORT_OF ""
set_interface_property mem_reset PORT_NAME_MAP ""
set_interface_property mem_reset CMSIS_SVD_VARIABLES ""
set_interface_property mem_reset SVD_ADDRESS_GROUP ""

add_interface_port mem_reset rsi_mem_reset_reset_n reset_n Input 1


# 
# connection point mem
# 
add_interface mem avalon end
set_interface_property mem addressUnits WORDS
set_interface_property mem associatedClock mem_clock
set_interface_property mem associatedReset mem_reset
set_interface_property mem bitsPerSymbol 8
set_interface_property mem burstOnBurstBoundariesOnly false
set_interface_property mem burstcountUnits WORDS
set_interface_property mem explicitAddressSpan 0
set_interface_property mem holdTime 0
set_interface_property mem linewrapBursts false
set_interface_property mem maximumPendingReadTransactions 0
set_interface_property mem maximumPendingWriteTransactions 0
set_interface_property mem readLatency 0
set_interface_property mem readWaitTime 1
set_interface_property mem setupTime 0
set_interface_property mem timingUnits Cycles
set_interface_property mem writeWaitTime 0
set_interface_property mem ENABLED true
set_interface_property mem EXPORT_OF ""
set_interface_property mem PORT_NAME_MAP ""
set_interface_property mem CMSIS_SVD_VARIABLES ""
set_interface_property mem SVD_ADDRESS_GROUP ""

add_interface_port mem avs_mem_address address Input 1
add_interface_port mem avs_mem_read read Input 1
add_interface_port mem avs_mem_readdata readdata Output 32
set_interface_assignment mem embeddedsw.configuration.isFlash 0
set_interface_assignment mem embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment mem embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment mem embeddedsw.configuration.isPrintableDevice 0


# 
# connection point mem_clock
# 
add_interface mem_clock clock end
set_interface_property mem_clock clockRate 0
set_interface_property mem_clock ENABLED true
set_interface_property mem_clock EXPORT_OF ""
set_interface_property mem_clock PORT_NAME_MAP ""
set_interface_property mem_clock CMSIS_SVD_VARIABLES ""
set_interface_property mem_clock SVD_ADDRESS_GROUP ""

add_interface_port mem_clock csi_mem_clock_clock clk Input 1


# 
# connection point interrupt
# 
add_interface interrupt interrupt start
set_interface_property interrupt associatedAddressablePoint ""
set_interface_property interrupt associatedClock mem_clock
set_interface_property interrupt associatedReset mem_reset
set_interface_property interrupt irqScheme INDIVIDUAL_REQUESTS
set_interface_property interrupt ENABLED true
set_interface_property interrupt EXPORT_OF ""
set_interface_property interrupt PORT_NAME_MAP ""
set_interface_property interrupt CMSIS_SVD_VARIABLES ""
set_interface_property interrupt SVD_ADDRESS_GROUP ""

add_interface_port interrupt irn_interrupt_irq irq Input 32

