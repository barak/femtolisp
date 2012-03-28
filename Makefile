CC = gcc

NAME = flisp
SRCS = $(NAME).c builtins.c string.c equalhash.c table.c iostream.c
OBJS = $(SRCS:%.c=%.o)
EXENAME = $(NAME)
LIBTARGET = lib$(NAME)
LLTDIR = llt
LLT = $(LLTDIR)/libllt.a

# OS flags: LINUX, WIN32, MACOSX
# architecture flags: __CPU__=xxx, BITS64, ARCH_X86, ARCH_X86_64
ARCHDEFS = -DLINUX -DARCH_X86_64 -DBITS64 -D__CPU__=686
CPPFLAGS += $(ARCHDEFS)
CPPFLAGS += -DUSE_COMPUTED_GOTO
CPPFLAGS += -I$(LLTDIR)
CFLAGS += -falign-functions -Wall -Wno-strict-aliasing
LIBFILES = $(LLT)
LDLIBS = -lm

ifdef DEBUG
CPPFLAGS += -DDEBUG
CFLAGS += -g
else
CPPFLAGS += -DNDEBUG
CFLAGS += -O2
endif

default: $(EXENAME) test

test: $(EXENAME)
	cd tests && ../$(EXENAME) unittest.lsp

flisp.o:  flisp.c cvalues.c operators.c types.c flisp.h print.c read.c equal.c
flmain.o: flmain.c flisp.h

$(LLT):
	$(MAKE) -C $(LLTDIR) ARCHDEFS="$(ARCHDEFS)" DEBUG="$(DEBUG)"

$(LIBTARGET).a: $(OBJS)
	rm -f $@
	ar crs $@ $^

$(EXENAME): $(OBJS) $(LIBFILES) $(LIBTARGET).a flmain.o	

clean:
	rm -f *.o
	rm -f $(EXENAME)
	rm -f $(LIBTARGET).a
	$(MAKE) -C $(LLTDIR) clean

.PHONY: default test debug clean

# insert *.d after uncommenting the following and doing a clean build:
# CPPFLAGS += -MMD
builtins.o: builtins.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h \
 llt/ios.h llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h \
 llt/htableh.inc llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h \
 flisp.h opcodes.h llt/random.h
equalhash.o: equalhash.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h \
 llt/ios.h llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h \
 llt/htableh.inc llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h \
 flisp.h opcodes.h equalhash.h llt/htableh.inc llt/htable.inc
flisp.o: flisp.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h llt/ios.h \
 llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h llt/htableh.inc \
 llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h flisp.h \
 opcodes.h cvalues.c operators.c llt/dtypes.h llt/utils.h llt/ieee754.h \
 types.c equalhash.h llt/htableh.inc print.c read.c equal.c
flmain.o: flmain.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h \
 llt/ios.h llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h \
 llt/htableh.inc llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h \
 flisp.h opcodes.h
iostream.o: iostream.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h \
 llt/ios.h llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h \
 llt/htableh.inc llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h \
 flisp.h opcodes.h
string.o: string.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h \
 llt/ios.h llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h \
 llt/htableh.inc llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h \
 flisp.h opcodes.h
table.o: table.c llt/llt.h llt/dtypes.h llt/utils.h llt/utf8.h llt/ios.h \
 llt/socket.h llt/timefuncs.h llt/hashing.h llt/ptrhash.h llt/htableh.inc \
 llt/htable.h llt/bitvector.h llt/dirpath.h llt/random.h flisp.h \
 opcodes.h equalhash.h llt/htableh.inc
