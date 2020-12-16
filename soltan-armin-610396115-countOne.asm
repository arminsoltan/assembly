section .data
var  dq   70

section .text
global _start
_start:
    mov rbp, rsp
    call count_ons

exit:
mov eax,1
mov ebx,0
int 80h

count_ons:
  xor rcx,rcx
  xor rax,rax
  xor rbx,rbx
  mov rax,[var]
  repeat:
    bsf rcx,rax
    jz end
    inc bl
    btc rax,rcx
    jmp repeat

end:
  ret