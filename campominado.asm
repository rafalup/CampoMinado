    # TODAS AS VARIÁVEIS UTILIZADAS E OS REGISTRADORES:
    # a0 = matriz campo                    s4 = endereço da matriz campo
    # a1 = num_linhas                      t0 = coordenada x  
    # a2 = matriz usuario                  t1 = coordenada y
    # a3 = variável fim de jogo            t2 = contador de linha (y1)
    # s0 = contador de bombas              t3 = contador de coluna (x1)
    # s1 = posição de referência da matriz t4 = verificador utilizado no slt
    # s2 = num_linhas - 1                  t5 = posição da matriz    
    # s3 = posição da matriz

        .data
usuario:                    # matriz visualizada pelo usuário
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1,-1
#        .word   -1,-1,-1,-1,-1,-1,-1,-1
        
campo:			.space		256   # esta versão suporta campo de até 9 x 9 posições de memória
salva_S0:		.word		0
salva_ra:		.word		0
salva_ra1:		.word		0
        

abrir:			.string		"\n1 - Abrir Posição"
ins_flag:		.string		"\n2 - Inserir/Remover Bandeira\n"
opcao:			.string		"\nEscolha uma opção: "
op_invalida:		.string		"\n Opção Inválida!\n"
coordena:		.string		"\nDigite as coordenadas do campo minado (linha/coluna)(de 0 a 7):\n"
fim_jogo:		.string		"\nA BOMBA EXPLODIU! VOCE PERDEU!\n\n"
campomin:		.string		"\nCAMPO MINADO:\n"
coordinv:		.string		"\nA JOGADA INVALIDA. TENTE NOVAMENTE!\n"
band:			.string		"\nPOSIÇÃO COM BANDEIRA\n"
n_band:			.string		"\nBandeiras disponíveis: "
semflag:		.string		"\nSem Bandeiras disponíveis\n"
novalinh:		.string		"\n"
novbarra:		.string		"|"
novespac:		.string		" "
imprnove:		.string		" 9 "
imprflag:		.string		" F "
fechado:		.string		" - "
win:			.string		"\nVOCÊ VENCEU!!!\n\n"




	    .text
main:

        addi a1, zero, 8     # salva valor digitado em num_linhas
        addi a4, zero, 1
        addi s5, zero, 9
        addi s6, zero, -1
        addi s7, zero, 2
        addi s9, zero, 15

        add a3, zero, zero   # seta valor para a variável de controle o fim do jogo

        la a0, campo           # parâmetro da matriz campo (int * campo[])
        add a1, a1, zero     # parâmetro do tamanho da matriz campo (int num_linhas)
        jal insere_bombas       # chama função para inserir as bombas na matriz campo
	
	addi a1, zero, 8
        la a0, campo           # parâmetro da matriz campo (int * campo[])
        add a1, a1, zero     # parâmetro do tamanho da matriz campo (int num_linhas)
        jal calcula_bombas      # chama função para calcular todas as bombas ao redor de todas as posições

continua_main0:
        la a0, campo           # parâmetro da matriz campo
        add a1, a1, zero     # parâmetro do tamanho da matriz campo
        la a2, usuario         # parâmetro da matriz usuario
        add a3, a3, zero     # parâmetro da variável de fim de jogo
        jal mostra_campo        # printa campo minado
        
        #verifica vitoria
        
        beq s8, zero, vitoria
        
        #abrir posição ou inserir bandeira?
        la  a0, abrir       
        li  a7, 4              
        ecall           
        
        la  a0, ins_flag       # imprime mensagem para inserir posição
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string    

        
	la  a0, opcao       # imprime mensagem para inserir posição
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string    
        
        li  a7, 5              # seta valor de operação para pegar valor digitado pelo usuário
        ecall                 # pede para digitar coordenada linha (y)
        add t5, zero, a0
        
        #verifica_opção
        beq a0, a4, continua_main1
        beq a0, s7, continua_main1
        
        la  a0, op_invalida       
        li  a7, 4              
        ecall
        
        j continua_main0
        


continua_main1:
        la  a0, coordena       # imprime mensagem para inserir posição
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string

        li  a7, 5              # seta valor de operação para pegar valor digitado pelo usuário
        ecall                 # pede para digitar coordenada linha (y)
        add t1, zero, a0     # y (linhas)
        

        li  a7, 5              # seta valor de operação para pegar valor digitado pelo usuário
        ecall                 # pede para digitar coordenada coluna (x)
        add t0, zero, a0     # x (colunas)
        

        slt t4, t0, a1       # verifica se escolha de coordenada x é maior que o num_linhas
        beq t4, a4, else1
        la  a0, coordinv       # imprime mensagem de coordernadas invalidas
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string
        j continua_main1        # volta para continua_main1 para escolher novamente a coordenada da matriz

