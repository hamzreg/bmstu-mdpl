; Программа состоит из двух модулей. В каждом модуле
; сегмент кода, которые объединяются в один.
; В первом модуле осуществляется ввод порядкового
; номера буквы алфавита.
; Во втором модуле осуществляется вывод буквы 
; латинского алфавита с введенными порядковым номером.

; output определен в другом модуле.
EXTRN output: near

; Сегмент стека.
SEGSTK     SEGMENT PARA STACK  'STACK'
           DB      100  DUP (?)
SEGSTK     ENDS

; Сегмент данных, для порядкового номера буквы.
DATANUM    SEGMENT PARA PUBLIC 'DATA'
    maxlen DB      3        ; Максимальная возможная длина числа.
    nowlen DB      0        ; Реальная длина числа.
    number DB      3 DUP(0) ; Строка, в которой находится число.
DATANUM ENDS

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: SEGCODE, DS: DATANUM

    ; Ввод строки из stdin - порядкового номера числа.
input:
    MOV DX, OFFSET maxlen
    MOV AH, 0Ah
    INT 21h
    ret

    ; Перевод строки в число.
translate:
    MOV BL, number[DI]
    SUB BL, "0"    ; Цифра = Код цифры - код символа "0".
    MUL CL         ; Умножение цифры на 10.
    ADD AX, BX     ; Добавление текущей части числа.
    INC DI
    CMP DI, SI     ; Если DI + 1 меньше, чем длина числа,
    JB translate   ; продолжать перевод.
    ret

main:
    mov AX, DATANUM
    mov DS, AX

    call input

    ; Установка начальных значений для перевода строки
    ; в число.
    MOV AX, 0      ; AX хранит значение переведенной
                   ; части числа.
    MOV BX, 0      ; BX хранит текущую цифру.
    MOV DI, 0      ; Номер байта в строке.

    MOV CL, nowlen ; Установка текущей длины в SI.
    MOV SI, CX

    MOV CL, 10     ; Множитель для перевода числа.
    
    call translate

    MOV SI, AX
    JMP output

SEGCODE ENDS
END main
