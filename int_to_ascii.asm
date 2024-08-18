global int_to_ascii

SECTION .text

; return len in rax
int_to_ascii:
    push rbp
    mov rbp, rsp

    push r9
    push r10
    push rdi
    push rsi
    push rdx

    ; ------

    mov r9, 0
    mov r10, 10
    
    mov rax, rdi

.push_ascii:
    xor rdx, rdx
    div r10

    push rdx

    inc r9
    cmp rax, 0
    jnz .push_ascii

    mov r10, r9
.add_char:
    pop rdx
    add rdx, 0x30

    mov [rsi], rdx
    inc rsi

    dec r9
    cmp r9, 0
    jnz .add_char

    mov rax, 10

    ; --------

    pop rdx
    pop rsi
    pop rdi
    pop r10
    pop r9

    leave
    ret