PUBLIC get_real_number
PUBLIC get_twos_complement

PUBLIC get_dec_number
PUBLIC get_hex_number

EXTERN number: byte
EXTERN len: byte

EXTERN dec_len: byte
EXTERN dec_number: byte

EXTERN hex_len: byte
EXTERN hex_number: byte

EXTERN real_number: near
EXTERN complement: near

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: SEGCODE

get_real_number:
    XOR CX, CX

    MOV CL, len
    DEC CX
    MOV SI, CX

    MOV BX, 1

    translate_real:
        XOR AX, AX
        MOV AL, number[SI]
        SUB AX, "0"
        MUL BX
        ADD word ptr[real_number], AX

        SAL BX, 1
        DEC SI

        loop translate_real
    
    ret

get_twos_complement:
    MOV AX, word ptr[real_number]
    MOV word ptr[complement], AX
    NEG word ptr[complement]

    ret

get_dec_number:
    XOR BX, BX
    CMP number[BX], "-"
    JE downoload_complement

    MOV AX, word ptr[real_number]

    start_translate_dec:
        MOV SI, 4
        XOR DX, DX
        MOV BX, 10

        translate_dec:
            DIV BX
            MOV dec_number[SI], DL
            ADD dec_number[SI], "0"
            INC dec_len

            DEC SI
            XOR DX, DX
            CMP AX, 0
            JNE translate_dec

        ret

    downoload_complement:
        MOV AX, word ptr[complement]
        JMP start_translate_dec

get_hex_number:
    XOR CX, CX

    MOV BX, 16
    MOV SI, 4
    MOV AX, word ptr[real_number]
    XOR DX, DX

    translate_hex:
        DIV BX
        MOV hex_number[SI], DL

        CMP DL, 9
        JG translate_symbol
        ADD hex_number[SI], "0"

        continue_translate_hex:
            XOR DX, DX
            INC hex_len

        DEC SI
        CMP AX, 0
        JNE translate_hex
    
    XOR BX, BX
    MOV DH, number[BX]
    MOV hex_number[BX], DH

    XOR BX, BX
    MOV BL, 4
    SUB BL, hex_len
    MOV CL, BL

    end_translate_hex:
        ret

    translate_symbol:
        ADD hex_number[SI], 55
        JMP continue_translate_hex

SEGCODE ENDS
END
