# 印刷時は以下の2行の先頭の"#"を削除する
#set terminal postscript enhanced color solid "Times-Roman" 20
#set output 'tmp.ps'

clear
enqueue = 10023             # 標準出力の"enqueue"の数字に置き換える(★)
xmax = 30.0		# max value of x axis(★)
xd = xmax/10

set nokey
set grid
set xrange [0:xmax]           # X軸のプロット範囲指定
set xtics 0,xd,xmax
set format x "%3.2f"
#set yrange [0:15]            # Y軸のプロット範囲指定
#set ytics 0,1.5,15
#set format y "%3.1f"

# title、xlabel、ylabel に変更を加える
set title   "TITLE OF FIGURE" # 図のタイトル(学籍番号も入れておくとプリンタでの取り間違いなし)(★)
set xlabel  "X-AXIS"              # x軸の物理量及び単位(★)
set ylabel  "Y-AXIS"              # y軸の物理量及び単位(★)

# データファイル名は "freq" とする(★)
# 各データファイルには 「階級の代表値 その階級の度数」 の順で書かれているものとする。

# (1) 頻度分布を描く場合は、次の行の頭の "#" を外す ======================
#plot 'freq' with boxes lw 2

# (2) 相対頻度分布を描く場合は、次の行の頭の "#" を外す ==================
#plot 'freq' using 1:($2/enqueue) with boxes lw 2

# (3) 相対頻度分布の近似曲線も求める場合は、次の3行の頭の "#" を外す =====
#f(x) = a*exp(-b*x)
#fit f(x) 'freq' using 1:($2/enqueue) via a, b
#plot 'freq' using 1:($2/enqueue) with boxes lw 2, a*exp(-b*x) with linespoints lt 3

# 印刷時は以下の2行の先頭の"#"を削除する(!は残す)
# ただし、出力ファイル tmp2.png を windows 上で印刷する。
#! psselect -p2 tmp.ps tmp2.ps
#! lpr tmp2.ps
