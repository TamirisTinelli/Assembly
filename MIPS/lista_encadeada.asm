#
# Exercicio 4 - Lista Encadeada MIPS
# Autor: Tamiris Fernandes Tinelli
#

	.data
	.align 2
espaco: .asciiz "  " #para separar os numeros no output
vetor: .word 15, 31, 63, 127, 255, 511, 1023, 2047, 4097, 65536, 0 #vetor estatico
lista: .word 0 #armazena o endereco inicial 


	.text
	.globl main
main:
	#aloca espaco
	li $v0, 9
	li $a0, 30 #tamanho alocado -> 10 valores, 10 enderecos e uma margem
	syscall
	
	sw $v0, lista #salva o endereco
	move $s0, $v0 #salva em registrador tambem
	
preencher:
	#v0 manipula lista
	#v1 manipula vetor
	la $v0, lista
	la $v1, vetor
	
loop_pre:
	lw $t0, 0($v1) #recupera valor em vetor	
	sw $t0, 0($v0) #adiciona na lista
	
	beqz $t0, fim_pre #se encontrar um valor igual a zero, acabou o vetor
	
	addi $v0, $v0, 4 #incrementa o v0 em 1 word
	addi $t1, $v0, 4 #t1 armazena proximo endereco
	sw $t1, 0($v0)      #v0 recebe proximo endereco
	addi $v0, $v0, 4 #incrementa o v0 em 1 word
	
	addi $v1, $v1, 4 #incrementa o v1 em 1 word
	
	j loop_pre
	
fim_pre:

	la $s0, lista

loop_imp:
	lw $a0, 0($s0) #recupera inteiro
	
	#imprime int
	li $v0, 1
	syscall
	
	beqz $a0, fim #se o elemento da lista for zero, acabou

	#imprime str
	li $v0, 4
	la $a0, espaco
	syscall	
	
	addi $s0, $s0, 4 #incrementa uma word no s0 para encontrar o prox endereco
	lw $t0, 0($s0)      #proximo endereco em t0
	move $s0, $t0    #passa o proximo endereco para $s0
	
	j loop_imp
	
fim:	
	#exit
	li $v0, 10
	syscall
	
