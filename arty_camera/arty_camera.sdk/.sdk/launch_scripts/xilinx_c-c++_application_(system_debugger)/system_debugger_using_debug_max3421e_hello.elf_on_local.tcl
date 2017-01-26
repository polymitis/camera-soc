connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Arty 210319A28D3BA"} -index 0
loadhw C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.sdk/system_wrapper_hw_platform_0/system.hdf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Arty 210319A28D3BA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Arty 210319A28D3BA"} -index 0
dow C:/Users/pfountas/Documents/Projects/pfountas-research/arty_camera/arty_camera.sdk/max3421e_hello/Debug/max3421e_hello.elf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Arty 210319A28D3BA"} -index 0
con
