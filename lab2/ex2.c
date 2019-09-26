#include <stdio.h>
int main()
{
float sum, min, max, product,a;
printf("Enter five floating-point numbers:\n");
scanf("%f",&a);
sum=min=max=product=a;
for(int i = 0; i<4;i++)
{
scanf("%f",&a);
sum = sum + a;
if(a<min){min=a;}
if(a>max){max=a;}
product = product * a;
}
printf("Sum is %.4f\n",sum);
printf("Min is %.4f\n",min);
printf("Max is %.4f\n",max);
printf("Product is %.4f\n",product);
}
