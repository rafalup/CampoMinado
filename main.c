#include <stdio.h>

void mostra_campo(int campo[8][8], int user[8][8], int b, int a)
{
    puts("SITUACAO DO CAMPO MINADO");
    for (int i = 0; i < b; i++)
    {
        for (int j = 0; j < b; j++)
        {
            if (a == 1 && campo[i][j] == 9)
            {
                printf(" 8 ");
                continue;
            }
            if (user[i][j] == -1)
                printf("%d ", user[i][j]);
            else
                printf(" %d ", user[i][j]);
        }
        puts("");
    }
}

void calcula_bomba(int campo[8][8], int b)
{
    int j = b - 1;
    for (int x = 0; x < b; x++)
    {
        for (int y = 0; y < b; y++)
        {
            int i = 0;
            if (campo[x][y] == 8)
                continue;

            if (x != 0 && y != 0 && campo[x - 1][y - 1] == 8)
                i++;
            if (x != 0 && campo[x - 1][y] == 8)
                i++;
            if (x != 0 && y != j && campo[x - 1][y + 1] == 8)
                i++;
            if (y != 0 && campo[x][y - 1] == 8)
                i++;
            if (y != j && campo[x][y + 1] == 8)
                i++;
            if (x != j && y != 0 && campo[x + 1][y - 1] == 8)
                i++;
            if (x != j && campo[x + 1][y] == 8)
                i++;
            if (x != j && y != j && campo[x + 1][y + 1] == 8)
                i++;
            campo[x][y] = i;
        }
    }
}

int main()
{
    int campo[8][8] = {
        {0, 9, 9, 9, 0, 9, 0, 9},
        {0, 0, 0, 0, 0, 0, 9, 9},
        {0, 0, 9, 9, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 9},
        {0, 9, 0, 9, 9, 0, 9, 0},
        {0, 9, 0, 0, 0, 9, 9, 9},
        {0, 0, 9, 0, 0, 0, 0, 0},
        {9, 0, 0, 9, 0, 9, 0, 9}};
    int user[8][8] = {
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1},
        {-1, -1, -1, -1, -1, -1, -1, -1}};
    int x, y, b=8;
    int a = 0;
   
    //insere_bombas(campo, b);
    calcula_bomba(campo, b);

    while (1)
    {
        mostra_campo(campo, user, b, a);
        puts("\nDigite as coordenadas do campo minado (coluna)(linha): ");
        scanf("%d", &y);
        scanf("%d", &x);
        puts("");
        if (y > b || x > b || x == 0 || y == 0)
            continue;
        x--;
        y--;
        user[x][y] = campo[x][y];
        if (campo[x][y] == 8)
        {
            a = 1;
            printf("\nA BOMBA EXPLODIU! VOCE PERDEU!\n");
            mostra_campo(campo, user, b, a);
            break;
        }
    }
}
