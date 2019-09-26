#include<stdio.h>
#include<string.h>
char input1[22];     // To read in a string of up to 20 hexits plus newline and null
char input2[22];     // To read in a string of up to 20 hexits plus newline and null

int h_to_i(char* str);
int NchooseK(int n, int k);

int main() {

  int n, k, result;
  do{

                    // Do the following inside a loop

    fgets(input1, 22, stdin);

    n = h_to_i(input1);

    if(n==0)
      break;

    fgets(input2, 22, stdin);

    k = h_to_i(input2);

    result = NchooseK(n, k);

    printf("%d\n", result);

  }while(n!=0);
}


int h_to_i(char* str) {
  int length = strlen(str);
  int value = 0;
  int character;
  int i;
  for(i = 0; i<length-2;i++)
  {
    character = str[i];
    if(character <='9')
      character = character - 48;
    if(character >='a')
      character = character - 87;
    value = (character+value) * 16;
  }
  character = str[i];
    if(character <='9')
      character = character - 48;
    if(character >='a')
      character = character - 87;
  value = value + character;
  return value;
}


int NchooseK(int n, int k) {
  if(k==0)
    return 1;
  if(n==k)
    return 1;
  return NchooseK(n-1,k-1) + NchooseK(n-1,k);
}
