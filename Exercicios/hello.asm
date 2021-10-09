section .data                           ;section declaration
msg     db      "Olá Mundo!",0xa        ;our dear string
len     equ     $ - msg                 ;length of our dear string

section .text                           ;section declaration

;we must export the entry point to the ELF linker or
global _start       ;loader. They conventionally recognize _start as their
;entry point. Use ld -e foo to override the default.

_start:

;write our string to stdout

mov     rdx,len ;third argument: message length
mov     rcx,msg ;second argument: pointer to message to write
mov     rbx,1   ;first argument: file handle (stdout)
mov     rax,4   ;system call number (sys_write)
int     0x80    ;call kernel

;and exit

mov     rbx,0   ;first syscall argument: exit code
mov     rax,1   ;system call number (sys_exit)
int     0x80    ;call kernel

