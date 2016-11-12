/*
 * traf.c
 *
 *   コンパイル：gcc traf.c -lm
 *   実行：      ./a.out
 *   呼量(a), 回線数(S), 溢れ呼総量(jend), 乱数初期値(ix) を入力する。
 *   乱数初期値(ix) については、各自の学籍番号の頭の0をとり、最後に"07"を付ける。
 *            例： 学籍番号が 1415000 の場合、41500007 が初期値となる。
 *
 *   出力ファイル overflow.dat & poisson.dat には溢れ呼、poisson呼それぞれの階級の度数(頻度)が出る。
 *   グラフとして要求されているのは溢れ呼、poisson呼の＊相対度数(相対頻度)＊なので、
 *   それぞれ総数(溢れ呼の場合は変数anc、poisson呼の場合は変数pnc)で割る必要がある。
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define RANK_NUM	20
#define HSTMAX		100
#define THIST		50
#define XMAX		2.0
#define	XMIN		0.0
#define LAMBDA		48828125
#define MASK		2147483647 /* 2^30+(2^30-1) */
#define NUM			4.656612873077392578125E-10 /* 0.5^31 */

int traf(void);
double xb(long, long);
double rnd(long, long*, double*);
void ranked(long*, double);

FILE *fp_o;
FILE *fp_p;

int main(void)
{
	/* 出力ファイルオープン */
 	if((fp_o=fopen("overflow.dat","w"))==NULL){
		puts("ファイルオープンエラー");
		return(0);
	}
 	if((fp_p=fopen("poisson.dat","w"))==NULL){
		puts("ファイルオープンエラー");
		return(0);
	}

	while(traf()){};

	if((fclose(fp_o))==EOF){
		puts("ファイルクローズエラー");
		return(0);
	}
	if((fclose(fp_p))==EOF){
		puts("ファイルクローズエラー");
		return(0);
	}

	return(1);
}

