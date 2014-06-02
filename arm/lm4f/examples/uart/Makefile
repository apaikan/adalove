
# PREFIX is the usual prefix for GNAT commands
PREFIX=

BINDING_INC_PATH=lm4f120

all:
	$(PREFIX)arm-none-eabi-gnatmake -P blink.gpr
	$(PREFIX)arm-none-eabi-objcopy -Obinary main.out main.bin

dump_ada: 
	(cd ./include; /usr/local/gnat/bin/g++ -c -fdump-ada-spec -DDEPRECATED -DPART_LM4F120H5QR -DTARGET_IS_BLIZZARD_RA1 $(BINDING_INC_PATH)/*.h) 

clean:
	$(PREFIX)arm-none-eabi-gnatclean -P blink.gpr
	rm -f main.bin

.PHONY: clean simple_project

