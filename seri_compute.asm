;peyman shabani 610395117
;seri compute recursively
section .data
var_n dq 5
var_x dq 5.e0


section .text
    global _start

_start:
   push qword[var_n]
   push qword[var_x]
   call seri_compute

exit:
    mov rax, 1
    mov rbx, 0
    int 80h


seri_compute:

          enter 8, 0
          mov rcx, [rbp+24]
          xor rax, rax
          fldz
          fld qword[rbp+16]
          fld1
          fld1
          fldz
          my_while:
              inc rax
              cmp rax, rcx
              jg finish
              mov [rbp-8], rax
              fild qword[rbp-8]
              fmulp st2
              fld st2
              fmul st4
              fstp st3
              fld st2
              fdiv st2
              faddp st1
              jmp my_while
    finish:
      leave
      ret 16
