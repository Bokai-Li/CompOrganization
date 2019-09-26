/* Example: analysis of text */

#include <stdio.h>
#include <string.h>

#define MAX 1000 /* The maximum number of characters in a line of input */

int main()
{
  char text[MAX];
  int i;
  int length;
  int j = 0;
  int same = 0;
  puts("Type some text (then ENTER):");
  
  /* Save typed characters in text[]: */
    
  fgets(text, MAX, stdin);
  length = strlen(text)-1;
  char palindrome[length+1];
  palindrome[length]='\0';
  
  j=length;
  for(int i=0;i<length;i++)
  {
      j--;
      palindrome[j]=text[i];
   }
   printf("Your input in reverse is:\n%s\n",palindrome);
   for(int k=0;k<length;k++)
   {
     if(palindrome[k]!=text[k])
    {
       same = 1;
       break;
    }
   }
if(same==0)
	printf("Found a palindrome!\n");
}
