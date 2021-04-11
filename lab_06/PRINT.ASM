PUBLIC print_bin_number
PUBLIC print_hex_number
PUBLIC print_dec_number
PUBLIC print_empty_line

EXTERN number: byte

EXTERN hex_number: byte
EXTERN dec_number: byte

SEGDATA    SEGMENT PARA PUBLIC 'DATA'
    print_bin_num_msg   DB     "Entered number: $"
    print_dec_num_msg   DB     "Unsigned number in 10 notation: $"
    print_hex_num_msg   DB     "Signed number in 16 notation: $"
SEGDATA ENDS

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: SEGCODE, DS: SEGDATA

print_bin_number:
    call print_empty_line

    MOV AH, 9
    MOV DX, OFFSET print_bin_num_msg
    INT 21h

    MOV DX, OFFSET number
    INT 21h

    ret

print_dec_number:
    call print_empty_line

    MOV AH, 9
    MOV DX, OFFSET print_dec_num_msg
    INT 21h

    MOV DX, OFFSET dec_number
    INT 21h

    ret

print_hex_number:
    call print_empty_line

    MOV AH, 9
    MOV DX, OFFSET print_hex_num_msg
    INT 21h

    MOV DX, OFFSET hex_number
    INT 21h

    ret

print_empty_line:
    MOV AH, 2
    MOV DL, 13
    INT 21h

    MOV DL, 10
    INT 21h

    ret   

SEGCODE ENDS
END
