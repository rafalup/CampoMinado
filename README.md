## Trabalho de Campo Minado

### Descrição do trabalho

Implemente um programa que permita ao usuário jogar Campo Minado.

O programa deve ser implementado utilizando o conjunto de instruções RV32I e RV32M do RISC-V e deve ser executado no simulador RARS.

O programa permite ao usuário jogar campo minado em um 'tabuleiro' de 8x8. Internamente o tabuleiro é uma matriz (chamada campo) com tamanho fixo de 8x8 e é composta de números inteiros a qual deve ser inicializada com zeros pelo programador. A matriz campo representa as posições do campo minado, onde cada posição (linha x coluna) pode ou não conter uma bomba.

O programa deve ser implementado com uma função principal (main) e pelo menos duas outras funções:

- função calcula_bombas com o seguinte protótipo:

void calcula_bombas(int * campo[], int num_linhas);

- função mostra_campo (cada aluno pode definir o protótipo da mesma);

Os parâmetros de calcula_bombas devem ser passado nos registradores a0 e a1, respectivamente.

Após inicializar as variáveis de controle o programa deve chamar uma função chamada insere_bombas, com o seguinte protótipo:

void insere_bombas(int * campo[], int num_linhas);

A função insere_bombas não precisa ser codificada pelo aluno pois será fornecida pelo professor. Os parâmetros de insere_bombas deve ser passado nos registradores a0 e a1, respectivamente. Esta função colocará as bombas na matriz campo.

As bombas são representadas pelo valor 9 armazenado na posição (linha x coluna). Assim, na matriz campo as cadas que possuirem o valor 9 possuem bomba naquela posição. O programa deve permitir inserir bandeiras nas casas (linha x coluna) impmpedindo que a casa seja aberta posteriormente (no caso, abrir o campo naquela posição).

O programa deve apresentar uma interface que permite ao usuário (a) abrir uma posição (mostrar o número de bombas presentes no entorno) e (b) inserir uma bandeira ou retirar uma bandeira em uma posiçção. Após escolher entre as opções (a) ou (b) o usuário deve digitar o número da linha e da coluna que pretende jogar (bandeira ou abrir a posição, conforme escolha anterior).

Caso tenha uma bomba na posição jogada o programa deve indicar que uma bomba explodiu e o usuário perdeu (mostrando na interface a própria matriz campo, com a quantidade de bombas no entorno das posições, as posições das bombas e as posições das bandeiras); Caso não tenha uma bomba naquela posição o programa deve mostrar a situação do campo (mostrando a quantidade de bombas no entorno das posições já jogadas e as bandeiras já colocadas); Caso a posição escolhida para abrir tenha uma bandeira uma mensagem informado que a posição não pode ser aberta (jogada inválida).

### Dicas e exemplo:

- Logo após a chamada da função insere_bombas chamar a função calcula_bombas para realizar a contagem de bombas vizinhas em cada posição e armazenar na matriz campo esta informação (veja figura abaixo);

- Utilizar a matriz campo para o controle e uma outra matriz para a interface com o usuário;

- Sinalizar as bandeiras inseridas somando 10 na quantidade de bombas na matriz campo;

- A cada jogada do usuário fazer as marcações apropriadas na matriz campo e na matriz da interface, por exemplo, copiando a quantidade de bombas da matriz campo para a matriz interface, na posição da jogada; somando 10 na posição onde a bandeira foi colocada e colocando a letra F na matriz da interface, etc;

