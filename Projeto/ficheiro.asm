section   .data

pedido		db	"Insira o nome do ficheiro: "
tpedido		equ	$ - pedido

frase		db	"Olá Mundo"
tamanho		equ	$ - frase


section   .bss

MAX			equ		80
ficheiro	resb	MAX
n_lidos		resd	1
num_fich	resd	1


section   .text

global   _start

_start:
	; Fazer o pedido
	mov eax, 4
	mov ebx, 1
	mov ecx, pedido
	mov edx, tpedido
	int 0x80
	
	; Ler o nome do ficheiro (do teclado)
	mov eax, 3
	mov ebx, 0
	mov ecx, ficheiro
	mov edx, MAX
	int 0x80
	dec eax				; retirar o ENTER da contagem de caracteres
	mov [n_lidos], eax
	
	; Colocar um '\0' no fim do nome do ficheiro
	mov ebx, ficheiro	; ebx aponta para nome do ficheiro
	add ebx, [n_lidos]	; ebx aponta para o fim do nome do ficheiro
	mov byte[ebx], 0	; coloca 0 no fim do nome do ficheiro

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
	mov	ecx, frase		; texto que vamos escrever
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
	