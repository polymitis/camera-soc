# ###################### START OF TEST CONFIGURATION ######################### # 




# Test name
set test_name VgaCtrl

# Test uut sources location
set uut_src_loc ../../PROJECT/SRC

# Test testbench sources location
set tb_src_loc ../../PROJECT/SRC/VgaCtrl/VgaCtrl_sim/testbench/VgaCtrl_sim_tb/simulation

# Test uut sources
array set uut_src_files  {

    00      P_ImageProcessing.sv 
    01      I_VgaOut.sv
    02      I_DrawPoint.sv
    03      M_FrameBuffer_320x240.sv 
    04      M_VgaDriver.sv 
    05      VgaCtrl/M_VgaCtrl.sv
}

# Test tb sources
array set tb_src_files  { 

    00      submodules/verbosity_pkg.sv
    01      submodules/avalon_utilities_pkg.sv
    02      submodules/avalon_mm_pkg.sv
    03      submodules/altera_avalon_clock_source.sv
    04      submodules/altera_avalon_mm_master_bfm.sv
    05      submodules/altera_avalon_reset_source.sv
    06      submodules/altera_avalon_sc_fifo.v
    07      submodules/altera_avalon_st_pipeline_base.v
    08      submodules/altera_avalon_st_pipeline_stage.sv
    09      submodules/altera_default_burst_converter.sv
    10      submodules/altera_incr_burst_converter.sv
    11      submodules/altera_merlin_address_alignment.sv
    12      submodules/altera_merlin_arbitrator.sv
    13      submodules/altera_merlin_burst_adapter.sv
    14      submodules/altera_merlin_burst_adapter_13_1.sv
    15      submodules/altera_merlin_burst_adapter_new.sv
    16      submodules/altera_merlin_burst_adapter_uncmpr.sv
    17      submodules/altera_merlin_burst_uncompressor.sv
    18      submodules/altera_merlin_master_agent.sv
    19      submodules/altera_merlin_master_translator.sv
    20      submodules/altera_merlin_slave_agent.sv
    21      submodules/altera_merlin_slave_translator.sv
    22      submodules/altera_reset_controller.v
    23      submodules/altera_reset_synchronizer.v
    24      submodules/altera_wrap_burst_converter.sv
    25      submodules/altera_conduit_bfm.sv
    26      submodules/VgaCtrl_sim.v
    27      submodules/VgaCtrl_sim_mm_interconnect_0.v
    28      submodules/VgaCtrl_sim_mm_interconnect_0_avalon_st_adapter.v
    29      submodules/VgaCtrl_sim_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv
    30      submodules/VgaCtrl_sim_mm_interconnect_0_cmd_demux.sv
    31      submodules/VgaCtrl_sim_mm_interconnect_0_cmd_mux.sv
    32      submodules/VgaCtrl_sim_mm_interconnect_0_router.sv
    33      submodules/VgaCtrl_sim_mm_interconnect_0_router_001.sv
    34      submodules/VgaCtrl_sim_mm_interconnect_0_rsp_mux.sv
    35      submodules/VgaCtrl_sim_vga_pll.vo
    36      VgaCtrl_sim_tb.v     
}

# Testbench entity name
set tb_module   VgaCtrl_sim_tb

# Simulation duration (2 frames, 640x480@60Hz)
set sim_dur     50ms   




# ####################### END OF TEST CONFIGURATION ########################### # 

echo "$test_name test started:"
echo " "

set test_status failed

vlib work

# compile uut src files
echo "Compilation started:"
foreach order [lsort [array names uut_src_files]] {
    vlog -work work -sv -svfilesuffix=sv,svt -O0 -stats=all, $uut_src_loc/$uut_src_files($order)
} 

# compile testbench src files
foreach order [lsort [array names tb_src_files]] {
    vlog -work work -sv -svfilesuffix=sv,svt -O0 -stats=all $tb_src_loc/$tb_src_files($order)
} 

# initialise simulation
echo "Simulation loading:"
vsim -c -t ps -classdebug -gconrun -onfinish final -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver work.$tb_module

# look for assertion failures
set broken 0
onbreak {
    lassign [runStatus -full] status fullstat
    if {$status eq "error"} {
        # Unexpected error, report info and force an error exit
        echo "Error: $fullstat"
        set broken 1
        resume
    } elseif {$status eq "break"} {
        # If this is a user break, then issue a promt to give interactive control to the user
        if {[string match "user_*" $fullstat]} {
            pause
        } else {
            # Assertion or other break condition
            set broken 2
            resume
        }
    } else {
        resume
    }
}

if {[info exists mode]} {
    # do nothing
} else {
    set mode "user"
}

if {$mode == "user"} {
    # open wave for debugging
    source wave.tcl

    # wait for user input
    echo "Press ENTER to continue"
    gets stdin ans
}

# start simulation
echo "Simulation started:"
run $sim_dur
echo "Simulation run for $sim_dur"

if {$broken == 1} {
    # Unexpected condition. Exit with bad status
    echo "Simulation failed"
} elseif {$broken == 2} {
    # Assertion or other break condition
    echo "Assertions failed"
} else { 
    echo "Simulation finished succesfully"
    set test_status passed
}

array unset uut_src_files
array unset tb_src_files

return $test_status