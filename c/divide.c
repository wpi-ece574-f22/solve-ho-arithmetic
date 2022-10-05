#include <stdio.h>

void div(int y, int x, int *quot, int *rem) {

  // Evaluate 2^8 * Y as Q * X + R
  // ie. perform an 8-bit division Y/X

  // Restoring division
  int i;
  int tmp;
  int q, r;
  
  r = y;
  q = 0;
  
  for (i=0; i<8; i++) {
    
    tmp = 2 * r - x;

    if (tmp < 0) {

      q = q << 1;
      r =  tmp + x;

    } else {

      q = (q << 1) + 1;
      r = tmp;
      
    }

  }

  *quot = q;
  *rem  = r;
  
}

void main() {

  int q, r;
  int x, y;

  x = 45; y = 23;
  div(y, x, &q, &r);
  printf("Y %8d X %8d Q %8d R %8d. Check 2^8 * Y = %d. X * Q + R = %d\n", y, x, q, r, y << 8, x * q + r);

  x = 7; y = 2;
  div(y, x, &q, &r);
  printf("Y %8d X %8d Q %8d R %8d. Check 2^8 * Y = %d. X * Q + R = %d\n", y, x, q, r, y << 8, x * q + r);
  
}
