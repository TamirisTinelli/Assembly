#
# Simulador do Funcionamento de 2 Elevadores para um Predio de 8 Andares
# Autor: Tamiris Fernandes Tinelli
#



.data
	#prints
	e1: .asciiz "\nElevador 1 - "
	e2: .asciiz "\nElevador 2 - "	
	andar: .asciiz "andar atual "
	aberta: .asciiz "porta aberta "
	fechada: .asciiz "porta fechada "
	parado: .asciiz "parado "
	enter: .asciiz "\n"
	bote: .asciiz "\nBotao externo: "
	bot1: .asciiz "\nBotao elevador 1: "
	bot2: .asciiz "\nBotao elevador 2: " 
	
	#andar atual e de destino
	b1a: .byte '0'
	b1d: .byte '0'
	b2a: .byte '0'
	b2d: .byte '0'
	
	#vetores
	be:	.byte  '0' '0' '0' '0' '0' '0' '0' '0' #botao externo
	b1:	.byte  '0' '0' '0' '0' '0' '0' '0' '0' #botao interno elevador 1
	b2:	.byte  '0' '0' '0' '0' '0' '0' '0' '0' #botao interno elevador 2
	
	
	#flags - (variavel em memoria que indica estado)
	# 0 - Sim, 1 - Nao
	terreo1: .byte 1 #Elevador 1 na Base (terreo)
	topo1: .byte 0 #Elevador 1 no Topo (ultimo andar)
	aberta1: .byte 1 #Porta 1 aberta
	parado1: .byte 0 #Elevador 1 com funcionamento interrompido
	terreo2: .byte 1 #Elevador 2 na Base (terreo)
	topo2: .byte 0 #Elevador 2 no Topo (ultimo andar)
	aberta2: .byte 1 #Porta 2 aberta
	parado2: .byte 0 #Elevador 2 com funcionamento interrompido

	#arquivo de log
	log: .asciiz "log.txt"

.text
	.globl main

main:

	#inicializando
	li $s2, 0 #andar E1
	li $s3, 0 #destino E1
	li $s4, 0 #andar E2
	li $s5, 0 #destino E2

abrir_log:
	li   $v0, 13       
	la   $a0, log    
	li   $a1, 1
	li   $a2, 0
	syscall
	move $s0, $v0


escrever_log:
	#elevador 1
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, e1
	li   $a2, 14
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, b1a
	li   $a2, 1
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, b1d
	li   $a2, 1
	syscall
	
	#elevador 2
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, e2
	li   $a2, 14
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, b2a
	li   $a2, 1
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, b2d
	li   $a2, 1
	syscall
	
	#botao externo
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, bote
	li   $a2, 16
	syscall
	
	li $v0, 15    
	move $a0, $s0  
	la   $a1, be
	li   $a2, 8
	syscall
	
	#botao interno 1
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, bot1
	li   $a2, 19
	syscall
	
	li $v0, 15    
	move $a0, $s0  
	la   $a1, b1
	li   $a2, 8
	syscall

	
	#botao interno 2
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, bot2
	li   $a2, 19
	syscall
	
	li $v0, 15    
	move $a0, $s0  
	la   $a1, b2
	li   $a2, 8
	syscall
	

entrada: #TO DO

movimento: #TO DO

temporizador: #TO DO


fechar_log:
	li   $v0, 16 
	move $a0, $s0 
	syscall


end:
	li $v0, 10
	syscall

#teclado
# 1 a 8 - botões externos
# 'q' ao 'i' do teclado (qwertyui) são o andar de destino E1 (botões internos do Elevador E1)
# 'a' ao 'k' do teclado (asdfghjk) são o andar de destino E2 (botões internos do Elevador E2)

# "parada" (bloqueio) do Elevador E1 é o 'z'
# "libera" (desbloqueio) do Elevador E1 é o 'x'
# "parada" (bloqueio) do Elevador E2 é o 'c'
# "libera" (desbloqueio) do Elevador E2 é o 'v'

# 'p' = Desliga elevador, fecha arquivo de log e sai do programa
