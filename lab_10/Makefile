CC := gcc
SRC := ./src
INC := ./inc
OUT := ./out

SRCS := $(wildcard $(SRC)/*.c)
OBJS := $(SRCS:$(SRC)/%.c=$(OUT)/%.o)
INCS := $(wildcard $(INC)/*.h)

CFLAGS := -std=c99 -I$(INC)/ -masm=intel


TARGET=$(OUT)/main.out

.PHONY: build clean all

all: build
	$(TARGET)

build: $(OBJS) $(INCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

$(OUT)/%.o: $(SRC)/%.c $(OUT)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUT):
	mkdir -p $(OUT)

clean:
	rm -f *.o
	rm -f *.out
	rm -rf $(OUT)
