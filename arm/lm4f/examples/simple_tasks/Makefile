
# PREFIX is the usual prefix for GNAT commands
PREFIX=

BINDING_INC_PATH=tm4c123

all:
	$(PREFIX)arm-none-eabi-gnatmake -P simple_tasks.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin
	$(PREFIX)arm-none-eabi-size main.out

flash:
	sudo lm4flash main.bin

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P simple_tasks.gpr
	rm -f main.bin

.PHONY: clean simple_tasks

