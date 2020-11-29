#
# Calculadora MIPS
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



imprime:
	#imprime resultado
	li $v0, 1
	syscall

exit:
	li $v0, 10
	syscall