CC=clang
CFLAGS=-Wall -Wextra -O2 -g
SHARED_CFLAGS=-fPIC
LDFLAGS=-shared
TARGET_LIB=libpoptrie.so

SRCS=buddy.c poptrie.c poptrie4.c poptrie6.c
OBJS=$(SRCS:.c=.o)

.PHONY: all clean

all: $(TARGET_LIB)

$(TARGET_LIB): $(OBJS)
	$(CC) ${LDFLAGS} $(SHARED_CFLAGS) -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

.PHONY: clean
clean:
	rm -f ${TARGET_LIB} ${OBJS} $(SRCS:.c=.d) test_basic test_basic6

test_basic: tests/basic.o $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

test_basic6: tests/basic6.o $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

test: test_basic test_basic6
	@echo Running IPv4 tests
	./test_basic
	@echo Running IPv6 tests
	./test_basic6
