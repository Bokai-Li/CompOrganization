#include <stdio.h>
int main()
{

int num;
do{
printf("Number ?\n");
scanf("%d",&num);

   for(int i = 0;i<num;i++)
   {
	int powNum=1;
//	if(i!=0)
//	{
//	   powNum=1;
	   for(int k = 0; k<i;k++)
	   {
	      powNum=powNum*2;
	   }
//	}
	if(num==powNum)
	{
	printf("%d is a power of two (%d)\n",num, i);
	break;
	}else
	if(num<powNum)
	{
	int j = i-1;
	printf("%d is not a power of two, between %d and %d\n",num,j,i);
	break;
	}
   }
}while(num!=0);

printf("Done\n");

}
