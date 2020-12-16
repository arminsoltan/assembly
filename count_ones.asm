;program for count number of bits with value one in rax
;peyman shabani 610395117
;result stored in cx register
;test cases are 70 and 128 and program worked correctly!
section .data
var  dq   70


section .text
global _start

_start:
call count_ons


exit:
mov eax,1
mov ebx,0
int 80h

count_ons:
  xor cx,cx
  xor rax,rax
  xor rbx,rbx
  mov rax,[var]
  repeat:
    bsf rbx,rax
    jz end
    inc cx
    btc rax,rbx
    jmp repeat

end:
  ret
