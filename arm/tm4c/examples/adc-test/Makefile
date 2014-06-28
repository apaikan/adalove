
# PREFIX is the usual prefix for GNAT commands
PREFIX=

all:
	$(PREFIX)arm-none-eabi-gnatmake -P adc_test.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin
	$(PREFIX)arm-none-eabi-size main.out

flash:
	sudo lm4flash main.bin

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P adc_test.gpr
	rm -f main.bin

