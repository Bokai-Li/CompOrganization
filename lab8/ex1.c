#include<stdio.h>
#include<string.h>
char input[22];     // To read in a string of up to 20 hexits plus newline and null

int h_to_i(char* str);

int main() {

  int value;
  do{

                    // Do the following inside a loop

    fgets(input, 22, stdin);

    
    value = h_to_i(input);
    if(value==0)
      break;

    printf("%d\n", value);

  
  }while(value!=0);
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