else1:
        slt t4, t1, a1       # verifica se escolha de coordenada y é maior que o num_linhas
        beq t4, a4, else2
        la  a0, coordinv       # imprime mensagem de coordernadas invalidas
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string
        j continua_main1        # volta para continua_main1 para escolher novamente a coordenada da matriz

else2:
        sltz t4, t0     # verifica se escolha de coordenada x é menor ou igual a 0
        beq t4, zero, else3
        la  a0, coordinv       # imprime mensagem de coordernadas invalidas
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string
        j continua_main1        # volta para continua_main1 para escolher novamente a coordenada da matriz

else3:
        sltz t4, t1     # verifica se escolha de coordenada y é menor ou igual a 0
        beq t4, zero, else4
        la  a0, coordinv       # imprime mensagem de coordernadas invalidas
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string
        j continua_main1        # volta para continua_main1 para escolher novamente a coordenada da matriz 
        
else4:
	#verificar se é abrir ou bandeira
	beq t5, s7, bandeira
	
	
        # variável para controle de posição da matriz:
        #(linha * numero_Colunas) + coluna
        mul s1, t1, a1         # posição_matriz = y * ordem da matriz (9)
        add s1, s1, t0       # posição_matriz += x
        addi a5, zero, 4
        mul s1, s1, a5         # posição_matriz *= 4 (para cálculo da posição)
        
        la a0, campo
        add a5, a0, s1

        lw  s3, (a5)     # salva endereço da posição campo
        
        la a2, usuario
        add a5, a2, s1
        sw  s3, (a5)   # salva valor de campo[x][y] em usuario[x][y]
        
        
        
        
        #verifica se tem uma bandeira na posição
        
        bgt s3, s5, tem_flag
        
        
        
        # verifica se há bomba na posição digitada pelo usuário para finalizar o jogo
        bne s3, s5, continua
        addi a3, zero, 1      # seta variável de fim de jogo para 1
        la  a0, fim_jogo       # salva mensagem de fim de jogo
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string
        
        la a0, campo           # parâmetro da matriz campo (int * campo[])
        add a1, a1, zero     # parâmetro do tamanho da matriz campo (int num_linhas)
        la a2, usuario         # parâmetro da matriz usuario (int * usuario[])
        add a3, a3, zero     # parâmetro da variável de fim de jogo (int fim_jogo)
        jal mostra_campo        # imprime o campo minado pela ultima vez com as bombas
        j final                 # finaliza o jogo
        


bandeira:
	
	mul s1, t1, a1         # posição_matriz = y * ordem da matriz (9)
        add s1, s1, t0       # posição_matriz += x
        addi a5, zero, 4
        mul s1, s1, a5         # posição_matriz *= 4 (para cálculo da posição)
        
        la a0, campo
        add a5, a0, s1

        lw  s3, (a5)     # salva endereço da posição campo
        
	bgt s3, s5, tira_flag
	beq s9, zero, zero_flag
	
	addi s3, s3, 10
	addi s9, s9, -1
	
	sw s3, (a5)
	
	la a2, usuario
        add a5, a2, s1
        sw  s3, (a5)
        
        
        la  a0, n_band       
        li  a7, 4              
        ecall
        
        li a7, 1               
        add a0, s9, zero    
        ecall
        
        la  a0, novalinh       
        li  a7, 4              
        ecall
	
	j	continua
	
	
tira_flag:
	
	addi s3, s3, -10
	addi s9, s9, 1
	
	sw s3, (a5)
	
	la a2, usuario
        add a5, a2, s1
        sw  s6, (a5)
        
        
        la  a0, n_band       
        li  a7, 4              
        ecall
        
        li a7, 1               
        add a0, s9, zero    
        ecall
        
        la  a0, novalinh       
        li  a7, 4              
        ecall
	
	j	continua
	


zero_flag:
	
	la  a0, semflag       
        li  a7, 4              
        ecall
	
	
	j	continua
	
	
	      
tem_flag:
	
	la  a0, band       
        li  a7, 4              
        ecall     
	j	continua
        

        
continua:
        j continua_main0        # continua o jogo printando o campo minado e pedindo outra coordenada
        


