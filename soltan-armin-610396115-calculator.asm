section .data
msg db 'Enter e to exit',10
msg_len equ $-msg
zero dd 0.0
ten  dd 10.0
hundred dd 100.0
error_msg dd 'invalid operation',10
error_msg_len equ $-error_msg
make_Neg db 0
isNeg db 0
negSign db '-'
lenS equ 1
Ne dd -1.0
;thousand dd 1000.0
section .bss
input resb 100
input_len equ $-input







section .text
global _start

_start:
  movss xmm3 ,dword[zero]
  mov eax ,4
  mov ebx ,1
  mov ecx ,msg
  mov edx ,msg_len
  int 80h

get_input:
  mov eax ,3
	mov ebx ,0
	mov ecx ,input
	mov edx ,input_len
	int 80h

  mov edi ,0
  cmp byte [input] ,'e'
  je exit
  jmp initialize


initialize:
    xor eax ,eax
    xor ebx ,ebx
    movss xmm0 ,dword[zero]
    movss xmm1 ,dword[zero]



evaluate_exp:
  mov bl ,byte [input+edi]
  inc edi
  cmp bl ,'0'
  jb next1
  cmp bl ,'9'
  ja next1
  sub bl ,'0'
  mulss xmm0 ,dword[ten]
  cvtsi2ss xmm1 ,ebx
  addss xmm0 ,xmm1
  jmp evaluate_exp


next1:
  cmp bl ,'.'
	jne next2
	movss xmm2 ,dword[ten]


lp1:
  	mov bl ,byte [input+edi]
  	inc edi
  	cmp bl ,'0'
  	jb next2
  	cmp bl ,'9'
  	ja next2
  	sub bl ,'0'
  	cvtsi2ss xmm1 ,ebx
  	divss xmm1 ,xmm2
  	addss xmm0 ,xmm1
  	mulss xmm2 ,xmm2
  	jmp lp1


next2:
  cmp bl ,'+'
  je add_f
  cmp bl ,'*'
  je mul_f
  cmp bl ,'/'
  je div_f
  cmp bl ,'-'
  je sub_f
  cmp bl ,'='
  je equal_f
  jmp error

error:
  mov eax ,4
  mov ebx ,1
  mov ecx ,error_msg
  mov edx ,error_msg_len
  int 80h


;------------------------------------------------------------
add_f:
  addss xmm3,xmm0
  xor eax,eax
  xor ebx,ebx
  movss xmm0 ,dword[zero]
  movss xmm1 ,dword[zero]

number_2:
  	mov bl ,byte [input+edi]
  	inc edi
  	cmp bl ,'0'
  	jb next_dot
  	cmp bl ,'9'
  	ja next_dot
  	sub bl ,'0'
  	mulss xmm0 ,dword[ten]
  	cvtsi2ss xmm1 ,ebx
  	addss xmm0 ,xmm1
  	jmp number_2

next_dot:
    cmp bl ,'.'
    je continue_number_2

next2A:
    addss xmm0 ,xmm3   ;final number
    jmp print
continue_number_2:
    movss xmm2 ,dword[ten]
float_continue:
    	mov bl ,byte [input+edi]
    	inc edi
    	cmp bl ,'0'
    	jb next2A
    	cmp bl ,'9'
    	ja next2A
    	sub bl ,'0'
    	cvtsi2ss xmm1 ,ebx
    	divss xmm1 ,xmm2
    	addss xmm0 ,xmm1
    	mulss xmm2 ,xmm2
    	jmp float_continue
;------------------------------------------------------------
mul_f:
	addss xmm3 ,xmm0
;	jmp pm
;	mov byte[make_Neg] ,0
;pm:
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
mul_next_num:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb mul_dot
	cmp bl ,'9'
	ja mul_dot
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp mul_next_num
;nextM:
;	cmp bl ,'-'
;	jne M
;	mov byte [make_Neg] ,1
;	jmp pm
mul_dot:
	cmp bl ,'.'
	je nxtM
;next2M:
;	cmp byte [make_Neg] ,1
;	jne m
;	mulss xmm0 ,[Ne]
m:
	mulss xmm0 ,xmm3
	movss xmm3 ,xmm0
	;ucomiss xmm3 ,dword[zero]
	;jae mp
	jmp print
;mp:
;	mov byte [make_Neg] ,0
;	jmp Print
nxtM:
	movss xmm2 ,dword[ten]
continue_mul_num:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb m
	cmp bl ,'9'
	ja m
	sub bl ,'0'
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp continue_mul_num



;-----------------------------------------------------------
div_f:
	addss xmm3 ,xmm0
;pd:
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
div_next_num:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb div_dot
	cmp bl ,'9'
	ja div_dot
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp div_next_num
;nextD:
;	cmp bl ,'-'
;	jne Md
;	cmp byte [make_Neg] ,1
;	jne ne
;	mov byte [make_Neg] ,0
;ne:
;	mov byte [make_Neg] ,1
;	jmp pd
div_dot:
	cmp bl ,'.'
	je nxtD
;next2D:
;	cmp byte [make_Neg] ,1
;	jne md
;	mulss xmm0 ,[Ne]
md:
	ucomiss xmm3 ,dword[zero]
	jae ge
	;mulss xmm3 ,[Ne]
	;mulss xmm0 ,[Ne]
ge:
	divss xmm3 ,xmm0
	movss xmm0 ,xmm3
	;ucomiss xmm3 ,dword[zero]
	;jae mpd
	jmp print
;mpd:
;	mov byte [make_Neg] ,0
;	jmp Print
nxtD:
	movss xmm2 ,dword[ten]
continue_div_num:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb ge
	cmp bl ,'9'
	ja ge
	sub bl ,'0'
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp continue_div_num


;----------------------------------------------------------
sub_f:

	ucomiss xmm3 ,dword[zero]
	je fo
	;subss xmm3 ,xmm0
	;ucomiss xmm3 ,dword[zero]
	;jge mps
  jg mps ;new
	movss xmm0 ,xmm3
	jmp print
mps:
	mov byte [make_Neg] ,0
	;movss xmm0 ,xmm3
	;jmp print
  jmp ps  ;new
fo:
	addss xmm3 ,xmm0
	cmp byte[make_Neg] ,1
	jmp ps
	mulss xmm3 ,[Ne]
	mov byte[make_Neg] ,0
ps:
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
topS:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextS
	cmp bl ,'9'
	ja nextS
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp topS
nextS:
	;cmp bl ,'-'
	;je ad1
	cmp bl ,'.'
	je nxtS
next2S:
	subss xmm3 ,xmm0
	movss xmm0 ,xmm3
	jmp print
nxtS:
	movss xmm2 ,dword[ten]
lpS:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next2S
	cmp bl ,'9'
	ja next2S
	sub bl ,'0'
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp lpS
ad1:
	movss xmm0 ,xmm3
	movss xmm3 ,dword[zero]
	jmp add_f

;----------------------------------------------------------
equal_f:
;-----------------------------------------------------------
print:
  movss xmm3 ,xmm0
	mulss xmm0 ,dword[hundred]
  ;mulss xmm0 ,dword[thousand]
	cvtss2si eax ,xmm0
	mov rcx ,0
	mov ebx ,10
	ucomiss xmm3 ,dword[zero]
  jmp divLp

divLp:
	xor edx ,edx
	div ebx
	push rdx
	inc rcx
	cmp eax ,0
	jne divLp
	mov edi ,0

popLp:
  	pop rax
  	add al ,'0'
  	cmp rcx ,2
  	jne nx
  	mov byte [input+edi] ,'.'
  	inc edi

nx:
    mov byte [input+edi] ,al
    inc edi
    loop popLp
    mov byte [input+edi] ,0
    inc edi

Prp:
    mov eax ,4
    mov ebx ,1
    mov ecx ,input
    mov edx ,edi
    int 80h
    jmp get_input


;-------------------------------------------------------------


exit:
mov rax,1
mov rbx,0
int 80h
