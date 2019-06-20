include config.mk

ifeq ($(USED_STDPERPH_DRIVER), 1)
include stdperiph.mk 
endif

SRCS += $(DIR_SYSTEM)/print.c
SRCS += $(DIR_SYSTEM)/sys.c
SRCS += $(DIR_HARDWARE)/led.c
SRCS += $(DIR_HARDWARE)/uart.c
SRCS += $(DIR_APP)/main.c

OBJS := $(patsubst %.c,%.o,$(SRCS))
OBJS += $(patsubst %.s,%.o,$(ASMS))

CFLAGS += -I$(DIR_APP) \
-I$(DIR_HARDWARE) \
-I$(DIR_SYSTEM)

.PHONY: all clean

TARGET := demo

all: ${TARGET}
	@echo "make ${TARGET}.bin"

${TARGET}: ${OBJS} 
	$(CC) $(OBJS) $(LFLAGS) -o $@
	$(OD) -d $@ > $(DIR_OUT)/$@.dump
	$(OD) -h $@ > $(DIR_OUT)/$@.map
	$(NM) $@ | sort > $(DIR_OUT)/$@.sym
	$(NM) -S --size-sort $@ > $(DIR_OUT)/$@.nm
	$(CP) -O ihex $@ $(DIR_OUT)/$@.hex
	$(CP) -O binary -S $@ $(DIR_OUT)/$@.bin
	rm -rf ${TARGET}

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@
%.o: %.s
	$(AS) -c $(CFLAGS) $< -o $@

clean:
	@echo "Clean Source"
	rm -rf $(OBJS) $@

