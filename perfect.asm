;program for check one number is perfect or not
;peyman shabani 610395117
;result stored in r9 register


section .data
d1 dq 8128


section .text
global _start
_start:
  mov rax,[d1]
  call my_perfect

exit:
    mov eax,1
    mov ebx,0
    int 80h

my_perfect:
    cmp rax,1
    jle end
    mov r8,rax
    xor r9,r9
    mov rcx,1
    mov rbx,2
    my_loop:
        mov rax,r8
        xor dx,dx
        div rbx
        cmp dx,0
        jne next
        add rcx,rbx
    next:
        inc rbx
        cmp rbx,r8
        jl my_loop
mov rbx,1
cmp rcx,r8
cmovz r9,rbx
end:
ret
