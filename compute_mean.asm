;peyman shabani 610395117
;program for compute mean of 100 floating point values.
; i r st0
section .data
    src dq 1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1,\
            1.e0,2.e0,3.e0,4.e0,5.e0,6.e0,7.e0,8.e0,9.e0,1.e1
    len equ ($-src)/8
    var dq 0

section .bss
    arr resq len

section .text
    global _start

_start:
    mov rsi, src
    mov rdi, arr
    mov rcx, len
    transfer_while:
        mov rax, [rsi]
        mov [rdi], rax
        add rsi, 8
        add rdi, 8
        loop transfer_while
    call compute_mean

exit:
    mov rax, 1
    mov rbx, 0
    int 80h

compute_mean:
    mov rsi, arr
    mov rcx, len
    mov [var], rcx
    fild qword[var]
    fldz
    add_loop:
        dec rcx
        fadd qword[rsi+rcx*8]
        cmp rcx, 0
        jnz add_loop
    fdiv ST1
    fst qword[var]
    ret
