;program for add all digits of number
;result saved in dx register.
;peyman shabani 610395117
section .text
global _start

_start:
mov ax,1755
call digit_sum

exit:
mov eax,1
mov ebx,0
int 80h

digit_sum:
  mov r10w,10
  xor cx,cx
  while:
    xor dx,dx
    div r10w
    add cx,dx
    cmp ax,0
    jne while
  mov dx,cx
  ret
