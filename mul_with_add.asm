;multiplication using adding algorithm
;result saved in rax reg.
;peyman shabani
section .text
    global _start

_start:
    mov eax, -200
    mov ebx, 18
    call my_multiplication

exit:
    mov rax, 1
    mov rbx, 0
    int 80h

my_multiplication:
    xor r8, r8
    xor rcx, rcx
    cmp eax, 0
    cmove eax, ecx
    je end
    jl negative1
    check2:
    cmp ebx, 0
    cmove eax, ecx
    je end
    jl negative2
    continue:
    mov ecx, ebx
    mov rdx, rax
    dec ecx
    while:
        add rax, rdx
        loop while
    cmp r8, 1
    jne end
    neg rax
    end:
    ret

    negative1:
    neg eax
    inc r8
    jmp check2

    negative2:
    neg ebx
    inc r8
    jmp continue
