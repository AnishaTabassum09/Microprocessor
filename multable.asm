global main
extern scanf
extern printf
extern exit

section .data
    fmt_in     db "%d", 0
    fmt_out    db "%d x %d = %d", 10, 0   ; "%d x %d = %d\n"

section .bss
    n    resd 1    ; input number
    i    resd 1    ; loop counter
    res  resd 1    ; multiplication result

section .text
main:
    ;--- prologue ---
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16          ; align stack

    ; scanf("%d", &n)
    lea     rdi, [rel fmt_in]
    lea     rsi, [rel n]
    xor     eax, eax
    call    scanf

    ; i = 1
    mov     dword [i], 1

.loop_start:
    mov     eax, dword [i]
    cmp     eax, 10
    jg      .done             ; exit when i > 10

    ; res = n * i
    mov     eax, dword [n]
    imul    eax, dword [i]
    mov     dword [res], eax

    ; printf("%d x %d = %d\n", n, i, res)
    lea     rdi, [rel fmt_out]
    mov     esi, dword [n]    ; 1st %d = n
    mov     edx, dword [i]    ; 2nd %d = i
    mov     ecx, dword [res]  ; 3rd %d = res
    xor     eax, eax
    call    printf

    ; i++
    mov     eax, dword [i]
    add     eax, 1
    mov     dword [i], eax

    jmp     .loop_start

.done:
    ;--- epilogue ---
    add     rsp, 16
    pop     rbp

    xor     edi, edi
    call    exit
