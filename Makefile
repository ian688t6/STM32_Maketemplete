include config.mk

ifeq ($(USED_STDPERPH_DRIVER), 1)
include stdperiph.mk 
endif

SRCS += $(DIR_APP)/main.c
SRCS += $(DIR_SYSTEM)/print.c
SRCS += $(DIR_SYSTEM)/sys.c
SRCS += $(DIR_HARDWARE)/led.c
SRCS += $(DIR_HARDWARE)/uart.c

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
	$(OD) -d $@ > $@.dump
	$(OD) -h $@ > $@.map
	$(NM) $@ | sort > $@.sym
	$(NM) -S --size-sort $@ > $@.nm
	$(CP) -O ihex ${TARGET} $(DIR_OUT)/${TARGET}.hex
	$(CP) -O binary -S ${TARGET} $(DIR_OUT)/${TARGET}.bin
	rm -rf ${TARGET}

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@
%.o: %.s
	$(AS) -c $(CFLAGS) $< -o $@

clean:
	@echo "Clean Source"
	rm -rf $(OBJS) $(TARGET) $(TARGET).*

