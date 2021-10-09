# Arquitetura de Computadores
Engenharia Informática 1º ano - 2019/2020
## Relatório - Projeto Assembly 

### Descrição do Projeto:
Em *“section .data”* são listados as variáveis inicializadas e o tamanho que elas ocuparão no sistema. Basicamente são variáveis que contém textos fixos que comunicam ou transmitem alguma informação ao utilizador.

Em *“section .bss”* estão as variáveis não inicializadas. Temos uma constante (T_MAX) que determina o tamanho máximo do texto a ser lido do ficheiro. Ela é aproveitada também para reservar o tamanho máximo do nome do ficheiro e do texto modificado. São criadas variáveis que guardarão o número de bytes de caracteres lidos do texto, do ficheiro e da opção digitada pelo utilizador.

Em *“section. text”* começa o programa propriamente dito, com a chamada inicial em *“\_start:”*. Primeiro é impresso no ecrã um texto solicitando ao utilizador que digite o nome do ficheiro a ser lido. Em seguida é feito a leitura do nome do ficheiro digitado pelo utilizador, guardando na memória as informações importantes. Colocamos um *“\0”* no fim do nome do ficheiro para que o sistema consiga ler corretamente. São feitos, em sequência, os comandos para abrir o ficheiro, ler seu conteúdo (guardando os dados na memória) e fechando o ficheiro. Imprimimos o conteúdo do ficheiro no ecrã para o utilizador poder comparar o texto original com o texto modificado pelo programa.

O menu, com o texto definido na *“section .data”*, é impresso no ecrã e em seguida é solicitado ao utilizador a opção de modificação do texto que ele quer que o programa execute. (Foi criada a função *“menu1”* para que possa ser chamada caso o utilizador digite uma opção inválida). Preparamos, então, o texto do ficheiro para ser modificado movendo seu conteúdo para os registros utilizados por padrão. Em seguida, analisamos a opção digitada pelo utilizador e comparamos com o número 1. Caso não seja a opção escolhida é feito um *“jump”* para o próximo caso, comparando com o número subsequente e repetindo o procedimento até que seja encontrada a escolha do utilizador. Se a opção digitada não estiver entre as disponíveis no menu, então é impresso uma mensagem de erro e é solicitado ao usuário que tente novamente.

Quando uma das opções disponíveis é escolhida então o programa passa a realizar um ciclo em que compara cada letra do texto original do ficheiro com um grupo de caracteres específicos, salvando, modificando ou eliminando-os de acordo com cada caso. No final de cada opção é feito um *“jump”* para a parte final do programa em que é impresso no ecrã o texto modificado. Em seguida o programa é finalizado com o código de saída.

### Listagem do programa:
A listagem do programa está disponível em um ficheiro anexo de nome “projeto.asm”.

### Fluxograma:
O fluxograma está disponível em ficheiro anexo de nome “Fluxograma - Projeto Arquitetura.pdf”.
