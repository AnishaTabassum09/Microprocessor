global main
extern printf
extern scanf
extern exit

section .data
    in_fmt   db "%d", 0
    out_fmt  db "Max = %d", 10, 0

section .bss
    a   resd 1
    b   resd 1
    res resd 1

section .text
main:
    ; --- Function prologue ---
    push rbp
    mov rbp, rsp
    and rsp, -16

    ; --- Read first number ---
    lea rdi, [rel in_fmt]
    lea rsi, [rel a]
    xor eax, eax
    call scanf

    ; --- Read second number ---
    lea rdi, [rel in_fmt]
    lea rsi, [rel b]
    xor eax, eax
    call scanf

    ; --- Load arguments for max_of_two(a, b) ---
    mov eax, [rel a]
    mov esi, [rel b]
    mov edi, eax          ; edi = first argument
    mov esi, esi          ; esi = second argument
    call max_of_two       ; call function max_of_two(a, b)
    mov [rel res], eax    ; store returned value

    ; --- Print result ---
    mov esi, [rel res]
    lea rdi, [rel out_fmt]
    xor eax, eax
    call printf

    ; --- Exit program ---
    mov rsp, rbp
    pop rbp
    xor edi, edi
    call exit


; =======================================
; Function: max_of_two
; Description: returns the larger of two integers
; Parameters:
;   edi = a
;   esi = b
; Return:
;   eax = max(a, b)
; =======================================
max_of_two:
    push rbp
    mov rbp, rsp

    cmp edi, esi
    jge .a_larger
    mov eax, esi
    jmp .done

.a_larger:
    mov eax, edi

.done:
    pop rbp
    ret

