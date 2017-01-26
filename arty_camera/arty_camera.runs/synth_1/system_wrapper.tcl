# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35ticsg324-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.cache/wt [current_project]
set_property parent.project_path C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:arty:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/hdl/system_wrapper.v
add_files C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/system.bd
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_mig_7series_0_1/system_mig_7series_0_1/user_design/constraints/system_mig_7series_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_mig_7series_0_1/system_mig_7series_0_1/user_design/constraints/system_mig_7series_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_mig_7series_0_1/system_mig_7series_0_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_microblaze_0_0/system_microblaze_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_microblaze_0_0/system_microblaze_0_0_ooc_debug.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_microblaze_0_0/system_microblaze_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_dlmb_v10_0/system_dlmb_v10_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_dlmb_v10_0/system_dlmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_ilmb_v10_0/system_ilmb_v10_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_ilmb_v10_0/system_ilmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_dlmb_bram_if_cntlr_0/system_dlmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_ilmb_bram_if_cntlr_0/system_ilmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_lmb_bram_0/system_lmb_bram_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_mdm_1_0/system_mdm_1_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_mdm_1_0/system_mdm_1_0_ooc_trace.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_rst_mig_7series_0_83M_0/system_rst_mig_7series_0_83M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_rst_mig_7series_0_83M_0/system_rst_mig_7series_0_83M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_rst_mig_7series_0_83M_0/system_rst_mig_7series_0_83M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_uartlite_0_0/system_axi_uartlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_uartlite_0_0/system_axi_uartlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_uartlite_0_0/system_axi_uartlite_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_xbar_0/system_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_clk_wiz_0_1/system_clk_wiz_0_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_clk_wiz_0_1/system_clk_wiz_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_clk_wiz_0_1/system_clk_wiz_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_quad_spi_0_0/system_axi_quad_spi_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_quad_spi_0_0/system_axi_quad_spi_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_quad_spi_0_0/system_axi_quad_spi_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_quad_spi_0_0/system_axi_quad_spi_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_xbar_1/system_xbar_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_rst_clk_wiz_0_100M_0/system_rst_clk_wiz_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_rst_clk_wiz_0_100M_0/system_rst_clk_wiz_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_rst_clk_wiz_0_100M_0/system_rst_clk_wiz_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_intc_0_0/system_axi_intc_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_intc_0_0/system_axi_intc_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_intc_0_0/system_axi_intc_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_auto_us_0/system_auto_us_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_auto_us_0/system_auto_us_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_auto_us_1/system_auto_us_1_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_auto_us_1/system_auto_us_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/ip/system_auto_pc_0/system_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/system_ooc.xdc]
set_property is_locked true [get_files C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/sources_1/bd/system/system.bd]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/constrs_1/new/max3421e.xdc
set_property used_in_implementation false [get_files C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.srcs/constrs_1/new/max3421e.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top system_wrapper -part xc7a35ticsg324-1L


write_checkpoint -force -noxdef system_wrapper.dcp

catch { report_utilization -file system_wrapper_utilization_synth.rpt -pb system_wrapper_utilization_synth.pb }