mostra_campo:                   # void mostra_campo(int * campo[], int num_linhas, int * usuario[], int fim_jogo);
        # essa função imprimirá a matriz usuario, mas necessita da matriz campo e da variável fim_jogo para saber
        # se será impresso uma bomba ou não
        
        add s4, a0, zero     # salva endereço da matriz campo
        
        add s8, zero, zero

	la  a0, campomin       # imprime mensagem para mostrar campo minado
        li  a7, 4              # seta valor de operação para string
        ecall                 # imprime string

        add t2, zero, zero   # reseta variável do laço que percorre as linhas

for:
        addi t3, zero, -1     # reseta variável do laço que percorre as colunas; é setado com valor -1 
        # pelo fato de haver um "continue" na função, necessitando de um ++ no início do laço para
        # ignorar a posição da matriz que o chamou e para começar da posição 0 e não da posição 1
        beq t2, a1, exit      # verifica fim do for

for2:
        addi t3, t3, 1        # aumenta contador de colunas
        beq t3, a1, exit1     # verifica fim do for2

        mul s1, t2, a1         # posição_matriz = y1 (linhas) * ordem da matriz (9)
        add s1, s1, t3       # posição_matriz += x1 (colunas)
        addi a5, zero, 4
        mul s1, s1, a5         # posição_matriz *= 4 (para cálculo da posição)
        add s3, s1, a2       # calcula endereço da posição da matriz usuario
        lw  s3, 0(s3)         # salva posição da matriz usuario
        add t5, s1, s4       # calcula endereço da matriz campo
        lw  t5, 0(t5)         # salva posição da matriz campo
        
        # imprime uma barra
        la a0, novbarra        # carrega string
        li a7, 4               # seta valor de operação para string
        ecall                 # imprime string
        
        # verifica variável de fim de jogo para saber o que imprimir; se a posição é bomba entao 
        # imprime a bomba e não a posição da matriz usuario, depois retorna, como um "continue",
        # para o laço continuar a imprimir as demais posições
        bne a3, a4, if20  	#verifica gameover    
        bne t5, s5, if20        # verifica se a posição da matriz campo[x1][y1] == 9
        # imprime valor 9
        la a0, imprnove        # carrega string
        li a7, 4               # seta valor de operação para string
        ecall                 # imprime string
        j for2                  # volta para for2 porque o valor é bomba

if20:                   
        # verifica necessidade de imprimir um espaço, servindo como forma de justificacao de impressão 
        # do campo minado, pois "-1" ocupa o espaço de dois char
        beq s3, s6, if21
        bgt s3, s5, if22
        # imprime um espaço
        la a0, novespac        # carrega string
        li a7, 4               # seta valor de operação para string
        ecall                 # imprime string
        
        li a7, 1               # seta valor de operação para integer
        add a0, s3, zero     # salva valor de s3 em a0 para ser impresso
        ecall                 # imprime string
        
        la a0, novespac        # carrega string
        li a7, 4               # seta valor de operação para string
        ecall                 # imprime string

        j for2  

if21:
        # imprime as posições
        la a0, fechado
        li a7, 4               # seta valor de operação para integer
        ecall                 # imprime string
        
        addi s8, s8, 1

        j for2                  # volta para for2
        
        
if22:
	
        la a0, imprflag
        li a7, 4               # seta valor de operação para integer
        ecall                 # imprime string

        j for2                  # volta para for2

exit1:
        # imprime uma barra
        la a0, novbarra        # carrega string
        li a7, 4               # seta valor de operação para string
        ecall                 # imprime string
        # imprime nova linha
        la a0, novalinh        # carrega string
        li a7, 4               # seta valor de operação para string
        ecall                 # imprime string
        addi t2, t2, 1        # aumenta contador de linha
        j for                   # volta para for
exit:
        
        ret

calcula_bombas:                 # void calcula_bombas(int * campo[], int num_linhas);
        add s2, a1, zero        # num_linhas - 1
        add t2, zero, zero   # reseta variável do laço que percorre as linhas

for10:
        addi t3, zero, -1     # reseta variável do laço que percorre as colunas; é setado com valor -1 
        # pelo fato de haver um "continue" na função, necessitando de um ++ no início do laço para
        # ignorar a posição da matriz que o chamou e para começar da posição 0 e não da posição 1
        beq t2, a1, fim1      # verifica fim do for10

