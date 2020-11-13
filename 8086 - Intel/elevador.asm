; Autor: Tamiris Fernandes Tinelli
; Numero USP: 10346738


;      comandos do teclado:
; 1 a 8 -> andar de chamada
; a a h -> andar de destino
; p -> parada
; P -> desativa pausa
; x -> reset, volta configuracoes para comeco
; q -> quit, finaliza programa
; s -> sensor da porta - detectou algo
; S -> sensor da porta - liberado
; espaco eh ignorado na leitura
; caracteres nao especificados finalizam a leitura    
    
;      uso dos registradores
;ah sera usado na leitura
;al armazena resultado da leitura
;bx utilizado para armazenar endereco de variaveis
;cl andar atual do elevador
;ch proximo andar
;dx utilizado no output
;fora isso, podem ser utilizados para auxiliar em operacoes
;quando nao tiverem guardando informacoes relevantes



;      rotina base
;informa situacao atual  - andar, porta aberta/fechada
;leitura                
;procura proximo andar
;se encontrou: fecha porta, subindo/descendo, vai ate o andar, volta pro inicio
;se nao encontrou: volta pra leitura


org 100h

mov cl, '1' ; cl vai mostrar o andar atual do elevador
mov ch, '1' ; ch vai indicar o proximo andar que o elevador vai

inicio:

call printa_andar
call printa_abrindo

call printa_aguardando
    
leitura:    
;leitura, valor fica em AL
mov ah, 1
int 21h
mov dl, al ;valor lido ficara temporariamente em DL

;identifica o que foi lido
cmp dl, 20h       ;espaco -> continua lendo
jz leitura
cmp dl, 0Dh       ;enter -> termina a rodada de leituras
jz buscar_proximo ;procura proximo andar
cmp dl, '1'
jz um
cmp dl, 'a'
jz um
cmp dl, '2'
jz dois
cmp dl, 'b'
jz dois
cmp dl, '3'
jz tres
cmp dl, 'c'
jz tres
cmp dl, '4'
jz quatro
cmp dl, 'd'
jz quatro
cmp dl, '5'
jz cinco
cmp dl, 'e'
jz cinco
cmp dl, '6'
jz seis     
cmp dl, 'f'
jz seis
cmp dl, '7'
jz sete
cmp dl, 'g'
jz sete
cmp dl, '8'
jz oito
cmp dl, 'h'
jz oito 
cmp dl, 'p'
jz para
cmp dl, 'x'
jz reseta  
cmp dl, 'q'
jz fim
cmp dl, 's'
jz sensor_ativado
cmp dl, 'S'
jz sensor_desativado

jmp buscar_proximo ;input fora das especificacoes, finalizando rodada de leitura


um:  
    mov bx, offset chamadas    ; BX <= endereco de chamadas
    mov [bx], '1' ;colocando 1 para andar 1 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler

dois:
    mov bx, offset chamadas   ; BX <= endereco de chamadas
    add bx, 1
    mov [bx], '1' ;colocando 1 para andar 2 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler

tres:
    mov bx, offset chamadas     ; BX <= endereco de chamadas
    add bx, 2
    mov [bx], '1' ;colocando 1 para andar 3 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
quatro:
    mov bx, offset chamadas     ; BX <= endereco de chamadas
    add bx, 3
    mov [bx], '1' ;colocando 1 para andar 4 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
cinco:
    mov bx, offset chamadas     ; BX <= endereco de chamadas
    add bx, 4
    mov [bx], '1' ;colocando 1 para andar 5 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
seis:
    mov bx, offset chamadas     ; BX <= endereco de chamadas
    add bx, 5
    mov [bx], '1' ;colocando 1 para andar 6 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
sete:
    mov bx, offset chamadas     ; BX <= endereco de chamadas
    add bx, 6
    mov [bx], '1' ;colocando 1 para andar 7 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
oito:
    mov bx, offset chamadas     ; BX <= endereco de chamadas
    add bx, 7
    mov [bx], '1' ;colocando 1 para andar 8 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
para:
    mov ah, 1 
    int 21h     ;leitura, valor ficara em AL
    cmp al, 'P'
    jnz para  ;nao sai enquanto nao ler P
    jmp leitura

