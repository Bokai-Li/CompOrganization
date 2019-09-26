#include <stdio.h>
int main()
{

int num;
do{
printf("Number ?\n");
scanf("%d",&num);

if(num==1)
   printf("1 is non-prime (special case)\n");
else if(num==2)
   printf("2 is a prime\n");
else{
   for(int i = 2;i<num;i++)
   {
	if(num%i==0)
	{
	printf("%d is non-prime, divisible by %d\n",num, i);
	break;
	}
	if(i==num-1)
	{
	printf("%d is a prime\n",num);
	}
   }
 }
}while(num!=0);

printf("Done\n");

}
