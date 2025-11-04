global main
extern printf
extern scanf
extern exit

section .data
    in_fmt      db "%d",0
    out_fmt     db "%d ",0
    out_newline db 10,0

section .bss
    A       resd 4          ; 2x2 matrix, row-major
    B       resd 4
    C       resd 4

section .text
main:
    ; --- Function prologue ---
    push rbp
    mov rbp, rsp
    and rsp, -16

    ; --- Read matrix A ---
    mov ecx, 0
.read_A:
    cmp ecx, 4
    jge .read_B
    lea rdi, [rel in_fmt]
    lea rsi, [A + rcx*4]
    xor eax, eax
    call scanf
    inc ecx
    jmp .read_A

.read_B:
    mov ecx, 0
.read_B_loop:
    cmp ecx, 4
    jge .compute
    lea rdi, [rel in_fmt]
    lea rsi, [B + rcx*4]
    xor eax, eax
    call scanf
    inc ecx
    jmp .read_B_loop

.compute:
    mov ecx, 0
.compute_loop:
    cmp ecx, 4
    jge .print
    mov eax, [A + rcx*4]
    and eax, [B + rcx*4]
    mov [C + rcx*4], eax
    inc ecx
    jmp .compute_loop

.print:
    mov ecx, 0
.print_loop:
    cmp ecx, 4
    jge .exit
    mov eax, [C + rcx*4]
    lea rdi, [rel out_fmt]
    mov esi, eax
    xor eax, eax
    call printf

    ; Print newline after each row
    cmp ecx, 1
    je .newline1
    cmp ecx, 3
    je .newline2
    inc ecx
    jmp .print_loop

.newline1:
    lea rdi, [rel out_newline]
    xor eax, eax
    call printf
    inc ecx
    jmp .print_loop

.newline2:
    lea rdi, [rel out_newline]
    xor eax, eax
    call printf
    inc ecx
    jmp .print_loop

.exit:
    mov rsp, rbp
    pop rbp
    xor edi, edi
    call exit

