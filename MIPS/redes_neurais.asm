#
# Operacoes entre inteiros e floats para calculos de Redes Neurais
# Autor: Tamiris Fernandes Tinelli
#

        .data
seq1:  .word  0, 0, 0       #sequencia 1
seq2:  .word  0, 0, 0, 0    #sequencia 2
resp:   .word  0            #resposta

seq3:  .float  0.00, 0.00, 0.00       #sequencia 3
seq4:  .float  0.00, 0.00, 0.00, 0.00    #sequencia 4
respf:   .float 0.00            #resposta float
comp:   .float 0.00       	#utilizado para comparacoes
	.align 2
ativado: .asciiz "ativado"
	.align 2
zero:    .asciiz "zero"
	.align 2
inativo: .asciiz "inativo"
	.align 2
enter: .asciiz "\n"

 		.text
		.globl main
main:	
	#armazenando enderecos
	la $s0, seq1
	la $s1, seq2
	la $s2, resp
	
	#leitura sequencia 1
	#le inteiro1 seq1
	li $v0, 5
	syscall
	sw $v0, 0($s0)
	#le inteiro2 seq1
	li $v0, 5
	syscall
	sw $v0, 4($s0)
	#le inteiro3 seq1
	li $v0, 5
	syscall
	sw $v0, 8($s0)
	
	#leitura sequencia 2
	#le inteiro1 seq2
	li $v0, 5
	syscall
	sw $v0, 0($s1)
	#le inteiro2 seq2
	li $v0, 5
	syscall
	sw $v0, 4($s1)
	#le inteiro3 seq2
	li $v0, 5
	syscall
	sw $v0, 8($s1)
	#le inteiro4 seq2
	li $v0, 5
	syscall
	sw $v0, 12($s1)
	
	#chama subrotina
	jal cni
	
	#exibe resultado
	li $v0, 1 	#imprime inteiro
	lw $a0, resp
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	#comparar com zero
	lw $a0, resp
	beqz $a0, igual
	bltz $a0, menor
	bgtz $a0, maior
	
igual:
	li $v0, 4
	la $a0, zero
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	j fim_int
	
menor:
	li $v0, 4
	la $a0, inativo
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	j fim_int
	
maior:
	li $v0, 4
	la $a0, ativado
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	j fim_int

fim_int:
	#armazenando enderecos
	la $s0, seq3
	la $s1, seq4
	la $s2, respf
	
	#leitura sequencia 3
	#le float1 seq3
	li $v0, 6
	syscall
	s.s $f0, 0($s0)
	#le float2 seq3
	li $v0, 6
	syscall
	s.s $f0, 4($s0)
	#le float3 seq3
	li $v0, 6
	syscall
	s.s $f0, 8($s0)
	
	#leitura sequencia 4
	#le float1 seq4
	li $v0, 6
	syscall
	s.s $f0, 0($s1)
	#le float2 seq4
	li $v0, 6
	syscall
	s.s $f0, 4($s1)
	#le float3 seq4
	li $v0, 6
	syscall
	s.s $f0, 8($s1)
	#le float4 seq4
	li $v0, 6
	syscall
	s.s $f0, 12($s1)
	
	#chama subrotina
	jal cnf
	
	#exibe resultado
	li $v0, 2 	#imprime float
	l.s $f12, respf
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	#comparar com zero
	l.s $f0, respf
	l.s $f1, comp
	
	c.eq.s $f0, $f1
	bc1t igualf
	
	c.lt.s $f0, $f1
	bc1t menorf
	
	c.le.s $f0, $f1
	bc1f maiorf
	
igualf:
	li $v0, 4
	la $a0, zero
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	j exit
	
menorf:
	li $v0, 4
	la $a0, inativo
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	j exit
	
maiorf:
	li $v0, 4
	la $a0, ativado
	syscall
	
	#mudanca de linha
	li $v0, 4
	la $a0, enter
	syscall
	
	j exit
	
exit:
	li $v0, 10
	syscall   

	
cni:
	#resposta do calculo sera armazenado em a0
	li $a0, 0
	lw $t1, 0($s1) #recuperando w0
	add $a0, $a0, $t1 #soma w0 na resposta
	
	lw $t0, 0($s0) #recuperando x1
	lw $t1, 4($s1) #recuperando w1
	mul $t2, $t0, $t1 #multiplica x1 e w1
	add $a0, $a0, $t2 #soma na resposta
	
	lw $t0, 4($s0) #recuperando x2
	lw $t1, 8($s1) #recuperando w2
	mul $t2, $t0, $t1 #multiplica x2 e w2
	add $a0, $a0, $t2 #soma na resposta
	
	lw $t0, 8($s0) #recuperando x3
	lw $t1, 12($s1) #recuperando w3
	mul $t2, $t0, $t1 #multiplica x3 e w3
	add $a0, $a0, $t2 #soma na resposta
	
	sw $a0, resp #armazenando a resposta
	
	jr $ra

cnf:
	#resposta do calculo sera armazenado em f0
	l.s $f4, 0($s1) #recuperando w0
	add.s $f0, $f0, $f4 #soma w0 na resposta
	
	l.s $f3, 0($s0) #recuperando x1
	l.s $f4, 4($s1) #recuperando w1
	mul.s $f5, $f3, $f4 #multiplica x1 e w1
	add.s $f0, $f0, $f5 #soma na resposta
	
	l.s $f3, 4($s0) #recuperando x2
	l.s $f4, 8($s1) #recuperando w2
	mul.s $f5, $f3, $f4 #multiplica x2 e w2
	add.s $f0, $f0, $f5 #soma na resposta
	
	l.s $f3, 8($s0) #recuperando x3
	l.s $f4, 12($s1) #recuperando w3
	mul.s $f5, $f3, $f4 #multiplica x3 e w3
	add.s $f0, $f0, $f5 #soma na resposta
	
	s.s $f0, respf #armazenando a resposta
	
	jr $ra  

