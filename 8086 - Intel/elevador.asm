;comandos do teclado:

; 1 a 8 -> andar de chamada
; a a h -> andar de destino
; p -> parada
; P -> desativa pausa
; x -> reset, volta configuracoes para comeco
; q -> quit, finaliza programa imediatamente
; t -> terminou, sinaliza que nao tem mais dados para leitura

;registradores
;ah sera usado na leitura
;al armazena resultado da leitura
;dx utilizado para output

;bl andar atual do elevador
;bh proximo andar

org 100h

reset:

mov bl, '1' ; bl vai mostrar o andar atual do elevador
mov bh, '1' ; bh vai indicar o proximo andar que o elevador vai

;rotina
;estou no andar tal
;porta aberta
;leitura
;procura proximo andar
;se encontrou:
;porta fechada
;subindo/descendo
;estou no andar tal 

call printa_andar
call printa_abrindo

call printa_aguardando
    
leitura:    
;leitura, valor fica em AL
mov ah, 1
int 21h
mov dl, al ;valor lido ficara temporariamente em DL

;identifica o que foi lido
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
jmp reseta  
cmp dl, 'q'
jmp fim

cmp dl, 0Dh
jmp fim_leitura



um:
    mov ax, chamadas    ; AX <= endereco de chamadas
    mov ax, 1 ;colocando 1 para andar 1 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler


dois:
    mov ax, chamadas   ; AX <= endereco de chamadas
    add ax, 1
    mov ax, 1 ;colocando 1 para andar 2 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler


tres:
    mov ax, chamadas     ; AX <= endereco de chamadas
    add ax, 2
    mov ax, 1 ;colocando 1 para andar 3 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
quatro:
    mov ax, chamadas     ; AX <= endereco de chamadas
    add ax, 3
    mov ax, 1 ;colocando 1 para andar 4 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
cinco:
    mov ax, chamadas     ; AX <= endereco de chamadas
    add ax, 4
    mov ax, 1 ;colocando 1 para andar 5 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
seis:
    mov ax, chamadas     ; AX <= endereco de chamadas
    add ax, 5
    mov ax, 1 ;colocando 1 para andar 6 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
sete:
    mov ax, chamadas     ; AX <= endereco de chamadas
    add ax, 6
    mov ax, 1 ;colocando 1 para andar 7 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
oito:
    mov ax, chamadas     ; AX <= endereco de chamadas
    add ax, 7
    mov ax, 1 ;colocando 1 para andar 8 no meu vetor de chamadas
    jmp leitura ;volta para procurar mais coisa para ler
    
para:
    mov ah, 1 
    int 21h     ;leitura, valor ficara em AL
    cmp al, 'P'
    jnz para  ;nao sai enquanto nao ler P
    jmp leitura

reseta:
    cmp bl, '1'
    jz reset ;se ja estava no terreo, volta para o inicio do programa
    call printa_fechando
    call printa_descendo
    jmp reset

fim_leitura:
    jmp fim

 
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
    mov dl, bl
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
    ret
    
printa_descendo:
    mov dx, offset descendo
    mov ah, 9
    int 21h
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
chamadas: db '1', '0', '0', '0', '0', '0', '0', '0'

; mensagens para imprimir        
andar       dw " Andar atual: $"
abrindo     dw " Porta Aberta $"
fechando    dw " Porta Fechada $"
subindo     dw " Subindo $"
descendo    dw " Descendo $"
parado      dw " Elevador Parado $"
aguardando  dw " Aguardando Input $"


