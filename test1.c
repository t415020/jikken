/*
 * test1.c
 *
 *   コンパイル：gcc test1.c
 *   実行：      ./a.out
 *   回線数(S)、呼量(a) を入力する。
 *   24行めの "B = 1;" の部分を漸化式に基づいて変更する。
 */

#include <stdio.h>

int
main(void)
{
	long int	S, j;
	double 		a;
	double		R, B, b;

	S = 50;

      /*B = 1;
        b = 1;*/

        /*for(j = 1; j <= S; j++){
	  B = b*a/(j+(b*a));
          b = B;
	}*/

        for(a = 0; a <= 200; a++){
					B = 1;
          for(j = 1; j <= S; j++){
          B = B*a/(j+(B*a));
          }
          printf("%d %10.9f\n",(int)a,B);
        }

	R = (double)1.0*a*(1-B)/S;

	/*printf("B = %10.9f, a = %10.9f, R = %10.6g\n",B,a,R);*/
}
