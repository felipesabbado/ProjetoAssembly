section .data                           ;section declaration

MAX_NOME        equ     80

prompt  db      "O seu nome> "          ; mensagem da prompt
len     equ     $ - prompt              ; comprimento da mensagem

greet  db      "Bem vindo "              ; mensagem do cumprimento
glen    equ     $ - greet               ; comprimento da mensagem

nome_len dd     0                       ; comprimento do nome lido

section .bss                            ;section declaration

nome    resb    MAX_NOME                ; buffer para receber nome

section .text                           ;section declaration

                        ;we must export the entry point to the ELF linker or
    global _start       ;loader. They conventionally recognize _start as their
                        ;entry point. Use ld -e foo to override the default.

_start:

; Escreve a prompt

        mov     rdx,len         ;third argument: message length
        mov     rcx,prompt      ;second argument: pointer to message to write
        mov     rbx,1           ;first argument: file handle (stdout)
        mov     rax,4           ;system call number (sys_write)
        int     0x80            ;call kernel

; Lê nome

        mov     rdx,MAX_NOME    ;third argument: comprimento máximo do nome
        mov     rcx,nome        ;second argument: pointer to message to read
        mov     rbx,0           ;first argument: file handle: stdin
        mov     rax,3           ;system call number (sys_read)
        int     0x80            ;call kernel
        mov     [nome_len],eax  ;comprimento do nome lido

; Escreve o cumprimento

        mov     rdx,glen        ;third argument: message length
        mov     rcx,greet       ;second argument: pointer to message to write
        mov     rbx,1           ;first argument: file handle (stdout)
        mov     rax,4           ;system call number (sys_write)
        int     0x80            ;call kernel

; Escreve o nome

        mov     rdx,[nome_len]  ;third argument: message length
        mov     rcx,nome        ;second argument: pointer to message to write
        mov     rbx,1           ;first argument: file handle (stdout)
        mov     rax,4           ;system call number (sys_write)
        int     0x80            ;call kernel

fim:
        ; Sair do programa passando o controlo ao sistema operativo
        mov     rbx,0           ;first syscall argument: exit code
        mov     rax,1           ;system call number (sys_exit)
        int     0x80            ;call kernel
