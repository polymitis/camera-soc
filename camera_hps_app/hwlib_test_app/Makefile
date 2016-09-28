#
# $Id$
#

ALT_DEVICE_FAMILY ?= soc_cv_av
SEMIHOSTING ?= 1

SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
FPGAPJ_ROOT = C:/Users/pfountas/Documents/Projects/pfountas-research/camera_fpga_app/PROJECT

HWLIBS_SRC  := alt_address_space.c alt_bridge_manager.c alt_cache.c alt_clock_manager.c alt_dma.c alt_dma_program.c alt_fpga_manager.c
APP_SRC     := hwlib.c alt_hps_detect.c
C_SRC       := $(APP_SRC) $(HWLIBS_SRC)
#C_SRC       := $(addprefix $(SRC_DIR)/,$(APP_SRC) $(HWLIBS_SRC))

MULTILIBFLAGS := -mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon
CFLAGS  := -g -O0 -Wall -Werror $(MULTILIBFLAGS) -I$(HWLIBS_ROOT)/include -I$(FPGAPJ_ROOT)/software/include -DALT_FPGA_ENABLE_DMA_SUPPORT=1 -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY)

CROSS_COMPILE := arm-altera-eabi-
CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)g++
NM := $(CROSS_COMPILE)nm
OD := $(CROSS_COMPILE)objdump
OC := $(CROSS_COMPILE)objcopy

RM := rm -rf
CP := cp -f

ifeq ($(SEMIHOSTING),0)
CFLAGS := $(CFLAGS) -DPRINTF_UART
LINKER_SCRIPT := cycloneV-dk-ram.ld
HWLIBS_SRC += alt_16550_uart.c alt_printf.c alt_p2uart.c
else
LINKER_SCRIPT := cycloneV-dk-ram-hosted.ld
CFLAGS := $(CFLAGS) -DPRINTF_HOST
endif

LDFLAGS := -T$(LINKER_SCRIPT) $(MULTILIBFLAGS)

ELF ?= $(basename $(firstword $(C_SRC))).axf
SPL := u-boot-spl.axf
OBJ := $(patsubst %.c,%.o,$(C_SRC))

.PHONY: all
all: $(ELF) $(SPL)

.PHONY: clean
clean:
	$(RM) $(ELF) $(SPL) $(OBJ) *.objdump *.map *.rbf $(HWLIBS_SRC) soc_system* cpf_option.txt

define SET_HWLIBS_DEPENDENCIES
$(1): $(2)
	$(CP) $(2) $(1)
endef

ALL_HWLIBS_SRC = $(wildcard $(HWLIBS_ROOT)/src/hwmgr/*.c) $(wildcard $(HWLIBS_ROOT)/src/hwmgr/$(ALT_DEVICE_FAMILY)/*.c $(wildcard $(HWLIBS_ROOT)/src/utils/*.c))

$(foreach file,$(ALL_HWLIBS_SRC),$(eval $(call SET_HWLIBS_DEPENDENCIES,$(notdir $(file)),$(file))))

soc_system.sof: $(FPGAPJ_ROOT)/output_files/camera_fpga.sof
	$(CP) $< $@

# No Data Compression
soc_system_nodc.rbf: soc_system.sof
	quartus_cpf -c $< $@

# With Data Compression
soc_system_dc.rbf: soc_system.sof
	$(RM) cpf_option.txt
	echo bitstream_compression=on > cpf_option.txt
	quartus_cpf -c -o cpf_option.txt $< $@
	$(RM) cpf_option.txt

soc_system_nodc.o: soc_system_nodc.rbf
	$(OC) --input-target binary --output-target elf32-little --alt-machine-code 40 $< $@

soc_system_dc.o: soc_system_dc.rbf
	$(OC) --input-target binary --output-target elf32-little --alt-machine-code 40 $< $@

$(SPL): $(FPGAPJ_ROOT)/software/spl_bsp/uboot-socfpga/spl/u-boot-spl
	$(CP) $< $@
	$(OD) -d $@ > $@.objdump

$(OBJ): %.o: %.c Makefile
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJ) soc_system_dc.o
	$(LD) $(LDFLAGS) $(OBJ) soc_system_dc.o -o $@
	$(OD) -d $@ > $@.objdump
	$(NM) $@ > $@.map
