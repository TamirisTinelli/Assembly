#
# Calculadora MIPS
# Autor: Tamiris Fernandes Tinelli
# 
	.data
dado1:	 .word		3
dado2:	 .word		4
resultado:  .word 		0
operacao:	 .word		0

# operacao
# 0 -> soma
# 1 -> subtracao
# 2 -> multiplicacao
# 3 -> divisao
# 4 -> fatorial
# 5 -> exponencial
# 6 -> raiz quadrada
# C -> clear
# X -> sair

	.text
		.globl main

main:
	#dado 1 vai para s0, dado 2 para s1
	lw $s0, dado1
	lw $s1, dado2



soma:
	#calcula reposta em a0
	add $a0, $s0, $s1

	#salva resposta em resultado
	sw $a0, resultado


subtracao:
	#calcula reposta em a0
	sub $a0, $s0, $s1

	#salva resposta em resultado
	sw $a0, resultado


multiplicacao:
	#calcula reposta em a0
	mul $a0, $s0, $s1

	#salva resposta em resultado
	sw $a0, resultado

fatorial:
	#numero que aplicaremos o fatorial em s0
	#resutado parcial em a0
	#contador t0
	
	li $a0, 1
	li $t0, 1

	loop_fat:
		mul $a0, $a0, $t0
		addi $t0, $t0, 1
		slt $t1, $s0, $t0 #checa se s0 < t0
		bne $t1, 1, loop_fat #desvio enquanto a afirmacao anterior for falsa
		 
	#salva resposta em resultado
	sw $a0, resultado


exponenciacao:
	#base em s0
	#expoente em s1
	#resutado parcial em a0
	#contador t0
	
	li $a0, 1
	li $t0, 1

	loop_exp:
		slt $t1, $s1, $t0 #checa se s1 < t0
		beq $t1, 1, exp_fim #desvio se a afirmacao anterior for verdadeira
		mul $a0, $a0, $s0
		addi $t0, $t0, 1
		j loop_exp

	exp_fim:
		#salva resposta em resultado
		sw $a0, resultado



imprime:
	#imprime resultado
	li $v0, 1
	syscall

exit:
	li $v0, 10
	syscall