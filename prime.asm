global main
extern scanf
extern printf
extern exit

section .data
    in_fmt     db "%d", 0
    out_prime  db "%d is prime", 10, 0
    out_not    db "%d is not prime", 10, 0

section .bss
    x   resd 1

section .text
main:
    ; --- Align stack to 16 bytes before calling C functions ---
    push    rbp
    mov     rbp, rsp
    and     rsp, -16          ; align stack

    ; scanf("%d", &x)
    lea     rdi, [rel in_fmt]
    lea     rsi, [rel x]
    xor     rax, rax
    call    scanf

    ; load x into eax
    mov     eax, dword [rel x]
    cmp     eax, 2
    jb      .not_prime       ; numbers < 2 are not prime
    mov     ecx, 2           ; ecx = divisor

.check_loop:
    cmp     ecx, eax
    jge     .is_prime        ; if divisor >= x, x is prime
    mov     edx, 0
    div     ecx              ; eax / ecx → quotient in eax, remainder in edx
    mov     eax, dword [rel x] ; restore eax = x
    cmp     edx, 0
    je      .not_prime       ; divisible → not prime
    inc     ecx
    jmp     .check_loop

.is_prime:
    ; printf("%d is prime\n", x)
    mov     esi, dword [rel x]
    lea     rdi, [rel out_prime]
    xor     rax, rax
    call    printf
    jmp .exit

.not_prime:
    ; printf("%d is not prime\n", x)
    mov     esi, dword [rel x]
    lea     rdi, [rel out_not]
    xor     rax, rax
    call    printf

.exit:
    ; restore stack and exit
    mov     rsp, rbp
    pop     rbp
    xor     edi, edi
    call    exit



    
    call    exit
