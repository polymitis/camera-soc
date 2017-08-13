/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * 
 *
 * This file is a generated sample test application.
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * SDK application project when you run the "Generate Libraries" menu item.
 *
 */

#include <stdio.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xgpio.h"
#include "gpio_header.h"
#include "xintc.h"
#include "intc_header.h"
#include "xspi.h"
#include "spi_header.h"
int main() 
{
   Xil_ICacheEnable();
   Xil_DCacheEnable();
   print("---Entering main---\n\r");
   

   {
      u32 status;
      
      print("\r\nRunning GpioOutputExample() for axi_gpio_0...\r\n");

      status = GpioOutputExample(XPAR_AXI_GPIO_0_DEVICE_ID,32);
      
      if (status == 0) {
         print("GpioOutputExample PASSED.\r\n");
      }
      else {
         print("GpioOutputExample FAILED.\r\n");
      }
   }
   

   {
      int status;

      print("\r\n Running IntcSelfTestExample() for axi_intc_0...\r\n");

      status = IntcSelfTestExample(XPAR_AXI_INTC_0_DEVICE_ID);

      if (status == 0) {
         print("IntcSelfTestExample PASSED\r\n");
      }
      else {
         print("IntcSelfTestExample FAILED\r\n");
      }
   }
   

   {
      XStatus status;
      
      print("\r\n Runnning SpiSelfTestExample() for axi_quad_spi_0...\r\n");
      
      status = SpiSelfTestExample(XPAR_AXI_QUAD_SPI_0_DEVICE_ID);
      
      if (status == 0) {
         print("SpiSelfTestExample PASSED\r\n");
      }
      else {
         print("SpiSelfTestExample FAILED\r\n");
      }
   }
   
   /*
    * Peripheral SelfTest will not be run for axi_uartlite_0
    * because it has been selected as the STDOUT device
    */

   print("---Exiting main---\n\r");
   Xil_DCacheDisable();
   Xil_ICacheDisable();
   return 0;
}
