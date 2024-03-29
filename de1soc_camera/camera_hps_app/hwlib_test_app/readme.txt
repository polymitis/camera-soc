Introduction

This HardwareLibs project is meant as an example for using the FPGA Manager
API. This project uses a combination of the FPGA Manager, DMA, and Bridge
Management API to load the Altera Cyclone5 CameraFPGA image and toggle the 
LEDs attached to the FPGA. DMA is used to accelerate the memory copy step 
for loading the FPGA image.

Furthermore, <Makefile> can be changed to enable/disable semihosting requirement,

If SEMIHOSTING ?= 0, then code will be built without semihosting support.

If SEMIHOSTING ?= 1, then code will be build with semihosting support.

=====

Source Files

The following are descriptions of the source and header files contained in this
project:

hwlib.c

  This file is the main glue for all the components. It initializes the
  DMA system, loads the FPGA image, and brings up the bridges. Then the LEDs
  are toggled in grey code order. Finally, everything is cleaned up in reverse
  order.

=====

Launching the DS-5 Debugger

1. DS-5 must be launched from the SoC EDS Command Shell in order to have all
   environment variables properly set up.  Launch the SoC EDS Command Shell
   in Windows by selecting Altera <version> -> SoC Embedded Design Suite ->
   SoC EDS <version> Command Shell. In Linux, run embedded_command_shell.sh
   found in the linux64 directory. (Do not source the .sh, simply type its
   name at the prompt.)
2. A version of Quartus Prime must be installed in order for the DS-5 debugger
   to function properly with the USB Blaster. A free version can be
   downloaded from the Altera website.
  2a. After launching the SoC EDS Command Shell, type "echo $QUARTUS_ROOTDIR"
      at the prompt.  This should be set to the quartus subdirectory of an
      install of the Quartus Prime tool.  If it is instead set to a qprogrammer/
      subdirectory, please reset it by typing the following command:
      export QUARTUS_ROOTDIR=<path to quartus subdirectory>
      An example of what the path might look like is given below:
      export QUARTUS_ROOTDIR="C:/altera/14.0/quartus/"
3. Type "eclipse &" at the SoC EDS Command Shell prompt to launch the DS-5
   Debugger.
4. In Eclipse, right click inside the Projects pane, select Import..., then
   General -> Existing Projects into Workspace. Import the project as an
   archived file if it is still zipped and tarred, otherwise select the
   root directory it has be unzipped/untarred into.

=====

Building Example

Before running the example, the target executable first needs to be built.

1. In DS-5, build the application:
  1a. Switch to the C/C++ Perspective if not already in that perspective by
      selecting the menu: Window >> Open Perspective >> C/C++.
  1b. In the "Project Explorer" panel, right-mouse-click 
      "CameraFPGA-HardwareLib-CV-GNU" and select "Build Project".

The Console panel (bottom of the UI) should detail the progress of the build
and report any warnings or errors.

=====

System Setup

1. Connect the USB-BlasterII to the host computer.
2. Install the USB-BlasterII driver on the host computer if that driver is not
   already present. Consult documentation for QuartusII for instructions on
   installing the USB-BlasterII driver.
3. In DS-5, configure the launch configuration.
  3a. Select the menu: Run >> Debug Configurations...
  3b. In the options on the left, expand "DS-5 Debugger" and select
      "CameraFPGA-HardwareLib-CV-GNU-Debug".
  3c. In the "Connections" section near the bottom, click Browse.
  3d. Select the appropriate USB-BlasterII to use. Multiple items will be
      presented if there is more than one USB-BlasterII connection attached to
      the host computer. These selections might take a few seconds to load.
  3e. Click "Apply" then "OK" to apply the USB-BlasterII selection.
  3f. Click "Close" to close the Debug Configuration. Otherwise click "Debug"
      run the example in the debugger.
  3g. If a prompt appears asking if you'd like to change to the debug
      perspective, click yes.
4. On the Cyclone 5 DevKit, configure the MSEL dip switch bank to use the
   compressed FPGA image. The MSEL is located near the top part of the board,
   next to the SD Card slot. The MSEL bank should be configured as UDUDUU
   (U for Up, D for Down). If the MSEL is configured incorrectly the debugging
   will report this when the example is run. To retry running, simply adjust
   the MSEL and rerun the example.

=====

Running the Example

After building the example and setting up the host computer system, the example
can be run by following these steps.

1. If semi-hosting is disabled, open a terminal session on the host computer to
   the serial port associated with the USB to serial bridge using a 8-N-1
   configuration (8 databits per frame, no parity, and 1 stopbit) at 115200 baud.
   If using the PuTTY terminal application, select Terminal in the Category pane
   and check "Implicit CR in every LF" to ensure proper formatting to the terminal.
   While not strictly necessary, the terminal will allow for interaction with the
   CLI. If semi-hosting is enabled, the output from print statements will be
   displayed in the "App Console" pane of the DS5 Debugger view.
2. In DS-5, launch the debug configuration.
  2a. Switch to the Debug Perspective if not already in that perspective by
      selecting the menu: Window >> Open Perspective >> DS-5 Debug.
  2b. In the "Debug Control" panel, right-mouse-click
      "CameraFPGA-HardwareLib-CV-GNU-Debug" and select
      "Connect to Target".
3. Connecting to the target takes a moment to load the preloader, run the
   preloader, load the executable, and run executable. After the debug connection
   is established, the debugger will pause the execution at the main() function.
   Users can then set additional break points, step into, step out of, or step one
   line using the DS-5 debugger. Consult documentation for DS-5 for more
   information on debugging operations.
  3a. If semi-hosting is disabled, the debugger may not realize the application has
      finished execution. Hit the "pause" icon to bring control back to the
      debugger.
4. To avoid warnings, disconnect from the target before making changes to the code
   and rebuilding.
