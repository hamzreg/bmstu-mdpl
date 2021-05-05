section .text

global asm_strcopy

asm_strcopy:
    mov RCX, RDX
    cmp RDI, RSI
    je exit
    jl copy

not_equal:
    mov RCX, RDX
    mov RAX, RDI
    sub RAX, RSI

    cmp RAX, RCX
    jge copy

    add RDI, RCX
    add RSI, RCX
    dec RSI
    dec RDI

    std

copy:
    rep MOVSB
    cld

exit:
    ret