reseta:
    ;limpa os dados e volta para inicio
    mov bx, offset porta
    mov [bx], '0'
    
    mov bx, offset direcao
    mov [bx], '1'
    
    mov cl, '1'
    mov ch, '1'
    
    mov bx, offset chamadas
    mov al, 1 ;contador auxiliar
    limpa:
        mov [bx], '0'
        inc bx
        inc al
        cmp al, 8
        jl limpa
    mov al, 0
    jmp inicio
    
    
sensor_ativado:
    mov bx, offset porta
    mov [bx], '1'
    jmp leitura

sensor_desativado:
    mov bx, offset porta
    mov [bx], '0'
    jmp leitura
 
 
 
buscar_proximo: ;descobre proximo andar e guarda em ch
    mov bx, offset direcao
    cmp [bx], '1' ;subindo
    jz sobe_desce
    jmp desce_sobe ;descendo
                        
    sobe_desce:
    subida:
        mov al, cl ;AL sera  um auxiliador para contagem
        sub al, 31h ;tirando 31h de AL para obter o indice 
        mov bx, offset chamadas[al] ;endereco de chamadas[al]
        add al, 31h ;volta para caracter
        
        iteracao_subida:
            inc al ;andar de cima
            inc bx ;atualiza o endereco tambem
            
            cmp al, 38h ;comparacao com 8 em hexadecimal
            jg fim_subida ;se al for maior do que 8 finaliza busca nesse sentido
            
            cmp [bx], '1' ;compara chamadas[al] com '1'
            jz encontrou_subindo
            jmp iteracao_subida ;se nao encontrou, vai continuar procurando
            
        encontrou_subindo:
            mov ch, al ;atualizar ch
            jmp movimento ;finalizar buscas
    
    fim_subida:        
    call inversao ;trocar direcao  
    
    descida:
        mov al, cl ;AL sera  um auxiliador para contagem
        sub al, 31h ;tirando 31h de AL para obter o indice
        mov bx, offset chamadas[al] ;endereco de chamadas[al]
        add al, 31h ;volta para caracter
        
        iteracao_descida:
            dec al ;andar de baixo
            dec bx ;atualiza o endereco tambem
            
            cmp al, 31h ;comparacao com 1 em hexadecimal
            jl leitura ;se al for menor do que z finaliza as buscas - nao tem chamada pendente
            
            cmp [bx], '1' ;compara chamadas[al] com '1'
            jz encontrou_descendo
            jmp iteracao_descida ;se nao encontrou, vai continuar procurando
            
        
        encontrou_descendo:
            mov ch, al  ;atualizar ch
            jmp movimento ;finalizar buscas   
    
    
    desce_sobe:  
    descida2:
        mov al, cl ;AL sera  um auxiliador para contagem
        sub al, 31h ;tirando 31h de AL para obter o indice
        mov bx, offset chamadas[al] ;endereco de chamadas[al]
        add al, 31h ;volta para caracter
        
        iteracao_descida2:
            dec al ;andar de baixo
            dec bx ;atualiza o endereco tambem
            
            cmp al, 31h ;comparacao com 1 em hexadecimal
            jl fim_descida2 ;se al for menor do que z finaliza busca nesse sentido
            
            ;vamos analisar chamadas[al]
            cmp [bx], '1' ;compara chamadas[al] com '1'
            jz encontrou_descendo2
            jmp iteracao_descida2 ;se nao encontrou, vai continuar procurando
            
        
        encontrou_descendo2:
            mov ch, al  ;atualizar ch
            jmp movimento ;finalizar buscas
            
     fim_descida2:
     call inversao ;trocar direcao 
     
     subida2:
        mov al, cl ;AL sera  um auxiliador para contagem
        sub al, 31h ;tirando 31h de AL para obter o indice
        mov bx, offset chamadas[al] ;endereco de chamadas[al]
        add al, 31h ;volta para caracter
        
        iteracao_subida2:
            inc al ;andar de cima
            inc bx ;atualiza o endereco tambem
            
            cmp al, 38h ;comparacao com 8 em hexadecimal
            jg leitura ;se al for maior do que 8 finaliza as buscas - nao tem chamada pendente
            
            cmp [bx], '1' ;compara chamadas[al] com '1'
            jz encontrou_subindo2
            jmp iteracao_subida2 ;se nao encontrou, vai continuar procurando
            
        encontrou_subindo2:
            mov ch, al ;atualizar ch
            jmp movimento ;finalizar buscas

    
