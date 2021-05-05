section .text

global asm_strcopy

asm_strcopy:
    mov RCX, RDX
    cmp RDI, RSI
    je exit

not_equal:
    cmp RDI, RSI
    jl copy

    mov RCX, RDX
    mov RAX, RDI
    sub RAX, RSI

    cmp RAX, RCX
    jge copy

    add RDI, RCX
    add RSI, RCX
    dec RSI
    dec RDI

    std ; DF = 1 операция справа налево

copy:
    rep MOVSB
    cld ; DF = 0 операция слева направо

exit:
    ret