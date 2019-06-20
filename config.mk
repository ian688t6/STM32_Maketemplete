DIR_OUT 			:= Out
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

DEFS = -DUSE_STDPERIPH_DRIVER -DSTM32F10X_HD
A_INCLUDES = 
AFLAGS = $(MCU) $(DEFS) $(A_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

C_INCLUDES = \
-I$(DIR_LIBRARIES)/CMSIS/CM3/DeviceSupport/ST/STM32F10x \
-I$(DIR_LIBRARIES)/CMSIS/CM3/CoreSupport \
-I$(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/inc

ASMS := $(DIR_LIBRARIES)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/gcc_ride7/startup_stm32f10x_hd.s
SRCS := \
		$(DIR_LIBRARIES)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c \
		$(DIR_LIBRARIES)/CMSIS/CM3/CoreSupport/core_cm3.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/misc.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_adc.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_bkp.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_can.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_cec.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_crc.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_dac.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_dbgmcu.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_dma.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_exti.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_flash.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_fsmc.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_i2c.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_iwdg.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_pwr.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_rtc.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_sdio.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_spi.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_tim.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_usart.c
SRCS += $(DIR_LIBRARIES)/STM32F10x_StdPeriph_Driver/src/stm32f10x_wwdg.c

CFLAGS = $(MCU) $(DEFS) $(C_INCLUDES) $(OPT) -Wall -Werror -fdata-sections -ffunction-sections

LDSCRIPT = STM32F103RCTx_FLASH.ld

LFLAGS = -mcpu=cortex-m3 -mthumb -T$(DIR_LINKSCRPT)/$(LDSCRIPT) -Wl,--gc-sections

