CC := gcc
ASM := nasm

CFLAGS := -c -masm=intel
ASMFLAGS := -f elf64

TARGET := app.exe

$(TARGET):
	$(ASM) $(ASMFLAGS) strcopy.asm
	$(CC) $(CFLAGS) main.c
	$(CC) -o $(TARGET) strcopy.o main.o

.PHONY: run clean

run:
	./app.exe

clean:
	rm *.o *.exe
