#include<stdio.h>
void move(int n, int source, int target, int aux)
{
    if (n == 1)
    {
        printf("Move disk %d from Peg %d to Peg %d\n" ,n, source, target);
        return;
    }
    move(n-1, source, aux, target);
    printf("Move disk %d from Peg %d to Peg %d\n", n, source, target);
    move(n-1, aux, target, source);
}
int main()
{
    int value;
    scanf("%d", &value);
    move(value, 1,3,2); 
    return 0;
}