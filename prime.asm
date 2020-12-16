;program for check one number is prime or not
;peyman shabani 610395117
;result stored in r10 register
section .text
global _start

_start:
mov rax,17 ;result tested for 17,11,20
call my_prime

exit:
mov eax,1
mov ebx,0
int 80h

my_prime:
  mov r8,rax
  xor rdx,rdx
  mov rbx,2
  div rbx
  mov rcx,rax
  mov rax,r8
  mov r9,rcx
  mov rcx,2
  while:
    cmp r9,rcx
    jge prime
    mov r10,1
    jmp end

    prime:
      xor rdx,rdx
      mov rax,r8
      div rcx
      inc rcx
      cmp rdx,0
      jne while
      mov r10,0
end:
  ret
