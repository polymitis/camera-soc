@echo off

:: Get current working directory and modify it for modelsim
set test_dir=%cd% 
set test_dir=%test_dir:\=/% 
set test_dir=%test_dir:~0,-2%
:: Run modelsim
echo Behavioural test started
vsim -modelsimini "%test_dir%/modelsim.ini" -batch -do "cd %test_dir%; source run_beh_test.tcl; quit -force"
echo Behavioural test finished
:: Print results
type beh_results.txt