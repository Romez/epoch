global _start

SECTION .bss
	curtime resq 1
    currtime_ascii resb 11

SECTION .data
	sys_exit equ 60
	sys_write equ 1
	sys_time equ 0xc9

	stdout equ 1

SECTION .text
_start:
	;; get current epoch time
	mov rax, sys_time
	mov rdi, curtime
	syscall

	mov rdi, [curtime]
    mov rsi, currtime_ascii
	call int_to_ascii

    mov byte [currtime_ascii + rax], 10
    inc rax

    ; print time
    mov rdi, stdout
    mov rsi, currtime_ascii
    mov rdx, rax
    mov rax, sys_write
    syscall

    ; exit
    mov rax, sys_exit
    mov rdi, 0
    syscall

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