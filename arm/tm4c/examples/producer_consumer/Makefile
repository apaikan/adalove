
# PREFIX is the usual prefix for GNAT commands
PREFIX=

PROJECT=producer_consumer.gpr

all:
	$(PREFIX)arm-none-eabi-gnatmake -P $(PROJECT)
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin
	$(PREFIX)arm-none-eabi-size main.out

flash:
	sudo lm4flash main.bin

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P $(PROJECT)
	rm -f main.bin


