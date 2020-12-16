;program for compute LCM (K.M.M) of two number
;peyman Shabani 610395117
;result stored in rdx register


section .data
a dq  125
b dq  25


section .text
global _start

_start:
mov rax,[a]
mov rbx,[b]
call LCM_compute

exit:
mov eax,1
mov ebx,0
int 80h

LCM_compute:
  mov r9,rax
  mov r10,rbx
  cmp rax,rbx
  jge doo
  xchg rax,rbx
  doo:
    xor rdx,rdx
    div rbx
    cmp rdx,0
    jne next
    mov rdx,rbx ;first is multiple of second number or is last step of division
    jmp my_end
    next:
        mov rax,rbx
        mov rbx,rdx
        jmp doo
my_end:
mov rax,r9
mov rbx,r10
mov rcx, rdx
mul rbx
xor rdx, rdx
div rcx
mov rdx, rax
ret
