; output доступен из других модулей.
PUBLIC output

; Сегемент, в котором находится латинский алфавит.
DATASTR SEGMENT PARA 'DATA'
    alphabet    DB   'abcdefghijklmnopqrstuvwxyz'
                DB   '$'
DATASTR ENDS

; Сегмент кода, в котором выводится буква алфавита
; с введенным порядковым номером.
SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:DATASTR
output:
    MOV AX, DATASTR
    MOV DS, AX

    ; Вывод "\r" в stdout.
    MOV AH, 2
    MOV DL, 13
    INT 21h

    ; Вывод "\n" в stdout.
    MOV DL, 10
    INT 21h

    ; Вывод буквы в stdout.
    MOV DL, alphabet[SI - 1]
    INT 21h

    MOV AX, 4c00h
    INT 21h
SEGCODE ENDS
END
