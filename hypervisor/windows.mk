# Define compiler and linker
CC = gcc
CXX = g++
LINKER = gcc

# Define compile and link flags
CFLAGS = -Wall -O2
LDFLAGS =

# Source and object files
SRCS = $(wildcard src/*.c)
OBJS = $(SRCS:.c=.o)

# Target executable
TARGET = vm_app.exe

# Default rule
all: $(TARGET)

# Link object files to create executable
$(TARGET): $(OBJS)
    $(LINKER) $(LDFLAGS) -o $@ $^

# Compile source files into object files
%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@

# Clean up build files
clean:
    rm -f $(OBJS) $(TARGET)

# Install target
install: $(TARGET)
    cp $(TARGET) /usr/local/bin/

.PHONY: all clean install
