SAIL_LIB_DIR=$(shell opam config var sail:share)/lib
SAIL_C_SRCS=$(wildcard $(SAIL_LIB_DIR)/*.c)
SAIL=$(shell opam config var sail:bin)/sail

SRCDIR=src
SAILSRCDIR=$(SRCDIR)/sail
SAILSRCS=$(SAILSRCDIR)/prelude.sail $(SAILSRCDIR)/base.sail

all: 6502

6502: 6502.c
	$(CC) -o $@ -I $(SAIL_LIB_DIR) $^ $(SAIL_C_SRCS) -lgmp -lz

6502.c: $(SAILSRCS)
	$(SAIL) -O -memo_z3 -c -c_no_main -c_no_rts $(filter %.sail, $^) 1> $@

clean:
	rm 6502.c
