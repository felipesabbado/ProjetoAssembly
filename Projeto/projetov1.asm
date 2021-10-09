section .data

pedido	db		"Insira o nome do ficheiro: "
tamanho	equ		$ - pedido

menu	db		"Menu", 10, \
				"1 - Transformar em maiúsculas", 10, \
				"2 - Transformar em minúsculas", 10, \
				"3 - Elimina os sinais de pontuação", 10, \
				"4 - Elimina os algarismos", 10, \
				"5 - Elimina todas as letras", 10, \
				"6 - Exibe apenas os sinais de pontuação", 10, \
				"0 - Sai do programa", 10, 10, \
				"Insira a sua opção: "
t_menu	equ		$ - menu

result	db		"Resultado: "
t_res	equ		$ - result

inval	db		"Opção Inválida! Tente novamente!"
t_inval	equ		$ - inval

section .bss

MAX		equ		10000
fich	resb	MAX
texto	resb	MAX
n_fich	resd	1
n_pedi	resd	1
n_text	resd	1
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
	
	; Ler o nome do ficheiro (do teclado)
	mov eax, 3
	mov ebx, 0
	mov ecx, fich
	mov edx, MAX
	int 0x80
	mov [n_fich], eax

	;Abrir o ficheiro
	mov eax, 5			;Função OPEN
	mov ebx, fich		;Nome do ficheiro que vamos abrir
	mov ecx, 0			;Função READ
	int 0x80			;Invoca o sistema operativo

	;Ler no ficheiro
	mov eax, 3			;Função Read
	mov ebx, [n_fich]	;nº do ficheiro que quero ler
	mov ecx, texto		;Variavel definida na section .bss para onde será lido o conteúdo do ficheiro
	mov edx, MAX		;Tamanho da string
	int 0x80			;Invoca o sistema operativo
	mov [n_text], eax
	
	;Fechar o ficheiro
	mov eax, 6			;Função CLOSE
	mov ebx, [n_fich]	;nº do ficheiro que quero fechar
	int 0x80			;Invoca o sistema operativo
	
	; Colocar um '\0' no fim do nome do ficheiro
	mov eax, [n_fich]
	dec eax				; retirar o ENTER da contagem de caracteres
	mov ebx, fich		; ebx aponta para nome do ficheiro
	add ebx, [n_fich]	; ebx aponta para o fim do nome do ficheiro
	mov byte[ebx], 0	; coloca 0 no fim do nome do ficheiro
	
	;Mandar imprimir o conteúdo do ficheiro
	mov eax, 4			;Função WRITE
	mov ebx, 1			;Saída padrão
	mov ecx, texto		;Texto a ser escrito no ecrã
	mov edx, [n_text]	;nº de bytes a escrever
	int 0x80			;Invoca o S.O.
	
	; Imprimir o menu
	mov eax, 4
	mov ebx, 1
	mov ecx, menu
	mov edx, t_menu
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
	mov esi, texto
	mov edi, texto
	cld
	mov ecx, [n_text]
	
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
	mov esi, texto
	mov edi, texto
	cld
	mov ecx, [n_text]
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
	jmp imprime
	
imprime:
	; Imprime o resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, result
	mov edx, t_res
	int 0x80
	
	; Imprimir a frase convertida
	mov eax, 4
	mov ebx, 1
	mov ecx, texto
	mov edx, [n_text]
	int 0x80
	
sair:
	mov eax, 1
	mov ebx, 0
	int 0x80
	