//
// Created by Gang-Ryung Uh on 3/10/25.
//
#include <stdio.h>

int factorial(int arg) {
   int value = arg;
/*
   while (--arg > 0)
      value = value * arg;
*/
   arg--;
LOOP:
   if (arg > 0)
      goto L1;
   else
      goto L2;
L1:
   value = value * arg;
   arg--;
   goto LOOP;
L2:
   return value;
}

int main() {
   int value;
   value = factorial(4);
   printf("factorial = %d\n", value);
   return 0;
}
