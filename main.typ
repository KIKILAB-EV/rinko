#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

//#title(date:datetime(year:2025,month:4,day:1),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:7,day:16),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))

= はじめに <beg>
先週の解析において、2000 rpm及び3000 rpmで回生効率が極端に向上し、解析の信頼性に疑問が残った。今回は解析の妥当性について確認する。

= 解析方法
@fig:circuit に解析回路を示す。回生開始回転数$N_0$=1000, 2000, 3000 rpmとし、EDLCを抵抗$R$に置き換え、$R$及び保護抵抗$R_P$での消費電力量及び初期エネルギーに対する比率を解析する。$C$を0.1 #unit.uF から1000 #unit.uF まで変化させ、$R$=100 #unit.Ohm, $R_P$=10 #unit.Ohm, $C_"ESR"$=10 #unit.Ohm, ダイオードの順方向電圧$V_F$=1.3 Vとし、解析時間は6秒間, タイムステップは10 $"μs"$。とする。
#img("graph/circuit.svg", cap:[解析回路], w:auto, lab:<fig:circuit>)

= 解析結果
#let h=95%
@graph:1000 - @graph:3000 に回生開始回転数$N_0$=1000, 2000, 3000 rpmにおける消費電力量, 回転数, コンデンサ電圧, 回生電流を示す。回転停止後もコンデンサ電圧及び電流が0にならず、消費電力量が増加し続けている。また、回転数が半分程度になると減速度が低下し、回生電流も減少し回生失効のような現象が発生している。いずれもこの傾向は$C$が小さいほど顕著になる。
#imgN(("graph/wave/1000/W.svg","graph/wave/1000/N.svg","graph/wave/1000/vc.svg","graph/wave/1000/I.svg"),([(a) 消費電力量], [(b) 回転数], [(c) コンデンサ電圧], [(d) 回生電流]), cap:[$N_0$=1000 rpm], lab:<graph:1000>, w:h)
#imgN(("graph/wave/2000/W.svg","graph/wave/2000/N.svg","graph/wave/2000/vc.svg","graph/wave/2000/I.svg"),([(a) 消費電力量], [(b) 回転数], [(c) コンデンサ電圧], [(d) 回生電流]), cap:[$N_0$=2000 rpm], lab:<graph:2000>, w:h)
#imgN(("graph/wave/3000/W.svg","graph/wave/3000/N.svg","graph/wave/3000/vc.svg","graph/wave/3000/I.svg"),([(a) 消費電力量], [(b) 回転数], [(c) コンデンサ電圧], [(d) 回生電流]), cap:[$N_0$=3000 rpm], lab:<graph:3000>, w:h)

@graph:W に抵抗での消費電力量を示す。停止時を$N$ < 0.1 rpmとなる瞬間とする。$C >=$ 0.1 #unit.uF の場合、停止時と解析終了時の6秒後の消費電力量はおおむね同じである。しかし、$C < 0.1 #unit.uF$ の場合、停止時の消費電力量は6秒後の消費電力量よりも小さくなる。これは電圧及び電流が停止後も0にならないためである。

@graph:0709 に前回輪講での、回生開始回転数$N_0$=1000 rpmに対する回生エネルギー及び回生効率の比率を示す。@graph:W - @graph:rate_vs1000 と比較すると、前回の結果と
#imgN(("graph/W_stop.svg", "graph/W_6sec.svg"), ([(a) 停止時], [(b) 6秒後]), cap:[抵抗の消費電力量], lab:<graph:W>)
#imgN(("graph/W_stop_vs1000.svg", "graph/W_6sec_vs1000.svg"), ([(a) 停止時], [(b) 6秒後]), cap:[抵抗の消費電力量の$N_0$=1000 rpmに対する倍率], lab:<graph:W_vs1000>)
#imgN(("graph/rate_stop.svg", "graph/rate_6sec.svg"), ([(a) 停止時], [(b) 6秒後]), cap:[初期エネルギーに対する抵抗の消費電力量の比率], lab:<graph:rate>)
#imgN(("graph/rate_stop_vs1000.svg", "graph/rate_6sec_vs1000.svg"), ([(a) 停止時], [(b) 6秒後]), cap:[初期エネルギーに対する抵抗の消費電力量の比率の#lb $N_0$=1000 rpmに対する倍率], lab:<graph:rate_vs1000>)

#imgN(("graph/0709/regenerative energy_ratio.svg", "graph/0709/regenerative rate_ratio.svg"), ([(a) 回生エネルギー], [(b) 回生効率]), cap:[$N_0$=1000 romに対する回生エネルギー及び回生効率の比率], lab:<graph:0709>)
= 最後に
今回の解析において、停止後も数秒間にわたって電圧及び電流が0にはならず途中で減速度が低下していることが確認され、$C$が大きいほど顕著であった。実際に停止後も抵抗への電力供給が行われることや途中で減速度が低下することが起こるとは考えにくく、解析への疑問は残ったままである。今後はコンデンサを挿入した実験を行い、実機での挙動を確認する。