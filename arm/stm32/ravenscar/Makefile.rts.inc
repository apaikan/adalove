CROSS=arm-none-eabi-

#CFLAGS?=-O2 -g -Wall -Wno-strict-aliasing -Werror

CFLAGS?=-O2 -g -Wall -Wno-strict-aliasing -Werror -c -fno-common -mcpu=cortex-m3 -mthumb \
  -I$(RAVENSCAR_SRC)/stm32/lib_stm32f10x/core \
  -I$(RAVENSCAR_SRC)/stm32/lib_stm32f10x/device \
  -I$(RAVENSCAR_SRC)/stm32/lib_stm32f10x/inc \
  -DSTM32F10X_HD -DUSE_STDPERIPH_DRIVER

KERN_OBJS = startup_stm32f10x_hd.o main.o system_stm32f10x.o context_switch-bb-arm.o

#STM32_FILE=$(wildcard $(RAVENSCAR_SRC)/stm32/lib_stm32f10x/core/*.c)
STM32_FILE=$(wildcard $(RAVENSCAR_SRC)/stm32/lib_stm32f10x/src/*.c)
STM32_TMP=$(filter-out %template.c,$(STM32_FILE))
STM32_OBJ=$(notdir $(STM32_TMP:.c=.o))

RTS_FILE=$(shell grep -L "^separate" $(RTS_BASE)/adainclude/*.ad[sb])
RTS_OBJ=$(notdir $(patsubst %.adb,%.o,$(RTS_FILE:.ads=.o)))

all: libgnat.a libstm32.a

libgnat.a: $(KERN_OBJS) $(RTS_OBJ) force
	$(CROSS)ar rcs $@ $(KERN_OBJS) $(RTS_OBJ)

libstm32.a: $(STM32_OBJ)
	$(CROSS)ar rcs $@ $(STM32_OBJ)

GCC_COMPILE=$(CROSS)gcc -c -o $@ $(CFLAGS) $<

%.o: $(RAVENSCAR_SRC)/%.s
	$(GCC_COMPILE)

%.o: $(RAVENSCAR_SRC)/%.c
	$(GCC_COMPILE)

%.o: $(GCC_SRC)/%.c
	$(GCC_COMPILE)

%.o: $(RAVENSCAR_SRC)/stm32/lib_stm32f10x/core/%.c
	$(GCC_COMPILE)

%.o: $(RAVENSCAR_SRC)/stm32/lib_stm32f10x/src/%.c
	$(GCC_COMPILE)

%.o: $(RTS_BASE)/adainclude/%.adb
	$(CROSS)gnatmake -gnata -a -c --RTS=$(RTS_BASE) -o $@ $(CFLAGS) $<

%.o: $(RTS_BASE)/adainclude/%.ads
	$(CROSS)gnatmake -gnata -a -c --RTS=$(RTS_BASE) -o $@ $(CFLAGS) $<

clean:
	$(RM) -f *.o *~ b~* $(PRG) *.ali *.map *.owav

force:

