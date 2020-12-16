;peyman shabani 610395117
;bubble sort


; i r al
; c
; for check whole sorted_array you can repeat line 11 , 10

section .data
    unsorted_array db 7,2,6,1,3,5,9,2,4
    len equ $ - unsorted_array

section .bss
    sorted_array resb len

section .text
    global _start

_start:
    mov rsi, unsorted_array
    mov rdi, sorted_array
    mov rcx, len
    transfer_array:
        mov al, [rsi]
        mov [rdi], al
        inc rsi
        inc rdi
        loop transfer_array
    call bubble_sort

exit:
    mov rax, 1
    mov rbx, 0
    int 80h

bubble_sort:
    mov cx, len
    loop1:
        cmp cx, 0
        je end_loop1
        mov rsi, sorted_array
        mov rdi, sorted_array
        inc rdi
        mov dx, 1
        loop2:
            cmp dx, cx
            jge end_loop2
            mov al, byte[rsi]
            cmp al, byte[rdi]
            jle next
            mov bl, byte[rdi]
            mov [rdi], al
            mov [rsi], bl
            next:
            inc dx
            inc rdi
            inc rsi
            jmp loop2
        end_loop2:
        dec cx
        jmp loop1
    end_loop1:
    ; test the sorted_array
    mov rsi, sorted_array
    mov cx, len
    test_array:
        mov al, byte[rsi]
        inc rsi
        loop test_array
    ret
