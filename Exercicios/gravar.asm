section   .data

ficheiro	db	"teste.txt", 0		; nome do ficheiro

texto		db	"Olá Mundo"
tamanho		equ	$ - texto


section   .bss

num_fich	resd	1


section   .text

global   _start

_start:

	; Abrir o ficheiro/arquivo
	mov	eax, 5			; Função OPEN
	mov	ebx, ficheiro	; Nome do ficheiro que vamos abrir
	mov	ecx, 01101q		; Modo de abertura: Write+Create+Truncate
	mov	edx, 0660q		; Permissões de acesso ao ficheiro
	int	0x80
	mov	[num_fich], eax	; Guardar número do ficheiro aberto
	
	; Escrever no ficheiro
	mov	eax, 4			; Função WRITE
	mov	ebx, [num_fich]	; nº do ficheiro onde quero escrever
	mov	ecx, texto		; texto que vamos escrever
	mov	edx, tamanho	; tamanho da string
	int	0x80
	
	; Fechar o ficheiro
	mov	eax, 6			; Função CLOSE
	mov	ebx, [num_fich]	; nº do ficheiro que quero fechar
	int	0x80
	
	; Sair
	mov	eax, 1			; Função EXIT
	mov	ebx, 0			; Código de retorno
	int	0x80
	