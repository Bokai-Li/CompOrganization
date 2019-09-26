#include <stdio.h>
int NchooseK(int n, int k){
if(k==0)
return 1;
else if(k==n)
return 1;
else
return NchooseK(n-1, k-1) + NchooseK(n-1, k);
}

int main()
{
int a,b;
do{
printf("Enter two integers (for n and k) separated by space:\n");
scanf("%i%i",&a,&b);
printf("%i\n",NchooseK(a,b));
}while(a!=0||b!=0);
}
