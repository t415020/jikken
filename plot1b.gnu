# 印刷時は以下の2行の先頭の"#"を削除する
#set terminal postscript enhanced color solid "Times-Roman" 20
#set output 'tmp.ps'

clear
set nokey
set grid
set xrange [0:200]            # X軸のプロット範囲指定
set yrange [0.0001:1]         # Y軸のプロット範囲指定
set logscale y                # Y軸は対数軸に設定
set format y "10^{%L}"

# title、xlabel、ylabel に変更を加える
set title   "TITLE OF FIGURE" # 図のタイトル(学籍番号も入れておくとプリンタでの取り間違いなし)(★)
set xlabel  "X-AXIS"              # x軸の物理量及び単位(★)
set ylabel  "Y-AXIS"              # y軸の物理量及び単位(★)

# データファイルを以下の名称及び形式で準備する
# 回線数S=50 のデータファイル "s50.data" 「呼量 S=50の時の呼損率」
# 回線数S=100 のデータファイル "s100.data" 「呼量 S=100の時の呼損率」
# 回線数S=200 のデータファイル "s200.data" 「呼量 S=200の時の呼損率」
# (数字のデータが２列、数字と数字の間は半角の空白を１つ入れる)
# 以下の plot コマンドは、上から
# 「a, S=50の時の呼損率」、
# 「a, S=100の時の呼損率」、
# 「a, S=200の時の呼損率」
# の3本のグラフを描く
plot "s50.data" with linespoints, \
     "s100.data" with linespoints, \
     "s200.data" with linespoints

# 印刷時は以下の2行の先頭の"#"を削除する(!は残す)
# ただし、出力ファイル tmp2.png を windows 上で印刷する。
#! psselect -p2 tmp.ps tmp2.ps
#! convert tmp2.ps tmp2.png
