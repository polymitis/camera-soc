# ###################### START OF TEST CONFIGURATION ######################### # 




# Project name
set project_name "camera_fpga"

# Tests
array set tests  {

    0   VgaDriver 
}




# ####################### END OF TEST CONFIGURATION ########################### #
set systemTime [clock seconds]

set mode "test"

echo " "
echo "Testing $project_name:"
echo " "
echo " "
set fp [open "results.txt" "w"]
puts $fp "$project_name [clock format $systemTime -format {Today is: %A, the %d of %B, %Y}]"
close $fp
# run tests
foreach order [lsort [array names tests]] {

    # change to test directory
    cd $tests($order)/ 
    echo "cd $tests($order)/"
    # delete old test library
    file delete -force work 
    echo "simulation library deleted"
    # run test
    echo " "
    set test_status [source run_test.tcl]
    # write result
    set fp [open "results.txt" "a+"]
    puts $fp "$tests($order) $test_status"
    close $fp
    echo "$tests($order) $test_status"
    # exit directory
    cd ../
    echo " "
    echo " "
}
array unset tests

quit -force