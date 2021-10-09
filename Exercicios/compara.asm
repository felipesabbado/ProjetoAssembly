section .data

pedido	db	"Introduza uma string: "
tamanho	equ	$ - pedido

iguais	db	"Strings iguais", 10
tigu	equ	$ - iguais

diferentes db	"Strings diferentes", 10
tdif	   equ	$ - diferentes

section .bss

MAX		equ		80
str1	resb	MAX
str2	resb	MAX

tam1	resd	1
tam2	resd	1

section .text

global _start

_start:
	; Pedir a primeira String
	mov eax, 4
	mov ebx, 1
	mov ecx, pedido
	mov edx, tamanho
	int 0x80
	
	; Ler a primeira String
	mov eax, 3
	mov ebx, 0
	mov ecx, str1
	mov edx, MAX
	int 0x80
	mov [tam1], eax
	
	; Pedir a segunda String
	mov eax, 4
	mov ebx, 1
	mov ecx, pedido
	mov edx, tamanho
	int 0x80
	
	; Ler a segunda String
	mov eax, 3
	mov ebx, 0
	mov ecx, str2
	mov edx, MAX
	int 0x80
	mov [tam2], eax
	
	; Comparar os tamanhos das Strings
	mov eax, [tam1]
	cmp eax, [tam2]
	jne strings_diferentes		; Jump if not equals
	
	; Comparar os conteúdos das Strings
	mov esi, str1				; Extend Source Index
	mov edi, str2
	cld
	mov ecx, [tam1]
repe cmpsb
	je strings_iguais
	
strings_diferentes:
	; Imprimir mensagem
	mov eax, 4
	mov ebx, 1
	mov ecx, diferentes
	mov edx, tdif
	int 0x80
	jmp sair					; Jump incondicional

strings_iguais:
	; Imprimir mensagem
	mov eax, 4
	mov ebx, 1
	mov ecx, iguais
	mov edx, tigu
	int 0x80
		
sair:
	; Sair do programa
	mov eax, 1
	mov ebx, 0
	int 0x80