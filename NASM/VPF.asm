    extern printf, malloc
    global main

; Assembler gave the following error:
;   missing .note.GNU-stack section implies executable stack

; In order to fix this, we add the following line.
section .note.GNU-stack noalloc noexec nowrite progbits

; noalloc - Does not allocate space in the program's memory at runtime
; noexec - does not require an executable stack
; nowrite - the section is not writable. Section is read only
; progbits -  contains program data. It is a common type for sections that hold executable code or data used during
; program execution

; 64 Bit Mode
bits 64

    section .data

fmt: db "Name: %s, ID: %d", 10, 0
name: db "InverseDerivative", 0

    section .text

PointerFun:

    push    rbp
    mov     rbp, rsp
    sub     rsp, 16
    mov     QWORD [rbp-16], rdi ; Move void pointer to the stack
    mov     rax, QWORD [rbp-16] ; Move void ptr to rax
    mov     QWORD [rbp-8], rax  ; Move beginning (ID) of void ptr to rbp-8
    mov     rax, QWORD [rbp-8]  ; Load ID from the Person Struct
    mov     edx, DWORD [rax]    ; Third argument to printf (i.e. %d -- ID)
    mov     rax, QWORD [rbp-8]  ; Load Person Struct to accumulator
    mov     rax, QWORD [rax+8]  ; Load Name char* from Person struct to accumulator (i.e. next 8 bytes)
    mov     rsi, rax            ; Second argument to printf (i.e. %s -- Name)
    mov     edi, fmt            ; First Argument to printf (fmt)
    xor     rax, rax            ; Move 0 to RAX
    call    printf
    nop
    leave
    ret

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16
    mov     edi, 16             ; Size of Person struct
    call    malloc

    mov     QWORD [rbp-8], rax  ; Move ptr address to stack
    mov     rax, QWORD [rbp-8]
    mov     QWORD [rax+8], name ; Move "InverseDerivative" to struct's second member
    mov     rax, QWORD [rbp-8]  ; Move new struct to stack
    mov     DWORD [rax], 1001
    mov     rax, QWORD [rbp-8]
    mov     rdi, rax
    call    PointerFun
    xor     rax, rax
    leave
    ret