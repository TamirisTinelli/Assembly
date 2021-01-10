#
# Simulador do Funcionamento de 2 Elevadores para um Predio de 8 Andares
# Autor: Tamiris Fernandes Tinelli
#

#TO DO:
#consertar keyboard que ta sempre desviando (como se nao tivesse entrada)
#trocar de string pra char na impressao (syscall 11)
#movimentacao do elevador:
#	busca do andar de destino
#	movimento
#	tratar bloqueio e desbloqueio do elevador
#	setar flags

.data
	#numero de contagens do temporizador
	temp: .word 30
	
	#prints
	e1: .asciiz "\nElevador 1 - "
	e2: .asciiz "\nElevador 2 - "	
	andar: .asciiz "andar atual "
	aberta: .asciiz "porta aberta "
	fechada: .asciiz "porta fechada "
	parado: .asciiz "parado "
	enter: .asciiz "\n"
	bote: .asciiz "\nBotao externo:    "
	bot1: .asciiz "\nBotao elevador 1: "
	bot2: .asciiz "\nBotao elevador 2: " 
	tc: .asciiz "\nTeclou: "
	
	#andar atual e de destino 
	b1a: .byte '0' ' ' '\0' #marca fim de string para facilitar impressao
	b1d: .byte '0' ' ' '\0'
	b2a: .byte '0' ' ' '\0'
	b2d: .byte '0' ' ' '\0'
	
	#vetores
	be:	.byte  '0' '0' '0' '0' '0' '0' '0' '0' '\0' #botao externo
	b1:	.byte  '0' '0' '0' '0' '0' '0' '0' '0' '\0' #botao interno elevador 1
	b2:	.byte  '0' '0' '0' '0' '0' '0' '0' '0' '\0' #botao interno elevador 2
	
	
	#flags - (variavel em memoria que indica estado)
	terreo1: .byte '1' '\0' #Elevador 1 na Base (terreo)
	topo1:   .byte '0' '\0' #Elevador 1 no Topo (ultimo andar)
	aberta1: .byte 'A' ' ' '\0' #Porta 1 A - aberta F - fechada
	parado1: .byte 'P' '\0' #Elevador 1 P - parado M - movendo
	terreo2: .byte '1' '\0' #Elevador 2 na Base (terreo)
	topo2:   .byte '0' '\0' #Elevador 2 no Topo (ultimo andar)
	aberta2: .byte 'A' ' ' '\0' #Porta 2 A - aberta F - fechada
	parado2: .byte 'P' '\0' #Elevador 2 P - parado M - movendo

	#arquivo de log
	log: .asciiz "log.txt"

.text
	.globl main

main:
	#inicializando
	li $s2, 0 #andar E1
	li $s3, 0 #destino E1
	li $s4, 2 #movimento E1 - 0 - parado, 1 - descendo, 2 - subindo
	
	li $s5, 0 #andar E2
	li $s6, 0 #destino E2
	li $s7, 2 #movimento E1

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
	li   $a2, 2
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, b1d
	li   $a2, 2
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, aberta1
	li   $a2, 2
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, parado1
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
	li   $a2, 2
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, b2d
	li   $a2, 2
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, aberta2
	li   $a2, 2
	syscall
	
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, parado2
	li   $a2, 1
	syscall
	
	#botao externo
	li   $v0, 15    
	move $a0, $s0  
	la   $a1, bote
	li   $a2, 19
	syscall
	
	li   $v0, 15    
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

print_tela:
	#elevador 1
	li   $v0, 4    
	la   $a0, e1
	syscall
	
	li   $v0, 4 
	la   $a0, b1a
	syscall
	
	li   $v0, 4 
	la   $a0, b1d
	syscall
	
	li   $v0, 4 
	la   $a0, aberta1
	syscall
	
	li   $v0, 4  
	la   $a0, parado1
	syscall
	
	
	#elevador 2
	li   $v0, 4      
	la   $a0, e2
	syscall
	
	li   $v0, 4 
	la   $a0, b2a
	syscall
	
	li   $v0, 4 
	la   $a0, b2d
	syscall
	
	li   $v0, 4 
	la   $a0, aberta2
	syscall
	
	li   $v0, 4  
	la   $a0, parado2
	syscall
	
	#botao externo
	li   $v0, 4     
	la   $a0, bote
	syscall
	
	li   $v0, 4 
	la   $a0, be
	syscall
	
	#botao interno 1
	li   $v0, 4  
	la   $a0, bot1
	syscall
	
	li   $v0, 4
	la   $a0, b1
	syscall

	
	#botao interno 2
	li   $v0, 4  
	la   $a0, bot2
	syscall
	
	li   $v0, 4 
	la   $a0, b2
	syscall

