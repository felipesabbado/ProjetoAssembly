section .data

pedido	db		"Insira uma frase: "
tamanho	equ		$ - pedido

menu	db		"Menu", 10, \
				"1 - Transformar em maiúsculas", 10, \
				"2 - Transformar em minúsculas", 10, 10, \
				"Insira a sua opção: "
tmenu	equ		$ - menu

result	db		"Resultado: "
tres	equ		$ - result

section .bss

MAX		equ		80
frase	resb	MAX

n_lidos	resd	1
opcao	resb	2		; Reserva espaço também para o ENTER

section .text

global	_start

_start:
	; Fazer o pedido
	mov eax, 4
	mov ebx, 1
	mov ecx, pedido
	mov edx, tamanho
	int 0x80
	
	; Ler o teclado
	mov eax, 3
	mov ebx, 0
	mov ecx, frase
	mov edx, MAX
	int 0x80
	mov [n_lidos], eax
	
	; Imprimir o menu
	mov eax, 4
	mov ebx, 1
	mov ecx, menu
	mov edx, tmenu
	int 0x80
	
	; Ler a opção
	mov eax, 3
	mov ebx, 0
	mov ecx, opcao
	mov edx, 2
	int 0x80
	
	; Analisar a opção que o utilizador digitou
	mov al, [opcao]
	cmp al, '1'
	jne compara_2
	; O utilizador escolheu a opção 1
	; Vamos transformar em maiúsculas
	mov esi, frase
	mov edi, frase
	cld
	mov ecx, [n_lidos]
ciclo_1:
	lodsb
	cmp al, 'z'
	jg	nao_minuscula
	cmp al, 'a'
	jl	nao_minuscula
	sub al, 32
nao_minuscula:
	stosb
	loop ciclo_1
	jmp imprime
compara_2:
	cmp al, '2'
	jne sair
	; O utilizador escolheu a opção 2
	; Vamos transformar em minúsculas
	mov esi, frase
	mov edi, frase
	cld
	mov ecx, [n_lidos]
ciclo_2:
	lodsb
	cmp al, 'Z'
	jg	nao_maiuscula
	cmp al, 'A'
	jl	nao_maiuscula
	add al, 32
nao_maiuscula:
	stosb
	loop ciclo_2
	
imprime:
	; Imprime o resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, result
	mov edx, tres
	int 0x80
	
	; Imprimir a frase convertida
	mov eax, 4
	mov ebx, 1
	mov ecx, frase
	mov edx, [n_lidos]
	int 0x80
	
sair:
	mov eax, 1
	mov ebx, 0
	int 0x80
	