
# TARGET holds the configuration names of the compiler
#        it is mostly used to adapt the examples to special configurations
#        such as Windows (with no cygwin)
TARGET=$(shell gcc -dumpmachine)

# PREFIX is the usual prefix for GNAT commands
PREFIX=


all:
	$(PREFIX)gnatmake -P task_prio.gpr

clean:
	$(PREFIX)gnatclean -P task_prio.gpr

.PHONY: clean task_prio
