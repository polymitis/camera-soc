# ###################### START OF TEST CONFIGURATION ######################### # 




# Project name
set project_name "camera_fpga"

# Tests
array set tests  {

    0   VgaDriver 
}




# ####################### END OF TEST CONFIGURATION ########################### #
set systemTime [clock seconds]

set mode test
set status passed
set fp [open "beh_results.txt" "w"]
echo " "
puts $fp "Project: $project_name" 
echo "Project: $project_name"
echo " "
echo " "
puts $fp "[clock format $systemTime -format {Date: %A, the %d of %B, %Y, %H:%M:%S}]"
echo "[clock format $systemTime -format {Date: %A, the %d of %B, %Y, %H:%M:%S}]"
puts $fp [format "%-30s %-6s" "Unit" "Status"]
puts $fp [string repeat - 37]
# run tests
foreach order [lsort [array names tests]] {

    set test $tests($order)
    # change to test directory
    cd $test/ 
    echo "cd $test/"
    # delete old test library
    file delete -force work
    file delete -force vsim.wlf  
    echo "old simulation library and waveform deleted"
    # run test
    echo " "
    set test_status [source run_test.tcl]
    # write result
    puts $fp [format "%-30s %-30s" $test $test_status]
    echo "$test $test_status"
    # exit directory
    cd ../
    echo " "
    echo " "
    # Check for failures
    if {$test_status == "failed"} {
        set status failed
    }
}
# finalise test
puts $fp [string repeat - 36]
if {$test_status == "passed"} {
    puts $fp "All tests passed"
    echo "All tests passed"
}
array unset tests
close $fp
return $status
