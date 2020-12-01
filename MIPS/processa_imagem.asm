#
# Processamento de Imagem
# Autor: Tamiris Fernandes Tinelli
#

        .data
        .align 2
fin: .asciiz "image.pgm"
	.align 2
fout:  .asciiz "conv.pgm"
end:   .word   0      #endereco do inicio do arquivo


	.text
	.globl main
	
main:
	#alocacao de memoria
    	li $a0, 10052 #quantidade de bytes alocados (1038 + margem)
    	li $v0, 9
   	syscall
    
   	sw $v0, end
   	
open:
   	#abre arquivo de input
   	li   $v0, 13       
	la   $a0, fin
	li   $a1, 0        # flag leitura
	li   $a2, 0        # mode
	syscall       
	
	move $s0, $v0      #armazena em s0 
	
	#abre arquivo de output
	li   $v0, 13
	la   $a0, fout
	li   $a1, 1        # flag escrita
	li   $a2, 0        # mode
	syscall
	
	move $s1, $v0      #armazena em s1

read:
	#le arquivo de input
	li   $v0, 14
	move $a0, $s0
	la   $a1, end
	li   $a2, 10038   #quantidade lida
	syscall

operation:
	la $v0, end
	lb $t0, 37($v0) #salva o ultimo valor do cabecalho 
	addi $v0, $v0, 38 #soma 38 bytes no endereco	
	
	#a0 sera o contador regressivo
	li $a0, 10000
	subi $a0, $a0, 1 #para comparar com zero e n�o com um
	
loop:
	lb $t1, -1($v0)   #pega valor do pixel
	addi $t1, $t1, -3 #faz operacao
	sb $t1, -1($v0)   #armazena

	lb $t1, 0($v0)   #pega valor do pixel
	addi $t1, $t1, 10 #faz operacao
	sb $t1, 0($v0)   #armazena
	
	lb $t1, 1($v0)   #pega valor do pixel
	addi $t1, $t1, -3 #faz operacao
	sb $t1, 1($v0)   #armazena
	
	addi $v0, $v0, 1 #soma 1 byte no endereco
	subi $a0, $a0, 1 #decresce o contador
	
	bnez, $a0, loop #loop enquanto a0 diferente de zero
	
fim_loop:
	la $v0, end
	sb $t0, 37($v0) #reescreve o ultimo valor do cabecalho
	
write:	
	#escrever no arquivo de output
	li   $v0, 15
	move $a0, $s1
	la   $a1, end
	li   $a2, 10038
	syscall
	
close:
	#fecha arquivo de input
	li   $v0, 16
	move $a0, $s0
	syscall

	#fecha arquivo de output
	li   $v0, 16
	move $a0, $s1
	syscall
	
exit:
	li   $v0, 10
	syscall 