global _start

SECTION .data
sys_exit equ 60
sys_write equ 1
sys_time equ 0xc9

stdout equ 1

msg db 'Hello, world!', 10
msg_len equ $ - msg

curtime dq 1723384145 ; default value

currtime_ascii db '0000000000', 10
currtime_ascii_len equ $ - currtime_ascii

SECTION .text
_start:
    ; get current epoch time
    mov rax, sys_time
    mov rdi, curtime
    syscall

    lea rbx, [currtime_ascii + 9]

    mov rax, [curtime]
    mov rcx, 10
convert_char:
    xor rdx, rdx
    div rcx

    add rdx, 0x30
    mov [rbx], dl

    dec rbx

    cmp rax, 0

    jnz convert_char

    ; print current time
    mov rax, sys_write
    mov rdi, stdout
    mov rsi, currtime_ascii
    mov rdx, 11
    syscall

    ; exit
    mov rax, sys_exit
    mov rdi, 0
    syscall
