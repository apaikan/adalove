
# PREFIX is the usual prefix for GNAT commands
PREFIX=

all:
	$(PREFIX)arm-none-eabi-gnatmake -P blink.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin
	$(PREFIX)arm-none-eabi-size main.out

flash:
	sudo lm4flash main.bin

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P blink.gpr
	rm -f main.bin

