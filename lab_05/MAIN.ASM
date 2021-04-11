; Ввести прямоугольную символьную матрицу.
; Заменить символы * на последнюю цифру суммы
; элементов слева и справа, если они являются цифрами.

EXTRN input_matrix: near
EXTRN change_matrix: near
EXTRN output_matrix: near

SEGSTK     SEGMENT PARA STACK  'STACK'
           DB      100  DUP (?)
SEGSTK     ENDS

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
        ASSUME CS: SEGCODE
main:
    call input_matrix
    call change_matrix
    call output_matrix

    MOV AX, 4c00h
    INT 21h
SEGCODE    ENDS
END main
