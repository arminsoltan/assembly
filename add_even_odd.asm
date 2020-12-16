;program for adding numbers in differnt odd and even position
;peyman shabani 610395117
section .text
global _start

_start:
mov ax,1888
call dif_digit_sum

exit:
mov eax,1
mov ebx,0
int 80h

dif_digit_sum:
  xor cx,cx
  mov cx,1
  xor r12w,r12w ;contain even summation
  xor r13w,r13w ;contain odd summation
doo:
  xor dx,dx
  mov r9w,10
  div r9w
  mov r10w,dx
  mov r11w,ax
  mov ax,cx
  xor dx,dx
  mov r9w,2
  div r9w
  cmp dx,0
  jg odd
  add r12w,r10w
  jmp next_step
  ;mov ax,r11w
  odd:
    add r13w,r10w
  next_step:
    mov ax,r11w
    inc cx
    cmp ax,0
    jne doo

mov bx,r12w ;bx even summation
mov dx,r13w ;dx odd summation

ret
