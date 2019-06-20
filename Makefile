include config.mk

SRCS += $(DIR_APP)/main.c
SRCS += $(DIR_APP)/delay.c
SRCS += $(DIR_APP)/led.c

OBJS := $(patsubst %.c,%.o,$(SRCS))
OBJS += $(patsubst %.s,%.o,$(ASMS))

CFLAGS += -I$(DIR_APP)

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

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@
%.o: %.s
	$(AS) -c $(CFLAGS) $< -o $@

clean:
	@echo "Clean Source"
	rm -rf $(OBJS) $(TARGET) $(TARGET).*

