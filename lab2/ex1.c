#include <stdio.h>

int main()
{
  int i;

  printf("Please enter a number from 1 to 5:\n");
  scanf("%i", &i);
  if(i>5 || i<1)
  printf("Number is not in the range from 1 to 5\n");

  for(int x = 1; x <= i; x++)
  printf("%d Hello World\n", x);
}