for11:
        add s0, zero, zero   # reseta contador de bombas
        addi t3, t3, 1        # aumenta contador de colunas
        beq t3, a1, fim2      # verifica fim do for11

        mul s1, t2, a1         # posição_matriz = y1 (linhas) * ordem da matriz (9)
        add s1, s1, t3       # posição_matriz += x1 (colunas)
        addi a5, zero, 4
        mul s1, s1, a5         # posição_matriz *= 4 (para cálculo da posição)

        add s3, s1, a0       # calcula endereço da matriz campo[x1][y1]
        lw  s3, 0(s3)         # salva posição da matriz

        # verifica se a posição é bomba; se ela for, retorna, como um "continue", para o laço
        # para ignorar essa posição, já que não preciso saber o número de bombas ao redor
        # de uma posição que já é bomba
        bne s3, s5, if01        # verifica se posição da matriz campo[x1][y1] == 9
        j for11                 # volta para for11 porque o valor é bomba

if01:

        addi s3, s1, -4        # posição_matriz -= 4 (M[x1-1][y1])
        addi s3, s3, -32       # posição_matriz -= 36 (M[x1-1][y1-1])
        add s3, a0, s3       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz

        beq t2, zero, if02        # verifica y1 != 0
        beq t3, zero, if02        # verifica x1 != 0
        bne s3, s5, if02        # verifica campo[x1 - 1][y1 - 1] == 9
        addi s0, s0, 1        # i++

if02:
        addi s3, s1, -32       # posição_matriz -= 36 (M[x1][y1-1])
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz

        beq t2, zero, if03        # verifica y1 != 0
        bne s3, s5, if03        # verifica campo[x1][y1 - 1] == 9
        addi s0, s0, 1        # i++

if03:
        addi s3, s1, 4        # posição_matriz += 4 (M[x1+1][y1])
        addi s3, s3, -32       # posição_matriz -= 36 (M[x1+1][y1-1])
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz
        
        beq t3, s2, if04      # verifica x1 != num_linhas
        beq t2, zero, if04        # verifica y1 != 0
        bne s3, s5, if04        # verifica campo[x1 + 1][y1 - 1] == 9
        addi s0, s0, 1        # i++

if04:
        addi s3, s1, -4        # posição_matriz -= 4 (M[x1-1][y1]) 
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz
        
        beq t3, zero, if05        # verifica x1 != 0
        bne s3, s5, if05        # verifica campo[x1 - 1][y1] == 9
        addi s0, s0, 1        # i++

if05:
        addi s3, s1, 4        # posição_matriz += 4 (M[x1+1][y1]) 
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz
        
        beq t3, s2, if06      # verifica x1 != num_linhas
        bne s3, s5, if06        # verifica campo[x1 + 1][y1] == 9
        addi s0, s0, 1        # i++

if06:
        addi s3, s1, -4        # posição_matriz -= 4 (M[x1-1][y1])
        addi s3, s3, 32       # posição_matriz += 36 (M[x1-1][y1+1])
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz

        beq t3, zero, if07        # verifica x1 != 0
        beq t2, s2, if07      # verifica y1 != num_linhas
        bne s3, s5, if07        # verifica campo[x1 - 1][y1 + 1] == 9
        addi s0, s0, 1        # i++

if07:
        addi s3, s1, 32       # posição_matriz += 36 (M[x1][y1+1])
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz
        
        beq t2, s2, if08      # verifica y1 != num_linhas
        bne s3, s5, if08        # verifica campo[x1][y1 + 1] == 9
        addi s0, s0, 1        # i++

if08:
        addi s3, s1, 4        # posição_matriz += 4 (M[x1+1][y1])
        addi s3, s3, 32       # posição_matriz += 36 (M[x1+1][y1+1])
        add s3, s3, a0       # calcula endereço da matriz a ser verificado se o dado é uma bomba
        lw  s3, 0(s3)         # salva posição da matriz

        beq t3, s2, continua1 # verifica se x1 != num_linhas
        beq t2, s2, continua1 # verifica se y1 != num_linhas
        bne s3, s5, continua1   # verifica se campo[x1 + 1][y1 + 1] == 9
        addi s0, s0, 1        # i++

continua1:
        add s3, s1, a0       # calcula endereço da matriz na qual o dado vai ser substituido 
                                # pelo numero de bombas que ha ao seu redor 
        sw  s0, 0(s3)         # seta o valor de bombas ao redor da posição
        j for11                 # volta para for11

fim2:
        addi t2, t2, 1        # aumenta contador de linhas da matriz
        j for10                 # volta para for10

fim1:
        ret