entrada:
	lw      $t0, 0xffff0000 #controlador
	andi    $t0, $t0, 0x00000001 #verifica se encontrou dado
	beqz    $t0, movimento #se nao tem dado, faz o desvio para o proximo passo
    	# a sequencia eh
    	# escrita log - print - busca tecla - movimento do elevador - temporizador -> repete
    	
    	#teste para ver se chega aqui, por enquanto nao
    	li $v0, 4
	la $a0, tc
	syscall
    	
	lbu     $a0, 0xffff0004 
	move    $s1, $a0 #salva em $s1 o caracter lido
	
	li $v0, 4
	la $a0, tc
	syscall
	
	li $v0, 11
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, enter
	syscall
	
	li $t1, '1'
	
	# 1 a 8 - botoes externos - identificacao da tecla apertada
	la $v0, be
	li $t0, '1'
	beq $t0, $s1, v1
	li $t0, '2'
	beq $t0, $s1, v2
	li $t0, '3'
	beq $t0, $s1, v3
	li $t0, '4'
	beq $t0, $s1, v4
	li $t0, '5'
	beq $t0, $s1, v5
	li $t0, '6'
	beq $t0, $s1, v6
	li $t0, '7'
	beq $t0, $s1, v7
	li $t0, '8'
	beq $t0, $s1, v8
	
	# q a i - botoes internos - identificacao da tecla apertada
	la $v0, b1
	li $t0, 'q'
	beq $t0, $s1, vq
	li $t0, 'w'
	beq $t0, $s1, vw
	li $t0, 'e'
	beq $t0, $s1, ve
	li $t0, 'r'
	beq $t0, $s1, vr
	li $t0, 't'
	beq $t0, $s1, vt
	li $t0, 'y'
	beq $t0, $s1, vy
	li $t0, 'u'
	beq $t0, $s1, vu
	li $t0, 'i'
	beq $t0, $s1, vi

	# a a k - botoes internos - identificacao da tecla apertada
	la $v0, b2
	li $t0, 'a'
	beq $t0, $s1, va
	li $t0, 's'
	beq $t0, $s1, vs
	li $t0, 'd'
	beq $t0, $s1, vd
	li $t0, 'f'
	beq $t0, $s1, vf
	li $t0, 'g'
	beq $t0, $s1, vg
	li $t0, 'h'
	beq $t0, $s1, vh
	li $t0, 'j'
	beq $t0, $s1, vj
	li $t0, 'k'
	beq $t0, $s1, vk
	
	li $t0, 'p'
	beq $t0, $s1, vp
	
	j entrada # nao eh uma das teclas definidas como input	
	
	# 1 a 8 - botoes externos - acao
	v1:
		sb $t1, 0($v0)
		j entrada
	v2:
		sb $t1, 1($v0)
		j entrada
	v3:
		sb $t1, 2($v0)
		j entrada
	v4:
		sb $t1, 3($v0)
		j entrada
	v5:
		sb $t1, 4($v0)
		j entrada
	v6:
		sb $t1, 5($v0)
		j entrada
	v7:
		sb $t1, 6($v0)
		j entrada
	v8:
		sb $t1, 7($v0)
		j entrada

	# 'q' ao 'i' - botoes internos - acao
	la $v0, b1
	vq:
		sb $t1, 0($v0)
		j entrada	
	vw:
		sb $t1, 1($v0)
		j entrada
	ve:
		sb $t1, 2($v0)
		j entrada
	vr:
		sb $t1, 3($v0)
		j entrada
	vt:
		sb $t1, 4($v0)
		j entrada
	vy:
		sb $t1, 5($v0)
		j entrada
	vu:
		sb $t1, 6($v0)
		j entrada
	vi:
		sb $t1, 7($v0)
		j entrada
		
	# 'a' ao 'k' - botoes internos - acao
	la $v0, b2
	va:
		sb $t1, 0($v0)
		j entrada	
	vs:
		sb $t1, 1($v0)
		j entrada
	vd:
		sb $t1, 2($v0)
		j entrada
	vf:
		sb $t1, 3($v0)
		j entrada
	vg:
		sb $t1, 4($v0)
		j entrada
	vh:
		sb $t1, 5($v0)
		j entrada
	vj:
		sb $t1, 6($v0)
		j entrada
	vk:
		sb $t1, 7($v0)
		j entrada
		
	# "parada" (bloqueio) do Elevador E1 é o 'z'
	# "libera" (desbloqueio) do Elevador E1 é o 'x'
	# "parada" (bloqueio) do Elevador E2 é o 'c'
	# "libera" (desbloqueio) do Elevador E2 é o 'v'

	# 'p' = Desliga elevador, fecha arquivo de log e sai do programa

	vp:
		j fechar_log

movimento: #TO DO

temporizador:
	li $t0, 1
	lw $t1, temp
	
	loop:
		addi $t0, $t0, 1
		blt $t0, $t1, loop
		
	j main
	
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
