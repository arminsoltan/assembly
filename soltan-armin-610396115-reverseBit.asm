
section .data
    d1 dq 0x24
    d2 dq 0x36
section .text
    global _start
    
_start:
    mov rbp, rsp; for correct debugging
    mov r10, [d1]
    mov r11, [d2]
    mov rax, r10
    call BitwiseReverse
    mov r8, rdx
    xor rax, rax
    xor rcx, rcx
    mov rax, r11
    call BitwiseReverse
    mov r9, rdx
    call exit
    ret
    

exit:
    mov rax, 1
    mov rbx, 0
    int 80h

BitwiseReverse:
    mov rdx, 0
    doo:
        mov rbx, 63
        bsf rcx, rax
        jz end
        sub rbx, rcx
        sub rbx, rcx
        bts rdx, rbx
        btc rax, rcx
        jmp doo
    end:
        ret
        