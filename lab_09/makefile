SRC_DIR := ./src
INC_DIR := ./inc
OUT_DIR := ./out

CC := gcc
ASM := nasm
CFLAGS := -std=gnu11 -o0 -w -I$(INC_DIR) -masm=intel

SRCS := $(wildcard $(SRC_DIR)/*.c)
INCS := $(filter-out $(INC_DIR)/main.h, $(SRCS:$(SRC_DIR)/%.c=$(INC_DIR)/%.h))
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OUT_DIR)/%.o)

APP := app.exe

.PHONY : run clean

run: $(APP)
	@./$(APP)

#$(APP) : CFLAGS += -mno-80387
$(APP) : CFLAGS += -m80387 -DX87

$(APP) : $(OBJS) $(INCS)
	@$(CC) $(CFLAGS) -o $@ $(OBJS)

$(OUT_DIR):
	@mkdir -p $(OUT_DIR)

${OUT_DIR}/%.o : ${SRC_DIR}/%.c $(OUT_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@

$(INC_DIR)/%.h:
	@

clean:
	@$(RM) $(EXEC) ${OUT_DIR}/* ./*.o
	@rm -rf $(OUT_DIR)