int traf(void)
{
	/* 変数初期化 */
	long int a, n, jend, ix, pnc=0, anc=0, icall;
	long int i;
	long int prank[HSTMAX], arank[HSTMAX];
	char tmp;
	double iave, theta;
	double ptmr=0, optmr=0, psum=0, psum2=0, pave=0, pdev=0;
	double atmr=0, oatmr=0, asum=0, asum2=0, adev=0, aave=0;
	double u, x, t, d;
	double ur;

	for(i=0;i<HSTMAX;i++)
			arank[i] = prank[i] = 0;

	/* 初期値読み込み */
	do{
		//puts("呼量(a), 回線数(S), 溢れ呼総量(jend), 乱数初期値(ix) ?");
		puts("Traffic density(a), Lines(S), Total number of overflow call(jend), seed of random(ix) ?");
		scanf("%ld, %ld, %ld, %ld", &a, &n, &jend, &ix);
		printf("input parameters: %d, %d, %d, %d\n", a, n, jend, ix);

		/* 入力値チェック */
	} while(ix%2 != 1 || ix <= 0);

  srand(ix); /* initial value setup for random value  2016.09 */
	icall = n;

	while(1){

		/* 乱数発生 */
		//t = rnd(a, &ix, &u);
		ur = ((double)rand()+1.0)/((double)RAND_MAX+2.0); /* 2016.09 */
		t = ((-log(1.0 - ur) / a));			/* 2016.09 */

		x = 1.0*a/( a+icall);


		/* 呼の発生*/
		//if (u <= x){
		if (ur <= x){
			//t = rnd(a, &ix, &u);
			ur = ((double)rand()+1.0)/((double)RAND_MAX+2.0); /* 2016.09 */
			t = ((-log(1.0 - ur) / a));			/* 2016.09 */

			/* 時計を更新 */
			atmr = atmr +t;
			ptmr = ptmr +t;

			pnc = pnc +1;
			d = ptmr - optmr;
			psum  = psum  +d;
			psum2 = psum2 +d*d;

			optmr = ptmr;

			ranked(prank, d);

			if(icall == n){

				/* 接続数[icall]と回線数[n]が等しければ溢れ呼が発生した */
				anc = anc +1;
				d  = atmr -oatmr;

				asum  = asum  +d;
				asum2 = asum2 +d*d;

				oatmr = atmr;

				//if(anc%5000 == 0)
				//		printf("overflow calls (anc):\t%ld\n", anc);

				ranked(arank, d);
			}
			else{
				if(icall <= n)

				/* まだ回線数に余裕があった */
				icall = icall +1;

				else{
					/* 接続数が回線数を上回ることは有り得ない */
					puts("abend(!!! icall>n !!!)");
					return(0);
				}
			}

			if(anc >= jend){

				/* ポアソン呼の平均, 分散, 変動係数の計算 */
				pave = 1.0*psum/pnc;
				pdev = 1.0*psum2/pnc -pave*pave;
				theta = sqrt(pdev) /pave;

				/* 溢れ呼の平均, 分散, 変動係数の計算 */
				aave = 1.0*asum/anc;
				adev = 1.0*asum2/anc -aave*aave;
				theta = sqrt(adev) /aave;

				/* 理論呼の平均の計算 */
				iave = 1.0/(a * xb(n, a));

				/* 結果の表示 */
				printf("\n");
				printf("total of overflow call [anc]:                       %16d\n",anc);
				printf("average of interval of overflow call [aave]:        %15.14lf\n",aave);
				printf("variation of interval of overflow call [adev]:      %15.14lf\n",adev);
				printf("coefficiency of interval of overflow call [theta]:  %15.14lf\n",theta);
				printf("total of poisson call [pnc]:                        %16d\n",pnc);
				printf("average of interval of poisson call [pave]:         %15.14lf\n",pave);
				printf("variation of interval of poisson call [pdev]:       %15.14lf\n",pdev);
				printf("coefficiency of interval of poisson call [ptheta]:  %15.14lf\n",sqrt(pdev) /pave);
				puts("\a");

				fprintf(fp_o,"# overflow call : total %d\n",anc);
				for(i=0;i<THIST;i++)
					fprintf(fp_o,"%lf %ld\n",(i+0.5)*(XMAX-XMIN)/THIST, arank[i]);
				fprintf(fp_o,"\n");
				fprintf(fp_p,"# poisson call : total %d\n",pnc);
				for(i=0;i<THIST;i++)
					fprintf(fp_p,"%lf %ld\n",(i+0.5)*(XMAX-XMIN)/THIST, prank[i]);
				fprintf(fp_p,"\n");

				puts("please select:\tend[0], continue[1]");

				while(1){
					tmp=getchar();
					if(tmp=='0') return(0);
					else if (tmp=='1') return(1);
				}
			}
		}else{
			/* 呼の終了 */
			if(icall != 0)
					icall = icall -1;
		}
	}
}
/* Erlang の損失式 */
double xb(long n, long a)
{
	double xb_tmp;

	if(n==0) return(1.0);
	else{
		xb_tmp = xb(n-1,a);
		return(a*xb_tmp/((double)n+a*xb_tmp));
	}
}

/* 乗算合同法による一様乱数 */
double rnd(long int a, long int* ix, double* u)
{
	*ix = LAMBDA*(*ix);

	if( *ix <= 0 )
			*ix = ( *ix+MASK )+1;

	*u  = (*ix)*NUM;

	return((-log(1.0 - *u) / a));
}

void ranked(long int* jank, double d)
{
	long int i;
	double ixt, ixb, delta = (XMAX-XMIN)/THIST;

	for(i=0;i<THIST;i++){
		ixb = (i)*delta;
		ixt = (i+1)*delta;
		if(d >= ixb && d <= ixt){
			jank[i]=jank[i]+1.0;
			break;
		}
	}

	if (d == XMAX)
			jank[THIST]++;
}
