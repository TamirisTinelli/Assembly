;nesse codigo iremos aprender a declarar variaveis,
;acessar seu valor ou modifica-lo
;vamos aprender tambem o uso de arrays

ORG 100h

;retire o ponto e virgula das chamadas (call) das rotinas que deseja executar

;call teste_byte

;call teste_word

;call teste_array_byte

;call teste_array_byte_2 

call teste_array_word

;call teste_array_word_2

jmp fim
   
;troca o conteudo da variavel var1 de 5h para Fh
teste_byte:

    MOV    AL, VAR1              ;al recebe o conteudo de var1 
    
    MOV    BX, OFFSET VAR1       ;bx recebe o endereco de var1
                                 ;obs: apenas os regirtadores BX, SI, DI e BP
                                 ;podem ser utilizados como ponteiros para memoria
                                 
    MOV    BYTE PTR [BX], 0Fh    ;acesso ao endereco contido em bx, atribuido o conteudo 0Fh
    
    MOV    AL, VAR1              ;al recebe o novo conteudo de var1   
    
 
;troca o conteudo da variavel var2 de 5h para Fh 
teste_word:

    MOV    AX, VAR2              ;ax recebe o conteudo de var2 
    
    MOV    BX, OFFSET VAR2       ;bx recebe o endereco de var2
    
    MOV    WORD PTR [BX], 0Fh    ;acesso ao endereco contido em bx, atribuido o conteudo 0Fh
    
    MOV    AX, VAR2              ;ax recebe o novo conteudo de var2   


;troca o conteudo de arr1[5] de 5h para Fh 
teste_array_byte:

    MOV    AL, arr1              ;al recebe o conteudo de arr1 (primeira posicao) 
    
    MOV    BX, OFFSET arr1       ;bx recebe o endereco de arr1
                          
    ADD    BX, 5                 ;somando 5 no endereco para chegar na posicao desejada
                       
    MOV    BYTE PTR [BX], 0Fh    ;acesso ao endereco contido em bx, atribuido o conteudo 0Fh
    
    MOV    AL, BYTE PTR [BX]     ;al recebe o conteudo armazenado no endereco que bx guarda 
    
      

;troca o conteudo de arr1[5] de 5h para Fh (segunda versao)
teste_array_byte_2:

    MOV    AL, arr1[5]           ;al recebe o conteudo de arr1 na posicao 5 
    
    MOV    BX, OFFSET arr1[5]    ;bx recebe o endereco de arr1 na posicao 5
                       
    MOV    BYTE PTR [BX], 0Fh    ;acesso ao endereco contido em bx, atribuido o conteudo 0Fh
    
    MOV    AL, arr1[5]           ;al recebe o conteudo armazenado no endereco que bx guarda   
  
  
;troca o conteudo da sexta posicao de arr2 de 5h para Fh 
teste_array_word:

    MOV    AX, arr2              ;ax recebe o conteudo de arr1 (primeira posicao) 
    
    MOV    BX, OFFSET arr2       ;bx recebe o endereco de arr1
                          
    ADD    BX, 10                ;somando 2 * 5 no endereco para chegar na posicao desejada
                                 ;como o tipo eh word devemos acrescentar 2 ao endereco 
                                 ;cada vez que desejamos passar para a proxima word
                       
    MOV    WORD PTR [BX], 0Fh    ;acesso ao endereco contido em bx, atribuido o conteudo 0Fh
    
    MOV    AX, WORD PTR [BX]     ;ax recebe o conteudo armazenado no endereco que bx guarda 
    
      

;troca o conteudo da sexta posicao de arr2 de 5h para Fh (segunda versao)
teste_array_word_2:

    MOV    AX, arr2[10]           ;ax recebe o conteudo de arr1 na posicao 10
                                  ;cada word ocupa 2 bytes
                                  ;entao multiplicamos o indice desejado por 2
                                  ;2 * 5 = 10 
    
    MOV    BX, OFFSET arr2[10]    ;bx recebe o endereco de arr1 na posicao 10
                       
    MOV    WORD PTR [BX], 0Fh     ;acesso ao endereco contido em bx, atribuido o conteudo 0Fh
    
    MOV    AX, arr2[10]           ;ax recebe o conteudo armazenado no endereco que bx guarda   


    
fim:

    RET

VAR1   DB  5h
VAR2   DW  5h

arr1   DB  0h, 1h, 2h, 3h, 4h, 5h, 6h, 7h
arr2   DW  0h, 1h, 2h, 3h, 4h, 5h, 6h, 7h, 8h, 9h, 0Ah 

END