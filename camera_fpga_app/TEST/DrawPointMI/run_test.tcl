# ###################### START OF TEST CONFIGURATION ######################### # 




# Test name
set test_name DrawPointMI

# Test uut sources location
set uut_src_loc ../../PROJECT/SRC/DrawPointMI

# Test testbench sources location
set tb_src_loc ../../PROJECT/SRC

# Test uut sources
array set uut_src_files  {

    00      M_DrawPointMI.sv
}

# Test tb sources
array set tb_src_files  { 
      
    00      DrawPointMI/DrawPointMI_sim/simulation/submodules/verbosity_pkg.sv
    01      DrawPointMI/DrawPointMI_sim/simulation/submodules/avalon_mm_pkg.sv 
    02      DrawPointMI/DrawPointMI_sim/simulation/submodules/avalon_utilities_pkg.sv  
    03      DrawPointMI/DrawPointMI_sim/simulation/submodules/altera_avalon_mm_master_bfm.sv 
    04      DrawPointMI/DrawPointMI_sim/simulation/submodules/altera_merlin_master_translator.sv
    05      DrawPointMI/DrawPointMI_sim/simulation/submodules/altera_merlin_slave_translator.sv
    06      DrawPointMI/DrawPointMI_sim/simulation/submodules/DrawPointMI_sim_mm_interconnect_0.v
    07      DrawPointMI/DrawPointMI_sim/simulation/DrawPointMI_sim.v
    08      P_ImageProcessing.sv 
    09      I_VgaOut.sv
    10      I_FrameTransfer.sv
    11      M_FrameBuffer_320x240.sv 
    12      M_VgaDriver.sv    
    13      DrawPointMI/M_DrawPointMI.svt 
}

# Testbench entity name
set tb_module   tMDrawPointMI_tb

# Simulation duration
set sim_dur     1500ns   

# Source Altera-Modelsim simulation setup script
do ../../PROJECT/SRC/DrawPointMI/DrawPointMI_sim/simulation/mentor/msim_setup.tcl


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