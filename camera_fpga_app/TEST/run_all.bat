@echo off 

set test_dir=%cd% 
set test_dir=%test_dir:\=/%

vsim -batch -do "cd %test_dir%; source run_all.tcl" > run_all.log

type results.txt
