#include<stdio.h>

char magic[5];     // more than enough space to read in "P3\n" plus null

int rgb_to_gray(int r, int g, int b, int ppm_max);
void iterate_through_pix(int rows, int cols, int ppm_max);

int main() {
  int rows, cols;
  int ppm_max;
  int x1,x2,y1,y2;
  //fgets(magic, 5, stdin);
  puts("P3");
 
  scanf("%d%d%d%d%d%d", &x1,&x2,&y1,&y2,&cols, &rows);
  printf("%d\n%d\n", cols, rows);

  scanf("%d", &ppm_max);
  printf("%d\n", 255);

  int i, j;
  int r, g, b, gray;

  for(i=0; i<rows; i++) {
    for(j=0; j<cols; j++) {
      scanf("%d%d%d", &r, &g, &b);
	  if(j<x1||j>x2||i<y1||i>y2)
	  {
     	 gray = rgb_to_gray(r, g, b, ppm_max);
		 printf("%d\n%d\n%d\n",gray,gray,gray);
		 }
      else
	  	printf("%d\n%d\n%d\n", r,g,b);
    }
  }
}


int rgb_to_gray(int r, int g, int b, int ppm_max) {
  return ((r*30 + g*59 + b*11) * 255) / (100 * ppm_max);  // Follow exactly this ordering in assembly
}