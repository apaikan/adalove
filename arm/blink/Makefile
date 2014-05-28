
# PREFIX is the usual prefix for GNAT commands
PREFIX=

STM32_INC_PATH=stm32_inc

all:
	$(PREFIX)arm-none-eabi-gnatmake -P blink.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin

dump_ada: 
	(cd ./include; $(PREFIX)arm-none-eabi-gcc -c -DSTM32F10X_HD -DUSE_STDPERIPH_DRIVER -fdump-ada-spec $(STM32_INC_PATH)/*.h)

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P blink.gpr
	rm -f main.bin

.PHONY: clean simple_project

