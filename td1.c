#include <stdlib.h>
#include <stdio.h>

int approx_pi_rec(int n, int s) {
  float a,b;

  if (n==0) 
    return(s);
  else {
    a = ((float) random())/RAND_MAX;
    b = ((float) random())/RAND_MAX;
    if ((a*a+b*b)<=1)
      return(approx_pi_rec(n-1,s+4));
    else
      return(approx_pi_rec(n-1,s));    
  }
}
   
void approx_pi(int n) {
  int s = approx_pi_rec(n,0);
  printf("Approx : %d/%d\n",s,n);
}  

int main(void) {
  approx_pi(10000);
  approx_pi(100000);
  approx_pi(1000000);
  approx_pi(10000000);
  return 1;
}
