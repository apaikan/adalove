
# TARGET holds the configuration names of the compiler
#        it is mostly used to adapt the examples to special configurations
#        such as Windows (with no cygwin)
TARGET=$(shell gcc -dumpmachine)

# PREFIX is the usual prefix for GNAT commands
PREFIX=/usr/local/gnat/bin/

# CROSS indicates if a cross-compiler is used or not
CROSS=false


all: dump_ada
	$(PREFIX)gprbuild -P complex_binding.gpr

dump_ada: 
	(cd ./build; $(PREFIX)gcc -c -fdump-ada-spec ../src_c/sqlite3.h)

clean:
	$(PREFIX)gprclean -P complex_binding.gpr
	rm -f ./build/*.s
	rm -f ./build/*.ads	

.PHONY: clean complex_binding
