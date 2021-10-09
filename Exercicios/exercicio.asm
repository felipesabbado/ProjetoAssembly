section .data

ficheiro db "texto.txt", 0 ;Nome do ficheiro a ser lido

section .bss

TAMANHO	equ 15
texto resb 15
num_fich resd 1


section .text

global	_start

_start:

	;Abrir o ficheiro
	mov eax, 5			;Função OPEN
	mov ebx, ficheiro	;Nome do ficheiro que vamos abrir
	mov ecx, 0			;Função READ
	int 0x80			;Invoca o sistema operativo
	mov [num_fich], eax	;Guardar o número do ficheiro aberto
	
	;Ler no ficheiro
	mov eax, 3			;Função Read
	mov ebx, [num_fich]	;nº do ficheiro que quero ler
	mov ecx, texto		;Variavel definida na section .bss para onde será lido o conteúdo do ficheiro
	mov edx, TAMANHO	;Tamanho da string
	int 0x80			;Invoca o sistema operativo
	
	;Fechar o ficheiro
	mov eax, 6			;Função CLOSE
	mov ebx, [num_fich]	;nº do ficheiro que quero fechar
	int 0x80			;Invoca o sistema operativo
	
	;Mandar imprimir o conteúdo do ficheiro
	mov eax, 4			;Função WRITE
	mov ebx, 1			;Saída padrão
	mov ecx, texto		;Texto a ser escrito no ecrã
	mov edx, TAMANHO	;nº de bytes a escrever
	int 0x80			;Invoca o S.O.
	
	;Sair
	mov eax, 1			;Função EXIT
	mov ebx, 0			;Código de retorno
	int 0x80			;Invoca o sistema operativo
	