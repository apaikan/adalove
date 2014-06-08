
# PREFIX is the usual prefix for GNAT commands
PREFIX=

all:
	$(PREFIX)arm-none-eabi-gnatmake -P basic.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P basic.gpr
	rm -f main.bin

.PHONY: clean basic

