section .data

MAX_LINHA	equ	80

pedido	db	"Insira palavra> "
tamped	equ	$ - pedido

result	db	"Palavra em min?sculas: "
tamres 	equ	$ - result

num_lidos	dd	0


section .bss

palavra	resb	MAX_LINHA


section .text

global _start

_start:
	mov	eax, ds
	mov	es, eax
	
	; Pedir a palavra
	mov	edx, tamped
	mov	ecx, pedido
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	
	; Ler palavra
	mov	edx, MAX_LINHA
	mov	ecx, palavra
	mov	ebx, 0
	mov	eax, 3
	int	0x80
	mov	[num_lidos], eax
	
	; Converter mai?sculas em min?scula
	mov	esi, palavra
	mov	edi, palavra
	cld			; apaga flag de direc??o, DF=0
	mov	ecx, [num_lidos]
ciclo:
	lodsb
	cmp	al, 'Z'
	jg	nao_maiuscula
	cmp	al, 'A'
	jb	nao_maiuscula
	add	al, 32
nao_maiuscula:
	stosb
	loop	ciclo
	
	; Imprime mensagem resultado
	mov	edx, tamres
	mov	ecx, result
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	
	; Imprime palavra
	mov	edx, [num_lidos]
	mov	ecx, palavra
	mov	ebx, 1
	mov	eax, 4
	int	0x80

	; Sair	
	mov	ebx, 0
	mov	eax, 1
	int	0x80
	