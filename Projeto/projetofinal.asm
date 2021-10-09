section .data

pedido		db		"Insira o nome do ficheiro: "
t_pedido	equ		$ - pedido

conteudo	db		" ", 10, \
					"Texto do ficheiro: ", 10
t_cont		equ		$ - conteudo

menu	db		" ", 10, \
				"Menu", 10, \
				"1 - Transformar em maiúsculas", 10, \
				"2 - Transformar em minúsculas", 10, \
				"3 - Elimina os sinais de pontuação", 10, \
				"4 - Elimina os algarismos", 10, \
				"5 - Elimina todas as letras", 10, \
				"6 - Exibe apenas os sinais de pontuação", 10, \
				"0 - Sai do programa", 10, 10, \
				"Insira a sua opção: "
t_menu	equ		$ - menu

result	db		"Resultado: ", 10
t_res	equ		$ - result

inval	db		"Opção Inválida! Tente novamente!", 10
t_inval	equ		$ - inval

section .bss

T_MAX		equ		10000
ficheiro	resb	T_MAX
texto		resb	T_MAX
texto2		resb	T_MAX
n_texto		resb	1
n_lidos		resd	1
n_fich		resd	1
opcao		resb	2		; Reserva espaço também para o ENTER

section .text

global _start

_start:
	; Fazer o pedido
	mov eax, 4
	mov ebx, 1
	mov ecx, pedido
	mov edx, t_pedido
	int 0x80
	
	; Ler o nome do ficheiro (do teclado)
	mov eax, 3
	mov ebx, 0
	mov ecx, ficheiro
	mov edx, T_MAX
	int 0x80
	dec eax
	mov	[n_fich], eax
	
	; Colocar um '\0' no fim do nome do ficheiro
	mov ebx, ficheiro	; ebx aponta para nome do ficheiro
	add ebx, [n_fich]	; ebx aponta para o fim do nome do ficheiro
	mov byte[ebx], 0	; coloca 0 no fim do nome do ficheiro
	
	;Abrir o ficheiro
	mov eax, 5
	mov ebx, ficheiro
	mov ecx, 0
	int 0x80
	mov [n_fich], eax
	
	;Ler o ficheiro
	mov eax, 3
	mov ebx, [n_fich]
	mov ecx, texto
	mov edx, T_MAX
	int 0x80
	mov [n_texto], eax
	
	;Fechar o ficheiro
	mov eax, 6
	mov ebx, [n_fich]
	int 0x80
	
	;Mandar imprimir o conteúdo do ficheiro
	mov eax, 4
	mov ebx, 1
	mov ecx, conteudo
	mov edx, t_cont
	int 0x80
	
	mov eax, 4			;Função WRITE
	mov ebx, 1			;Saída padrão
	mov ecx, texto		;Texto a ser escrito no ecrã
	mov edx, [n_texto]	;nº de bytes a escrever
	int 0x80			;Invoca o S.O.
	
menu1:
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
	
	; Prepara o texto do ficheiro para ser transformado
	mov esi, texto
	mov edi, texto2
	cld
	mov ecx, [n_texto]
	
	; Analisar a opção que o utilizador digitou
	mov al, [opcao]
	cmp al, '1'
	jne compara_2
	; O utilizador escolheu a opção 1
	; Vamos transformar em maiúsculas
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
	jne compara_3
	; O utilizador escolheu a opção 2
	; Vamos transformar em minúsculas
ciclo_2:
	lodsb
	cmp al, 'A'
	jl	nao_maiuscula
	cmp al, 'Z'
	jg	nao_maiuscula
	add al, 32
nao_maiuscula:
	stosb
	loop ciclo_2
	jmp imprime
	
compara_3:
	cmp al, '3'
	jne compara_4
	; O utilizador escolheu a opção 3
	; Vamos eliminar os caracteres de pontuação
ciclo_3:
	lodsb
	cmp al, ' '
	jle nao_pontuacao
	cmp al, '0'
	jl descarta_c3
	cmp al, '9'
	jle nao_pontuacao
	cmp al, 'A'
	jl	descarta_c3
	cmp al, 'Z'
	jle nao_pontuacao
	cmp al, 'a'
	jl descarta_c3
	cmp al, 'z'
	jle nao_pontuacao
	jg descarta_c3
nao_pontuacao:
	stosb
descarta_c3:
	loop ciclo_3
	jmp imprime
	
compara_4:
	cmp al, '4'
	jne compara_5
	; O utilizador escolheu a opção 4
	; Vamos eliminar os algarismos
ciclo_4:
	lodsb
	cmp al, '0'
	jl	nao_algarismo
	cmp al, '9'
	jg	nao_algarismo
	jmp descarta_c4
nao_algarismo:
	stosb
descarta_c4:
	loop ciclo_4
	jmp imprime
	
compara_5:
	cmp al, '5'
	jne compara_6
	; O utilizador escolheu a opção 5
	; Vamos eliminar todas as letras
ciclo_5:
	lodsb
	cmp al, 'A'
	jl nao_letra
	cmp al, 'Z'
	jle descarta_c5
	cmp al, 'a'
	jl nao_letra
	cmp al, 'z'
	jle descarta_c5
nao_letra:
	stosb
descarta_c5:
	loop ciclo_5
	jmp imprime
	
compara_6:
	cmp al, '6'
	jne compara_7
	; O utilizador escolheu a opção 6
	; Vamos exibir apenas os sinais de pontuação
ciclo_6:
	lodsb
	cmp al, '/'
	jle so_pontuacao
	cmp al, ':'
	jl descarta_c6
	cmp al, '@'
	jle so_pontuacao
	cmp al, '['
	jl descarta_c6
	cmp al, '`'
	jle so_pontuacao
	cmp al, '{'
	jl descarta_c6
so_pontuacao:
	stosb
descarta_c6:
	loop ciclo_6
	jmp imprime
	
compara_7:
	cmp al, '0'
	je sair
	cmp al, '7'
	jge op_invalida
op_invalida:
	mov eax, 4
	mov ebx, 1
	mov ecx, inval
	mov edx, t_inval
	int 0x80
	jmp menu1
	
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
	mov ecx, texto2
	mov edx, [n_texto]
	int 0x80
	
sair:
	;Sair
	mov eax, 1			;Função EXIT
	mov ebx, 0			;Código de retorno
	int 0x80			;Invoca o sistema operativo