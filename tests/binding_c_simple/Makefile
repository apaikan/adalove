
# TARGET holds the configuration names of the compiler
#        it is mostly used to adapt the examples to special configurations
#        such as Windows (with no cygwin)
TARGET=$(shell gcc -dumpmachine)

# PREFIX is the usual prefix for GNAT commands
PREFIX=/usr/local/gnat/bin/

# CROSS indicates if a cross-compiler is used or not
CROSS=false


all:
	$(PREFIX)gprbuild -P simple_binding.gpr

clean:
	$(PREFIX)gprclean -P simple_binding.gpr

.PHONY: clean simple_binding
