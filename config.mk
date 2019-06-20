### Configure enviroment ###

DIR_OUT 			:= Out
DIR_HARDWARE 		:= Hardware
DIR_SYSTEM 			:= System
DIR_APP				:= App
DIR_LIBRARIES		:= Libraries
DIR_LINKSCRPT		:= Linkscript

CROSS_COMPILE := arm-none-eabi-
CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)ld
AS := $(CROSS_COMPILE)gcc -x assembler-with-cpp
CP := $(CROSS_COMPILE)objcopy
OD := $(CROSS_COMPILE)objdump
NM := $(CROSS_COMPILE)nm
SZ := $(CROSS_COMPILE)size

CPU = -mcpu=cortex-m3
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

USED_STDPERPH_DRIVER := 1

ifeq ($(USED_STDPERPH_DRIVER), 1)
	DEFS = -DUSE_STDPERIPH_DRIVER -DSTM32F10X_HD
else
	DEFS = -DSTM32F10X_HD
endif

A_INCLUDES = 
AFLAGS = $(MCU) $(DEFS) $(A_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

C_INCLUDES = \
-I$(DIR_LIBRARIES)/CMSIS/CM3/DeviceSupport/ST/STM32F10x \
-I$(DIR_LIBRARIES)/CMSIS/CM3/CoreSupport

ifeq ($(USED_STDPERPH_DRIVER), 1)
C_INCLUDES += -I$(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/inc
endif

ASMS := $(DIR_LIBRARIES)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/gcc_ride7/startup_stm32f10x_hd.s
SRCS := \
		$(DIR_LIBRARIES)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c \
		$(DIR_LIBRARIES)/CMSIS/CM3/CoreSupport/core_cm3.c
CFLAGS = $(MCU) $(DEFS) $(C_INCLUDES) $(OPT)  -Wall -Werror -fdata-sections -ffunction-sections

LDSCRIPT = STM32F103RCTx_FLASH.ld

LFLAGS = -mcpu=cortex-m3 -mthumb -T$(DIR_LINKSCRPT)/$(LDSCRIPT) -Wl,--gc-sections



