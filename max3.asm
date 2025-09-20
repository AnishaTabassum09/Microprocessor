global main
extern scanf
extern printf
extern exit

section .data
    in_fmt     db "%d %d %d", 0
    out_fmt    db "Maximum = %d", 10, 0

section .bss
    a   resd 1
    b   resd 1
    c   resd 1

section .text
main:
    ; --- Align stack to 16 bytes before calling C functions ---
    push    rbp
    mov     rbp, rsp
    and     rsp, -16          ; align stack

    ; scanf("%d %d %d", &a, &b, &c)
    lea     rdi, [rel in_fmt]
    lea     rsi, [rel a]
    lea     rdx, [rel b]
    lea     rcx, [rel c]      ; 4th argument for scanf
    xor     rax, rax           ; varargs requires rax = 0
    call    scanf

    ; load variables
    mov     eax, dword [rel a]  ; eax = a
    mov     ebx, dword [rel b]  ; ebx = b
    mov     ecx, dword [rel c]  ; ecx = c

    ; assume eax is maximum
    mov     edx, eax             ; edx = max

    ; compare with b
    cmp     ebx, edx
    jle     .check_c
    mov     edx, ebx             ; max = b

.check_c:
    cmp     ecx, edx
    jle     .print
    mov     edx, ecx             ; max = c

.print:
    ; printf("Maximum = %d\n", max)
    mov     esi, edx             ; 2nd arg = max
    lea     rdi, [rel out_fmt]   ; 1st arg = format
    xor     rax, rax
    call    printf

    ; restore stack and exit
    mov     rsp, rbp
    pop     rbp
    xor     edi, edi
    call    exit

