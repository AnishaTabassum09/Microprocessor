global main
extern printf, scanf

section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    result_msg db "Sum = %d", 10, 0      ; %d with newline
    input_fmt db "%d", 0

section .bss
    num1 resd 1      ; reserve space for integer
    num2 resd 1
    result resd 1

section .text

main:
    ; Print prompt1
    lea rdi, [prompt1]
    xor eax, eax
    call printf

    ; Read num1
    lea rdi, [input_fmt]
    lea rsi, [num1]
    xor eax, eax
    call scanf

    ; Print prompt2
    lea rdi, [prompt2]
    xor eax, eax
    call printf

    ; Read num2
    lea rdi, [input_fmt]
    lea rsi, [num2]
    xor eax, eax
    call scanf

    ; Load values into registers
    mov eax, [num1]
    mov ebx, [num2]

    ; Call sum function
    call sum
    mov [result], eax   ; store returned sum

    ; Print result
    lea rdi, [result_msg]
    mov esi, [result]
    xor eax, eax
    call printf

    ; Exit program
    xor eax, eax
    ret


sum:
    ; eax = num1
    ; ebx = num2
    add eax, ebx
    ret


