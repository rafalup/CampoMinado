.data
	bemVindo:		.string 	"Selecione a dificuldade do jogo:\n"
	newLine:		.string 	"\n" 
	space:			.string	" "
	facil:			.string		"1 - facil (5x5) \n"
	medio:			.string		"2 - medio (7x7) \n"
	dificil:		.string		"3 - dificil (9x9) \n"
	jogue:			.string 	"Escolha uma posição para fazer uma jogada:\n"
	jogueX:			.string 	"Posição X: "
	jogueY:			.string 	"Posição Y: "
	X:			.string 	"X"
	loser:			.string		"###########---VOCÊ PERDEU!---#############\n"
	winner:			.string         "###########---PARABÉNS! VOCÊ VENCEU!---###########\n"
	
	campo: 			.word 		0, 0, 0, 0, 0, 0, 0, 0, 			#Fique a vontade para inserir bombas manualmente na matriz à esquerda
						0, 0, 0, 0, 0, 0, 0, 0, 
						0, 0, 9, 0, 0, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 0, 
						0, 0, 0, 0, 9, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 0, 
						
						
	
.text
	
main:
