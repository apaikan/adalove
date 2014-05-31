
# PREFIX is the usual prefix for GNAT commands
PREFIX=

all:
	$(PREFIX)arm-none-eabi-gnatmake -P simple_tasks.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P simple_tasks.gpr
	rm -f main.bin

.PHONY: clean simple_tasks

