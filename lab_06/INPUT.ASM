PUBLIC input_number

PUBLIC number
PUBLIC len

PUBLIC dec_len
PUBLIC dec_number

PUBLIC hex_len
PUBLIC hex_number

PUBLIC real_number
PUBLIC complement

EXTERN get_real_number: near
EXTERN get_twos_complement: near

EXTERN get_dec_number: near
EXTERN get_hex_number: near

SEGDATA    SEGMENT PARA PUBLIC 'DATA'
    max_len        DB   19
    len            DB   0
    number         DB   19 DUP ("$")

    dec_len        DB   0
    dec_number     DB   5 DUP ("0")
                   DB   "$"

    hex_len        DB   0
    hex_number     DB   5 DUP ("0")
                   DB   "$"

    real_number    DW   0
    complement     DW   0

    input_msg      DB   "Enter number: $"
SEGDATA ENDS

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: SEGCODE, DS:SEGDATA

nullify:
    MOV len, 0
    MOV AX, SEG number
    MOV ES, AX
    MOV DI, OFFSET number
    MOV AL, "$"
    MOV CX, 19
    REP STOSB

    MOV dec_len, 0
    MOV AX, SEG dec_number
    MOV ES, AX
    MOV DI, OFFSET dec_number
    MOV AL, "0"
    MOV CX, 5
    REP STOSB

    MOV hex_len, 0
    MOV AX, SEG hex_number
    MOV ES, AX
    MOV DI, OFFSET hex_number
    MOV AL, "0"
    MOV CX, 5
    REP STOSB

    MOV word ptr[real_number], 0
    MOV word ptr[complement], 0

    ret

input_number:
    call nullify

    MOV AH, 9
    MOV DX, OFFSET input_msg
    INT 21h

    MOV AH, 0Ah
    MOV DX, OFFSET max_len
    INT 21h
    
    call get_real_number
    call get_twos_complement
    call get_dec_number
    call get_hex_number

    ret

SEGCODE ENDS
END
