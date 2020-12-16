section .data
array       db   32, 25, 4, 8, 3, 9, 6, 0, 0, 1, 5, 7
array_len   equ   $-array


section .text
global _start

_start:
lea esi,[array]
lea edi,[array+array_len]
call count_ones

exit:
mov eax,1
mov ebx,0
int 80h

count_ones:
xor rax,rax
xor bx,bx
xor dx,dx

repeat_1:
cmp esi,edi
jge end
movzx bx,byte[esi]
  repeat_2:
    bsf dx,bx
    jz inc_esi
    inc rax
    btc bx,dx
    jmp repeat_2

    inc_esi:
      inc esi
      jmp repeat_1

end:
  ret