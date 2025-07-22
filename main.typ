#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

//#title(date:datetime(year:2025,month:4,day:1),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:7,day:16),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))

= はじめに <beg>
先週の解析において、EDLCを抵抗に置き換え消費電力量の解析を行った。しかし、解析に間違いがあったため再度同じ条件で解析を行う。

= 解析方法
@fig:circuit に解析回路を示す。回生開始回転数$N_0$=1000, 2000, 3000 rpmとし、EDLCを抵抗$R$に置き換え、$R$及び保護抵抗$R_P$での消費電力量及び初期エネルギーに対する比率を解析する。$C$を挿入しない場合及び$C$を0.1 #unit.uF から1000 #unit.uF まで変化させて解析を行う。$R$=100 #unit.Ohm, $R_P$=10 #unit.Ohm, $C_"ESR"$=10 #unit.Ohm, ダイオードの順方向電圧$V_F$=1.3 Vとし、解析時間は6秒間, タイムステップは10 $"μs"$とする。
#img("graph/circuit.svg", cap:[解析回路], w:auto, lab:<fig:circuit>)

= 解析結果
#let h=95%
@analysis:result に解析結果を, @analysis:result_vs1000 に$N_0$=1000 rpmに対する比率を示す。
#imgN(("graph/W.svg", "graph/rate.svg"),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[解析結果], lab:<analysis:result>, place:bottom)
#imgN(("graph/W_vs1000.svg", "graph/rate_vs1000.svg"),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[$N_0$=1000 rpmに対する比率], lab:<analysis:result_vs1000>, place:bottom)

@analysis:vs_edlc にEDLCに電力回生した場合との比較を示す。抵抗での消費電力量及び初期エネルギーに対する比率はいずれも、EDLCに電力回生した時よりも
#imgN(("graph/compEDLC/W.svg", "graph/compEDLC/rate.svg",),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[電力回生時との比較], lab:<analysis:comp_edlc>, place:bottom)

#imgN(("graph/compEDLC/W_vsEDLC.svg", "graph/compEDLC/rate_vsEDLC.svg",),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[電力回生時との比較], lab:<analysis:vs_edlc>, place:bottom)