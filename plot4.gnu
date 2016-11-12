# 印刷時は以下の2行の先頭の"#"を削除する
#set terminal postscript enhanced color solid "Times-Roman" 20
#set output 'tmp.ps'

clear
set nokey
set grid
set xrange [0:1.5]           # X軸のプロット範囲指定
set yrange [0:15]            # Y軸のプロット範囲指定
set xtics 0,0.1,1.5
set ytics 0,1.5,15
set format x "%2.1f"
set format y "%3.1f"

# title、xlabel、ylabel に変更を加える
set title   "TITLE OF FIGURE" # 図のタイトル(学籍番号も入れておくとプリンタでの取り間違いなし)(★)
set xlabel  "X-AXIS"              # x軸の物理量及び単位(★)
set ylabel  "Y-AXIS"              # y軸の物理量及び単位(★)

# データファイル名は "S_and_F_5"、"S_and_F_6"、"S_and_F_7"、"S_and_F_8"とする
# 各データファイルには
# 「システム内最大データ数(K), 呼量(a), データ廃棄率(B), システム内平均遅延時間(D)」
# の順で書かれているものとする。
# ここでは呼量(a)とシステム内平均遅延時間(D)のグラフを描く
plot "S_and_F_5" using 2:4 with linespoints, \
     "S_and_F_6" using 2:4 with linespoints, \
     "S_and_F_7" using 2:4 with linespoints, \
     "S_and_F_8" using 2:4 with linespoints

# 印刷時は以下の2行の先頭の"#"を削除する(!は残す)
#! psselect -p2 tmp.ps tmp2.ps
#! lpr tmp2.ps
