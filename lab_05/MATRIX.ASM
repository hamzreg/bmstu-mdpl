PUBLIC input_matrix
PUBLIC change_matrix
PUBLIC output_matrix

DATA     SEGMENT PARA PUBLIC 'DATA'
    rows       DB      1
    columns    DB      1
    matrix     DB      81   DUP ("0")

    sum        DB      1
    i          DB      1
    fl         DB      1
DATA     ENDS

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
        ASSUME CS: SEGCODE, DS: DATA

input_number:
    MOV AH, 01h
    INT 21h
    SUB AL, "0"

    ret

find_count_elements:
    MOV AX, 0
    MOV CX, 0
    MOV AL, rows
    MUL columns
    MOV CX, AX

    ret

input_matrix:
    MOV AX, DATAMATRIX
    MOV DS, AX

    call input_number
    MOV rows, AL
    INT 21h

    call input_number
    MOV columns, AL
    INT 21h

    call find_count_elements

    MOV AH, 1
    MOV BX, 0
    MOV SI, 0
    
input_element:
    MOV AH, 1
    INT 21h
    ADD SI, BX
    MOV matrix[SI], AL
    SUB SI, BX
    INT 21h
    INC BX
    
    MOV AX, BX
    DIV columns
    CMP AH, 0
    JNE next_step
    ADD SI, 9
    MOV BX, 0
next_step:
    LOOP input_element

    ret

change_sum:
    CMP sum, 10
    JL sum_less
    SUB sum, 10
sum_less:
    ret

find_sum:
    MOV DI, CX
    MOV AX, 0
    MOV CX, 0
    MOV AL, columns
    MOV CX, AX
    MOV sum, 0
    MOV fl, 0
    MOV i, 0

sum_element:
    MOV AX, 0
    MOV AL, i
    ADD SI, AX
    CMP matrix[SI], '9'
    JA not_digit
    CMP matrix[SI], '0'
    JB not_digit

    MOV fl, 1
    MOV AX, 0
    MOV AL, matrix[SI]
    SUB AL, '0'
    ADD sum, AL
    call change_sum
    MOV AX, 0
    MOV AL, i
    SUB SI, AX
    INC i
    LOOP sum_element

    MOV CX, DI
    
    ret

not_digit:
    MOV AX, 0
    MOV AL, i
    SUB SI, AX
    INC i
    LOOP sum_element

    MOV CX, DI

    ret

change_matrix:
    call find_count_elements

    MOV BX, 0
    MOV SI, 0
    
compare_element:
    ADD SI, BX
    CMP matrix[SI], '*'
    JNE not_change
    SUB SI, BX
    call find_sum
    CMP fl, 1
    JNE no_digits
    ADD SI, BX
    MOV AX, 0
    ADD sum, '0'
    MOV AL, sum
    MOV matrix[SI], AL
    SUB SI, BX
    INC BX
    
    MOV AX, BX
    DIV columns
    CMP AH, 0
    JNE next_element
    ADD SI, 9
    MOV BX, 0
    LOOP compare_element
    ret
not_change:
    SUB SI, BX
    INC BX

    MOV AX, BX
    DIV columns
    CMP AH, 0
    JNE next_element
    ADD SI, 9
    MOV BX, 0
    LOOP compare_element

    ret
no_digits:
    INC BX

    MOV AX, BX
    DIV columns
    CMP AH, 0
    JNE next_element
    ADD SI, 9
    MOV BX, 0
    LOOP compare_element

    ret
next_element:
    LOOP compare_element

    ret

output_matrix:
    MOV AH, 2
    MOV DL, 13
    INT 21h

    MOV AH, 2
    MOV DL, 10
    INT 21h

    call find_count_elements

    MOV AH, 2
    MOV BX, 0
    MOV SI, 0
    
print_element:
    MOV AH, 2
    ADD SI, BX
    MOV DL, matrix[SI]
    SUB SI, BX
    INT 21h
    INC BX

    MOV AX, BX
    DIV columns
    CMP AH, 0
    MOV AH, 2
    MOV DL, ' '
    INT 21h
    JNE next_print
    MOV AH, 2
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    ADD SI, 9
    MOV BX, 0
next_print:
    LOOP print_element

    ret
    
SEGCODE ENDS
END