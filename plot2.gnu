# 印刷時は以下の2行の先頭の"#"を削除する
#set terminal postscript enhanced color solid "Times-Roman" 20
#set output 'tmp.ps'

anc = 200000  # total number of overflow call (★)
pnc = 6573968 # total number of poisson call (★)

# 図上：溢れ呼に関する相対頻度分布
# 図下：poisson呼に関する相対頻度分布

clear

#yomax = 0.01   # 溢れ呼に関する相対頻度分布の縦軸の最大値
#ypmax = 0.05   # poisson呼に関する相対頻度分布の縦軸の最大値

set nokey
set grid

#set title   "TITLE OF FIGURE" # 図のタイトル(学籍番号も入れておくとプリンタでの取り間違いなし)(★)

# X軸の設定
set xrange [0:2.0]
set xtics  0,0.20,2.00            # 0.20 刻みで 0.0-2.0 まで目盛りを入れる
set format x  "%2.1f"
set lmargin 10
set rmargin 2

# データファイル名が "overflow.dat", "poisson.dat" ではない場合は、変更する
# overflow.dat poisson.dat には
# 階級1から50までの、階級の代表値とその相対頻度が書かれているものとする。

set multiplot
# 図下：poisson呼に関する相対頻度分布
  #set yrange [0:ypmax]
  #set ytic 0, ypmax/5, ypmax
  set format y  "%4.3f"
  set ylabel "Y2-AXIS"           # y2軸の物理量及び単位(★)
  set size 1,0.5
  set xlabel  "X-AXIS"              # x軸の物理量及び単位(★)
  set origin 0.0, 0.0
  set bmargin 3
  set tmargin 0
    plot "poisson.dat" using 1:($2/pnc) with boxes lt 1 lw 2 fs solid 0.7 # データファイル名(★)
# 図上：溢れ呼に関する相対頻度分布
  #set yrange [0:yomax]
  #set ytic  0, yomax/5, yomax
  set format y  "%4.3f"
  set ylabel "Y1-AXIS"           # y1軸の物理量及び単位(★)
  set size 1,0.5
  set xlabel  ""
  set format x  ""
  set origin 0.0, 0.5
  set bmargin 1
  set tmargin 1
    plot "overflow.dat" using 1:($2/anc) with boxes lt 3 lw 2 fs solid 0.7 # データファイル名(★)
set nomultiplot

# 印刷時は以下の2行の先頭の"#"を削除する(!は残す)
#! psselect -p2 tmp.ps tmp2.ps
#! lpr tmp2.ps
