CC = gcc

SRCS = bitvector.c hashing.c socket.c timefuncs.c ptrhash.c utf8.c ios.c \
	dirpath.c htable.c bitvector-ops.c int2str.c dump.c random.c \
	lltinit.c arraylist.c
OBJS = $(SRCS:%.c=%.o)
TARGET = libllt.a

# OS flags: LINUX, WIN32, MACOSX
# architecture flags: __CPU__=xxx, BITS64, ARCH_X86, ARCH_X86_64
ARCHDEFS = -DLINUX -DARCH_X86_64 -DBITS64 -D__CPU__=686
CPPFLAGS += $(ARCHDEFS)
CFLAGS += -Wall -Wno-strict-aliasing

ifdef DEBUG
CPPFLAGS += -DDEBUG
CFLAGS += -g
else
CPPFLAGS += -DNDEBUG
CFLAGS += -O3
endif

default: $(TARGET)

$(TARGET): $(OBJS)
	rm -f $@
	ar crs $@ $^

clean:
	rm -f *.o $(TARGET) core*

.PHONY: default clean

# insert *.d after uncommenting the following and doing a clean build:
# CPPFLAGS += -MMD
arraylist.o: arraylist.c dtypes.h arraylist.h
bitvector.o: bitvector.c dtypes.h bitvector.h
bitvector-ops.o: bitvector-ops.c dtypes.h bitvector.h
dirpath.o: dirpath.c dtypes.h dirpath.h
dump.o: dump.c dtypes.h ios.h utils.h
hashing.o: hashing.c dtypes.h utils.h hashing.h timefuncs.h ios.h \
 random.h lookup3.c
htable.o: htable.c dtypes.h htable.h hashing.h
int2str.o: int2str.c dtypes.h utils.h
ios.o: ios.c dtypes.h utils.h utf8.h ios.h timefuncs.h
lltinit.o: lltinit.c dtypes.h timefuncs.h ios.h random.h utf8.h
ptrhash.o: ptrhash.c dtypes.h ptrhash.h htableh.inc htable.h htable.inc
random.o: random.c dtypes.h ieee754.h utils.h random.h timefuncs.h \
 mt19937ar.c
socket.o: socket.c dtypes.h socket.h
timefuncs.o: timefuncs.c dtypes.h timefuncs.h
utf8.o: utf8.c dtypes.h utf8.h