insere_bombas:                  # void insere_bombas(int * campo[], int num_linhas);
        # codigo da função insere bombas aqui
       	 la	t0, salva_S0
		sw  	s0, 0 (t0)		# salva conteudo de s0 na memoria
		la	t0, salva_ra
		sw  	ra, 0 (t0)		# salva conteudo de ra na memoria
		
		add 	t0, zero, a0		# salva a0 em t0 - endereço da matriz campo
		add 	t1, zero, a1		# salva a1 em t1 - quantidade de linhas 

QTD_BOMBAS:
		addi 	t2, zero, 15 		# seta para 15 bombas	
		add 	t3, zero, zero 	# inicia contador de bombas com 0
		addi 	a7, zero, 30 		# ecall 30 pega o tempo do sistema em milisegundos (usado como semente
		ecall 				
		add 	a1, zero, a0		# coloca a semente em a1
INICIO_LACO:
		beq 	t2, t3, FIM_LACO
		add 	a0, zero, t1 		# carrega limite para %	(resto da divisão)
		jal 	PSEUDO_RAND
		add 	t4, zero, a0		# pega linha sorteada e coloca em t4
		add 	a0, zero, t1 		# carrega limite para % (resto da divisão)
   		jal 	PSEUDO_RAND
		add 	t5, zero, a0		# pega coluna sorteada e coloca em t5

###############################################################################
# imprime valores na tela (para debug somente) - retirar comentarios para ver
#	
#		li	a7, 4		# mostra texto "Posicao: "
#		la	a0, posicao
#		ecall
#		li	a7, 1
#		add 	a0, zero, t4 	# imprime a linha sorteada	
#		ecall
#
#		add 	a0, zero, t5 	# imprime coluna sorteada
#		ecall
#		
#		li	a7, 4		# imrpime espaço
#		la	a0, espaco
#		ecall
#		li	a7, 1		
#		add 	a0, zero, t3 	# imprime quantidade ja sorteada
#		ecall
#		
##########################################################################	

LE_POSICAO:	
		mul  	t4, t4, t1
		add  	t4, t4, t5  		# calcula (L * tam) + C
		add  	t4, t4, t4  		# multiplica por 2
		add  	t4, t4, t4  		# multiplica por 4
		add  	t4, t4, t0  		# calcula Base + deslocamento
		lw   	t5, 0(t4)   		# Le posicao de memoria LxC
VERIFICA_BOMBA:		
		addi 	t6, zero, 9		# se posição sorteada já possui bomba
		beq  	t5, t6, PULA_ATRIB	# pula atribuição 
		sw   	t6, 0(t4)		# senão coloca 9 (bomba) na posição
		addi 	t3, t3, 1		# incrementa quantidade de bombas sorteadas
PULA_ATRIB:
		j	INICIO_LACO

FIM_LACO:					# recupera registradores salvos
		la	t0, salva_S0
		lw  	s0, 0(t0)		# recupera conteudo de s0 da memória
		la	t0, salva_ra
		lw  	ra, 0(t0)		# recupera conteudo de ra da memória		
		ret			# retorna para funcao que fez a chamada
		
##################################################################
# PSEUDO_RAND
# função que gera um número pseudo-randomico que será
# usado para obter a posição da linha e coluna na matriz
# entrada: a0 valor máximo do resultado menos 1 
#             (exemplo: a0 = 8 resultado entre 0 e 7)
#          a1 para o número pseudo randomico 
# saida: a0 valor pseudo randomico gerado
#################################################################
#int rand1(int lim, int semente) {
#  static long a = semente; 
#  a = (a * 125) % 2796203; 
#  return (|a % lim|); 
# }  

PSEUDO_RAND:
		addi t6, zero, 125  		# carrega constante t6 = 125
		lui  t5, 682			# carrega constante t5 = 2796203
		addi t5, t5, 1697 		# 
		addi t5, t5, 1034 		# 	
		mul  a1, a1, t6			# a = a * 125
		rem  a1, a1, t5			# a = a % 2796203
		rem  a0, a1, a0			# a % lim
		bge  a0, zero, EH_POSITIVO  	# testa se valor eh positivo
		addi t4, zero, -1           	# caso não 
		mul  a0, a0, t4		    	# transforma em positivo
EH_POSITIVO:	
		ret				# retorna em a0 o valor obtido
############################################################################

       # ret

vitoria:
	la  a0, win       
        li  a7, 4              
        ecall
	ebreak

final:
	ebreak
