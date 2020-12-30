.data
	#prints
	e1: .asciiz "Elevador 1 - "
	e2: .asciiz "Elevador 2 - "
	andar: .asciiz "andar atual "
	aberta: .asciiz "porta aberta "
	fechada: .asciiz "porta fechada "
	parado: .asciiz "parado "
	enter: .asciiz "\n"
	
	#vetores
	be:	.word  0 0 0 0 0 0 0 0 #botao externo
	b1:	.word  0 0 0 0 0 0 0 0 #botao interno elevador 1
	b2:	.word  0 0 0 0 0 0 0 0 #botao interno elevador 2
	
	#flags - (variavel em memoria que indica estado)
	# 0 - Sim, 1 - Nao
	terreo1: .word 1 #Elevador 1 na Base (terreo)
	topo1: .word 0 #Elevador 1 no Topo (ultimo andar)
	aberta1: .word 1 #Porta 1 aberta
	parado1: .word 0 #Elevador 1 com funcionamento interrompido
	terreo2: .word 1 #Elevador 2 na Base (terreo)
	topo2: .word 0 #Elevador 2 no Topo (ultimo andar)
	aberta2: .word 1 #Porta 2 aberta
	parado2: .word 0 #Elevador 2 com funcionamento interrompido

	#arquivo de log
	log: .asciiz "log.txt"

.text
	.globl main

main:

abrir_log:
	li   $v0, 13       # system call for open file
	la   $a0, log     # output file name
	li   $a1, 1        # flag for writing
	li   $a2, 0        # mode is ignored
	syscall            # open a file 
	move $s0, $v0      # save the file descriptor 


escrever_log: #TO DO

entrada: #TO DO

movimento: #TO DO

temporizador: #TO DO


fechar_log:
	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file


end:
	li $v0, 10
	syscall

#teclado
# 1 a 8 - bot�es externos
# 'q' ao 'i' do teclado (qwertyui) s�o o andar de destino E1 (bot�es internos do Elevador E1)
# 'a' ao 'k' do teclado (asdfghjk) s�o o andar de destino E2 (bot�es internos do Elevador E2)

# "parada" (bloqueio) do Elevador E1 � o 'z'
# "libera" (desbloqueio) do Elevador E1 � o 'x'
# "parada" (bloqueio) do Elevador E2 � o 'c'
# "libera" (desbloqueio) do Elevador E2 � o 'v'

# 'p' = Desliga elevador, fecha arquivo de log e sai do programa