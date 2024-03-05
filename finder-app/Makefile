CC = gcc
CFLAGS = -Wall
TARGET = writer

# Check if CROSS_COMPILE is set, and adjust the compiler accordingly
ifneq ($(CROSS_COMPILE),)
    CC = $(CROSS_COMPILE)gcc
endif

# Default target
all: $(TARGET)

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c

# Clean target
clean:
	rm -f $(TARGET) *.o

.PHONY: all clean

