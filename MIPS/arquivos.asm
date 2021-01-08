#
# Leitura e Escrita em arquivos
# Autor: Tamiris Fernandes Tinelli
#

.data
	#arquivo para leitura
	#deve estar na mesma pasta no programa (ou o caminho do diretorio deve ser indicado)
	#caso o programa nao encontre arquivo com esse nome, a leitura sera nula
	fread: .asciiz "input.txt"
	
	buffer: .space 1024 #reserva espaço em bytes na memoria para conteudo lido
	
	texto: .asciiz "Conteudo lido:\n"
	
	#arquivo para escrita
	#sera criado na mesma pasta do programa
	#se ja existir arquivo com esse nome, sera sobrescrito
	fwrite: .asciiz "output.txt"
	

.text 
.globl main

main:


leitura:
#abre arquivo input.txt
li   $v0, 13       # codigo para abrir arquivo
la   $a0, fread    # nome do arquivo, esta na variavel fread
li   $a1, 0        # 0: leitura, 1: escrita
li   $a2, 0        # modo
syscall 
move $s0, $v0      # salvando o descritor do arquivo

#leitura do arquivo input.txt
li   $v0, 14       # codigo para leitura de arquivo
move $a0, $s0      # descritor do arquivo
la   $a1, buffer   # buffer
li   $a2,  9       # tamanho em bytes a ser lido
syscall

#imprime o que foi lido de input.txt
li   $v0, 4
la   $a0, buffer   # o conteudo esta no buffer
syscall

#fecha arquivo input.txt
li   $v0, 16       # codigo para fechar arquivo
move $a0, $s0      # descritor do arquivo
syscall



escrita:
#abre arquivo output.txt	
li   $v0, 13       # codigo para abrir arquivo
la   $a0, fwrite   # nome do arquivo, esta na variavel fwrite
li   $a1, 1        # 0: leitura, 1: escrita
li   $a2, 0        # modo
syscall 
move $s1, $v0      # salvando o descritor do arquivo

#escreve uma string em output.txt
li   $v0, 15       # codigo para escrever em arquivo
move $a0, $s1      # descritor do arquivo 
la   $a1, texto    # buffer
li   $a2, 15       # tamanho
syscall

#escreve o que foi lido em output.txt
li   $v0, 15       # codigo para escrever em arquivo
move $a0, $s1      # descritor do arquivo 
la   $a1, buffer   # buffer
li   $a2, 9        # tamanho
syscall

# Close the file 
li   $v0, 16       # codigo para fechar arquivo
move $a0, $s1      # descritor do arquivo
syscall


fim:
#finaliza o programa
li   $v0, 10
syscall 