inversao: ;trocar direcao de '1'(subindo) para '0'(descendo) e vice-versa
    mov bx, offset direcao
        
    cmp [bx], '0'
    jz sobe ;se esta descendo, vou trocar para subindo
    mov [bx], '0' ;nao estava descendo, entao agora esta
    ret
    sobe:
       mov [bx], '1'
       ret    
      
          
movimento:          
    ;se o sensor da porta ativado, o movimento nao pode acontecer, volta pra leitura
    mov bx, offset porta
    cmp [bx], '1'
    jz leitura
    
    ;se cl igual a ch, andar atual eh igual ao destino, volta pra leitura
    cmp cl, ch
    jz leitura     
    
    mov al, cl ;AL sera um auxiliador para contagem
    sub al, 31h ;tirando 31h de AL para obter o indice
    mov bx, offset chamadas[al] ;endereco de chamadas[al]
    mov [bx], 30h ;volta para zero, ou seja, limpa as chamadas do andar atual
    add al, 31h ;volta para caracter      
    
    call printa_fechando
    
    mov bx, offset direcao
    cmp [bx], '1' ;subindo
    jz pra_cima
    jmp pra_baixo
    
    pra_cima:
        call printa_subindo
        inc cl
        call printa_andar
        
        cmp cl, ch  ;enquanto posicao atual for menor do que a desejada 
        jl pra_cima ;continua subindo
    ;chegou no andar
    mov cl, ch
    jmp inicio
    
    pra_baixo:
        call printa_descendo
        dec cl
        call printa_andar
        
        cmp cl, ch   ;enquanto posicao atual for maior do que a desejada
        jg pra_baixo ;continua descendo
    ;chegou no andar
    mov cl, ch
    jmp inicio
    
 
printa_aguardando:
    mov dx, offset aguardando
    mov ah, 9
    int 21h
    ret

printa_andar:
    mov dx, offset andar
    mov ah, 9
    int 21h

    mov ah, 2
    mov dl, cl
    int 21h
    ret    
    
printa_abrindo:
    mov dx, offset abrindo
    mov ah, 9
    int 21h
    ret
  
printa_fechando:
    mov dx, offset fechando
    mov ah, 9
    int 21h
    ret
    
printa_subindo:
    mov dx, offset subindo
    mov ah, 9
    int 21h
    call temporizador ;para tempo extra
    ret
    
printa_descendo:
    mov dx, offset descendo
    mov ah, 9
    int 21h
    call temporizador ;para tempo extra
    ret
    
printa_parado:
    mov dx, offset parado
    mov ah, 9
    int 21h
    ret

temporizador: ; contar de 1 a 10 como sugerido
    mov dh, 0 ; inicializa dh
    again:
        inc dh 
        cmp dh, 10
        jnz again
    ret
     
   
fim:
    nop
    ret

;vetor chamadas
;cada posicao representa um andar
;0 default, 1 foi chamado
;observacao: essa "chamada" para o andar pode ter sido feita por botoes internos ou externos
;observacao2: se estiver no andar pode ficar com valor 1, quando sair sera modificado para 0
chamadas db 31h, 30h, 30h, 30h, 30h, 30h, 30h, 30h


;flags
direcao db 31h ;1 -> subindo, 0 -> descendo
porta   db 30h ;0 -> livre, 1 -> alguem na porta


; mensagens para imprimir        
andar       dw " Andar atual: $"
abrindo     dw " Porta Aberta $"
fechando    dw " Porta Fechada $"
subindo     dw " Subindo $"
descendo    dw " Descendo $"
parado      dw " Elevador Parado $"
aguardando  dw " Aguardando Input $"


end

;      referencia
; Caracter      Hexa      Decimal
;    1           31         49
;    8           38         56

;    a           61         97
;    h           68         104

;    p           70         112
;    P           50         80
;    x           71         113
;    q           78         120
;    s           73         115
;    S           53         83