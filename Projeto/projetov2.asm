section .data

pedido		db		"Insira o nome do ficheiro: "
t_pedido	equ		$ - pedido

section .bss

T_MAX		equ		1000
ficheiro	resb	T_MAX
texto		resb	T_MAX
n_texto		resb	1
n_lidos		resd	1
n_fich		resd	1

section .text

global _start

_start:
	; Fazer o pedido
	mov eax, 4
	mov ebx, 1
	mov ecx, pedido
	mov edx, t_pedido
	int 0x80
	
	; Ler o teclado
	mov eax, 3
	mov ebx, 0
	mov ecx, ficheiro
	mov edx, T_MAX
	int 0x80
	dec eax
	mov	[n_lidos], eax
	
	; Colocar um '\0' no fim do nome do ficheiro
	mov ebx, ficheiro	; ebx aponta para nome do ficheiro
	add ebx, [n_lidos]	; ebx aponta para o fim do nome do ficheiro
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
	
	;Mandar imprimir o nome conteúdo ficheiro
	mov eax, 4			;Função WRITE
	mov ebx, 1			;Saída padrão
	mov ecx, texto		;Texto a ser escrito no ecrã
	mov edx, [n_texto]	;nº de bytes a escrever
	int 0x80			;Invoca o S.O.
	
	;Sair
	mov eax, 1			;Função EXIT
	mov ebx, 0			;Código de retorno
	int 0x80			;Invoca o sistema operativo