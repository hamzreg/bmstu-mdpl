.MODEL TINY
.186

SEGCODE    SEGMENT
           ASSUME CS: SEGCODE, DS: SEGCODE
           ORG 100h
main:
    JMP init

    speed        DB 01Fh
    now          DB 0
    fl           DB 19
    old_handler  DD 0

new_handler:
    PUSHA
    PUSH ES
    PUSH DS

    MOV AH, 02h
    INT 1Ah

    CMP DH, now
    MOV now, DH
    JE return_old

    MOV AL, 0F3h
    OUT 60h, AL
    MOV AL, speed
    OUT 60h, AL

    DEC speed
    TEST speed, 01Fh
    JZ make_max_speed
    JMP return_old

    make_max_speed:
        MOV speed, 01Fh

    return_old:
        POP DS
        POP ES
        POPA

        JMP CS: old_handler

init:
    MOV AX, 3508h
    INT 21h

    CMP ES: fl, 19
    JE exit

    MOV word ptr old_handler, BX
    MOV word ptr old_handler + 2, ES

    MOV AX, 2508h 
    MOV DX, offset new_handler
    INT 21h

    MOV DX, offset init
    INT 27h

exit:
    PUSHA
    PUSH ES
    PUSH DS
    PUSHF

    MOV DX, word ptr ES: old_handler
    MOV DS, word ptr ES: old_handler + 2

    MOV AX, 2508h
    INT 21h

    POPF
    POP DS
    POP ES
    POPA

    MOV AX, 4C00h
    INT 21h

SEGCODE    ENDS
END main
