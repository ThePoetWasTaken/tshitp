.SUFFIXES:
CC = gcc
SRC = ./src
LANG = c
BUILD = ./build
MAIN_EXEC = $(BUILD)/main
CFLAGS = -fPIC -Wall -Wextra
FILES = $(wildcard $(addsuffix /*.$(LANG), $(SRC)))
OBJS = $(patsubst $(SRC)/%.$(LANG), $(BUILD)/objs/%.o, $(FILES))
ALL_OBJS = $(OBJS)

all: $(MAIN_EXEC)

debug:
	make CFLAGS='$(CFLAGS) -ggdb3'

release:
	make CFLAGS='$(CFLAGS) -O3'

lib: lib_target

lib_target: $(MAIN_EXEC).so

$(MAIN_EXEC): $(ALL_OBJS)
	$(CC) $(ALL_OBJS) -o $@

$(BUILD)/objs/%.o: $(SRC)/%.$(LANG)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJS) $(MAIN_EXEC)

init:
	@mkdir -p $(BUILD)/libs/headers
	@mkdir -p $(BUILD)/libs/objs
	@mkdir -p $(BUILD)/objs

.PHONY: all clean lib release debug init