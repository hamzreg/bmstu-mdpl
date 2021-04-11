EXTERN exit: near
EXTERN input_number: near
EXTERN print_bin_number: near
EXTERN print_dec_number: near
EXTERN print_hex_number: near
EXTERN print_empty_line: near

SEGSTK     SEGMENT PARA STACK  'STACK'
           DB      100  DUP (?)
SEGSTK     ENDS

SEGDATA    SEGMENT PARA PUBLIC 'DATA'
    menu_msg       DB   "Input the command number from the menu:"
                   DB   13
                   DB   10
                   DB   "1 - input of a signed number in 2 notation"
                   DB   13
                   DB   10
                   DB   "2 - print a signed number in 2 notation"
                   DB   13
                   DB   10
                   DB   "3 - print a unsigned number in 10 notation"
                   DB   13
                   DB   10
                   DB   "4 - print a signed number in 16 notation"
                   DB   13
                   DB   10
                   DB   "0 - exit"
                   DB   13
                   DB   10
                   DB   13
                   DB   10
                   DB   "The choice : $"
    func_ptr       DW   5 DUP (0)
SEGDATA    ENDS

SEGCODE    SEGMENT PARA PUBLIC 'CODE'
           ASSUME CS: SEGCODE, DS: SEGDATA, SS:SEGSTK

main:
    MOV AX, SEGDATA
    MOV DS, AX

    MOV func_ptr[0], exit
    MOV func_ptr[2], input_number
    MOV func_ptr[4], print_bin_number
    MOV func_ptr[6], print_dec_number
    MOV func_ptr[8], print_hex_number

    menu:
        call print_empty_line
        MOV AH, 9
        MOV DX, OFFSET menu_msg
        INT 21h

        MOV AH, 1
        INT 21h

        MOV AH, 0
        SUB AL, "0"
        SAL AL, 1
        MOV BX, AX    

        call print_empty_line 
        call print_empty_line

        call func_ptr[BX]

        call print_empty_line
        call print_empty_line

    jmp menu
SEGCODE    ENDS
END main
