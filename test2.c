/*
 * test2.c
 *
 *   コンパイル：gcc test2.c -lm
 *   実行：      ./a.out
 *   システム内最大データ数 (K), 呼量 (a) を入力する。
 *
 *   ※ データ廃棄率(B)、平均データ数(N)の式を入れる。今のままでは常に"0"を出力。
 */

#include <stdio.h>
#include <math.h>

int
main(void)
{
	long int	K, j;
	double		P_K, P_0;
	double		a;
	double		B, N, D;

        /* データ入力 ================================================= */
	puts("システム内最大データ数 (K), 呼量 (a)?");
	scanf("%ld, %lf", &K, &a);

        /* n=K の時の状態確率 P_K の計算 ============================= */
	P_0 = 1.0;
	P_K = 1.0; /* まずは n=0 のときの P_n を 1 とする */

	for(j = 1; j <= K; j++){
	  P_K = a * P_K;  /* P_1, P_2, ... と順次 P_n を計算していって,  */
	  P_0 += P_K;     /* 変数 "P_0" にそこまでの和を収納する */
	}

	P_K = P_K/P_0;    /* 最後に全項の和の入った変数 "P_0" で n=K のときの P_n を割る */

        /* 緒量の計算 ================================================== */
	/* データ廃棄率 */
	B = 0;

	/* N: 平均データ数 */
	N = 0;

	/* D: 規格化平均システム遅延時間 */
	D = N/ a/(1.0 -B);

        /* 結果の出力 ================================================== */
	/* printf("K= %d a= %f B= %11.10f D= %10.6g\n",K,a,B,D); */
	printf("K= %d a= %f B= %e D= %e\n",K,a,B,D);
}
