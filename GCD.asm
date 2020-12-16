;program for compute GCD of two number
;peyman shabani 610395117
;result stored in dx

section .data
d1 db 48
d2 db 72

section .text
global _start
_start:

movsx ax,[d2]
movsx bx,[d1]
call my_gcd

exit:
    mov eax,1
    mov ebx,0
    int 80h

my_gcd:
  cmp ax,bx
  jge my_loop
  xchg ax,bx
  my_loop:
      xor dx,dx
      div bx
      cmp dx,0
      jne swap
      mov dx,bx
      jmp end
      swap:
          mov ax,bx
          mov bx,dx
          jmp my_loop
  end:
ret
