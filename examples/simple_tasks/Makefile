
# PREFIX is the usual prefix for GNAT commands
PREFIX=

all:
	$(PREFIX)gnatmake -P simple_tasks.gpr

clean:
	$(PREFIX)gnatclean -P simple_tasks.gpr
	rm -f main.bin

.PHONY: clean simple_tasks

