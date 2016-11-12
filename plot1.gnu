# 印刷時は以下の2行の先頭の"#"を削除する。日本語 font は使えない。
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

# データファイル名が "sample.data" ではない場合は、変更する
# sample.data には
# 「呼量 S=50の時の呼損率 S=100の時の呼損率 S=200の時の呼損率」
# (数字のデータが４列、数字と数字の間は半角の空白を１つ入れる)
# の順で書かれているものとする。
# 以下の plot コマンドは、上から
# 「a, S=50の時の呼損率」、
# 「a, S=100の時の呼損率」、
# 「a, S=200の時の呼損率」
# の3本のグラフを描く
plot "sample.data" using 1:2 with linespoints, \
     "sample.data" using 1:3 with linespoints, \
     "sample.data" using 1:4 with linespoints

# 印刷時は以下の2行の先頭の"#"を削除する(!は残す)
#! psselect -p2 tmp.ps tmp2.ps
#! lpr tmp2.ps
