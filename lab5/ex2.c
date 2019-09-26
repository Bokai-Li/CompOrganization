#include<stdio.h>
#include<stdlib.h>

#define true 1
#define false 0

void bedtimestory(char words[20][15], int current, int number) {
  if(current==0)//first one
  	printf("A %s couldn't sleep, so her mother told a story about a little %s,\n",words[current],words[current+1]);                   // Print something before
  else if(current==number){//last one
        for(int i=0; i<current*2;i++)
                printf(" ");
        printf("... who fell asleep.\n");
  }else{//general case
	for(int i=0; i<current*2;i++)
		printf(" ");
	printf("who couldn't sleep, so the %s's mother told a story about a little %s,\n",words[current],words[current+1]);
  }
  
  if(current<number)
	bedtimestory(words,current+1,number);                   // Recursive call to bedtimestory()
  
  if(current==0){//last one                   // Print something after
	printf("... and then the %s fell asleep.\n",words[current]);  
  }
  else if(current==number){
  }
else{//general case
        for(int i=0; i<current*2;i++)
                printf(" ");
        printf("... and then the little %s fell asleep;\n",words[current]);
}
}
int main() {
  char names[20][15];   // Up to 20 names, each up to 15 letters long (incl. NULL)
  int num=0;
  do{
  fgets(names[num],15,stdin);                   // Read the names from the input
  for(int j = 0; j<15; j++)
  {
	if(names[num][j]=='\n'){ 
    		names[num][j] = '\0';
		break;
	}
  }
 
  if(names[num][0]=='E'&&names[num][1]=='N'&&names[num][2]=='D'){
	break;
  }
  num++;                      // until you read "END" 
}while(num<20);

  bedtimestory(names, 0, num-1);
}
