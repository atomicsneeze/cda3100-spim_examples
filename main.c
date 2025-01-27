#include <stdio.h>

int a,b,c;

void add2() {
   scanf("%d", &a);
   scanf("%d", &b);
   c = a + b;
   printf("sum of two integer value = %d\n", c);
}

int arrays[10] = {0};
void addglobalarray() {
   int i,temp;
   // initialize arrays[]
   for (i = 0; i < 10; i++) {
      printf("Type int value: ");
      scanf("%d", &temp);
      arrays[i] = temp;
   }

   for (i = 0; i < 10; i++) {
      temp = arrays[i];
      printf("%d\n", temp);
   }
}

void addglobalarraywithgoto() {
   int i,temp;
   // initialize arrays[]
   i = 0;
   L0:
   if (i < 10)
      goto L1;
   else
      goto L2;
   L1:
   printf("Type int value: ");
   scanf("%d", &temp);
   arrays[i] = temp;
   i++;
   goto L0;

   L2:
   i = 0;
   L00:
   if (i < 10)
      goto L10;
   else
      goto L20;
   L10:
   printf("%d\n", arrays[i]);
   i++;
   goto L00;
   L20:
   return;
}

void addlocalarraywithgoto() {
   int i,temp;
   int arrays[10];

   // initialize arrays[]
   i = 0;
   L0:
   if (i < 10)
      goto L1;
   else
      goto L2;
   L1:
   printf("Type int value: ");
   scanf("%d", &temp);
   arrays[i] = temp;
   i++;
   goto L0;

   L2:
   i = 0;
   L00:
   if (i < 10)
      goto L10;
   else
      goto L20;
   L10:
   printf("%d\n", arrays[i]);
   i++;
   goto L00;
   L20:
   return;
}

int main(void) {
   //add2();
   //addglobalarray();
   //addglobalarraywithgoto();
   addlocalarraywithgoto();

   return 0;
}
