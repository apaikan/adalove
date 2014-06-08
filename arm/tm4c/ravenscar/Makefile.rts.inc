CROSS=arm-none-eabi-

PART=TM4C123GH6PM
CPU=-mcpu=cortex-m4
FPU=-mfpu=fpv4-sp-d16 -mfloat-abi=softfp


AFLAGS?=-mthumb ${CPU} ${FPU} -MD 

CFLAGS?=-mthumb             \
        ${CPU}              \
        ${FPU}              \
        -ffunction-sections \
        -fdata-sections     \
        -MD                 \
        -std=c99            \
        -Wall               \
        -pedantic           \
        -DPART_$(PART) -DTARGET_IS_BLIZZARD_RB1 -Dgcc \
        -g -O0 \
        -c \
        -I$(RAVENSCAR_SRC)/tm4c123 \
        -I$(RAVENSCAR_SRC)/tm4c123/inc \
        -I$(RAVENSCAR_SRC)/tm4c123/driverlib   
        
KERN_OBJS = startup_tm4c123.o main.o context_switch-bb-arm.o
TM4C_FILE=$(wildcard $(RAVENSCAR_SRC)/tm4c123/driverlib/*.c)
TM4C_TMP=$(filter-out %template.c,$(TM4C_FILE))
TM4C_OBJ=$(notdir $(TM4C_TMP:.c=.o))

RTS_FILE=$(shell grep -L "^separate" $(RTS_BASE)/adainclude/*.ad[sb])
RTS_OBJ=$(notdir $(patsubst %.adb,%.o,$(RTS_FILE:.ads=.o)))

all: libgnat.a libtm4c123.a

libgnat.a: $(KERN_OBJS) $(RTS_OBJ) force
	$(CROSS)ar rcs $@ $(KERN_OBJS) $(RTS_OBJ)

libtm4c123.a: $(TM4C_OBJ)
	$(CROSS)ar rcs $@ $(TM4C_OBJ)

GCC_COMPILE=$(CROSS)gcc -c -o $@ $(CFLAGS) $<

%.o: $(RAVENSCAR_SRC)/%.s
	$(GCC_COMPILE)

%.o: $(RAVENSCAR_SRC)/%.c
	$(GCC_COMPILE)

%.o: $(GCC_SRC)/%.c
	$(GCC_COMPILE)

%.o: $(RAVENSCAR_SRC)/tm4c123/driverlib/%.c
	$(GCC_COMPILE)

%.o: $(RTS_BASE)/adainclude/%.adb
	$(CROSS)gnatmake -gnata -a -c --RTS=$(RTS_BASE) -o $@ $(CFLAGS) $<

%.o: $(RTS_BASE)/adainclude/%.ads
	$(CROSS)gnatmake -gnata -a -c --RTS=$(RTS_BASE) -o $@ $(CFLAGS) $<

clean:
	$(RM) -f *.o *~ b~* $(PRG) *.ali *.map *.owav

force:

