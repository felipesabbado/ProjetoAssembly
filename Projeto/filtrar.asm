section .data

pedir	db	"Insira frase: "
tamanho equ	$ - pedir

result	db	"Resultado: "
tres	equ	$ - result

section .bss

MAX		equ		80
frase	resb	MAX
frase2	resb	MAX

n_lidos	resd	1

section .text

global _start

_start:
	;Pedir a frase
	mov eax, 4
	mov ebx, 1
	mov ecx, pedir
	mov edx, tamanho
	int 0x80
	
	;Ler a frase
	mov eax, 3
	mov ebx, 0
	mov ecx, frase
	mov edx, MAX
	int 0x80
	mov [n_lidos], eax
	
	;Filtrar a frase e não deixar passar o caracter 'a'
	mov esi, frase
	mov edi, frase2
	cld
	mov ecx, [n_lidos]
ciclo:
	lodsb
	cmp al, 'a'
	je	descarta
	stosb
descarta:
	loop ciclo
	
	;Imprime frase "Resultado: "
	mov eax, 4
	mov ebx, 1
	mov ecx, result
	mov edx, tres
	int 0x80
	
	;Imprime frase2
	mov eax, 4
	mov ebx, 1
	mov ecx, frase2
	mov edx, [n_lidos]
	int 0x80
	
	;Sair
	mov eax, 1
	mov ebx, 0
	int 0X80
	