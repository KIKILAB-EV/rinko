#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:7,day:23),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:7,day:16),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))

= はじめに <beg>
先週の解析において、EDLCを抵抗に置き換え消費電力量の解析を行った。しかし、解析に間違いがあったため再度同じ条件で解析を行う。

= 解析方法
@fig:circuit に解析回路を示す。回生開始回転数$N_0$=1000, 2000, 3000 rpmとし、EDLCを抵抗$R$に置き換え、$R$及び保護抵抗$R_P$での消費電力量及び初期エネルギーに対する比率を解析する。$C$を挿入しない場合及び$C$を0.1 #unit.uF から1000 #unit.uF まで変化させて解析を行う。$R$=100 #unit.Ohm, $R_P$=10 #unit.Ohm, $C_"ESR"$=10 #unit.Ohm, ダイオードの順方向電圧$V_F$=1.3 Vとし、解析時間は6秒間, タイムステップは10 $"μs"$とする。
#img("graph/circuit.svg", cap:[解析回路], w:auto, lab:<fig:circuit>)
#pb
= 解析結果
#let h=95%
@analysis:result に解析結果を, @analysis:result_vs1000 に$N_0$=1000 rpmに対する比率を示す。$C$挿入時と非挿入時の消費電力量はほぼ同じであり、消費電力量は$N_0$=1000 rpmの時に対して$N_0$=2000 rpmでは約6倍, $N_0$=3000 rpmでは約15.5倍に増加した。

初期エネルギーに対する消費電力量の比率は$N_0$=1000 rpmのときに対して$N_0$=2000 rpmでは1.47倍, $N_0$=3000 rpmでは1.7倍程度となった。初期エネルギーは回転数の2乗に比例するため、$N_0$=1000 rpmのときにくらべて$N_0$=2000 rpmでは約4倍, $N_0$=3000 rpmでは約9倍となる。また$C$が10 #unit.uF を超えたあたりで初期エネルギーに対する比率はやや低下した。
#imgN(("graph/W.svg", "graph/rate.svg"),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[解析結果], lab:<analysis:result>, place:bottom)
#imgN(("graph/W_vs1000.svg", "graph/rate_vs1000.svg"),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[$N_0$=1000 rpmに対する比率], lab:<analysis:result_vs1000>, place:bottom)
#pb
@analysis:vs_edlc にEDLCに電力回生した場合との比較を, @analysis:vs_edlc に電力回生した場合との比率を示す。抵抗での消費電力量及び初期エネルギーに対する比率はいずれも回転数によらず、EDLCに電力回生した時よりも2倍程度に増加した。EDLCに電力回生した場合は、EDLC内部抵抗による損失や回生失効による機械損の比率が増加するため、消費電力量に対して回生エネルギーは低下する。また回生時と抵抗での消費電力量の関係は回転数によらずおおむね一定であることから、電力回生時および抵抗に置き換えた場合の解析結果の一貫性はあるといえる。
#imgN(("graph/compEDLC/W.svg", "graph/compEDLC/rate.svg",),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[電力回生時との比較], lab:<analysis:comp_edlc>, place:bottom)

#imgN(("graph/compEDLC/W_vsEDLC.svg", "graph/compEDLC/rate_vsEDLC.svg",),("(a) 消費電力量", "(b) 初期エネルギーに対する比率"), cap:[電力回生時との比率], lab:<analysis:vs_edlc>, place:bottom)

#pb
= 補足資料
== 各回転数における波形
#imgN(("graph/wave/1000/N.svg", "graph/wave/1000/W.svg", "graph/wave/1000/Ic.svg", "graph/wave/1000/Ic_EXT.svg", "graph/wave/1000/I.svg", "graph/wave/1000/vc.svg"),("(a) 回転数", "(b) 消費電力量", "(c) コンデンサ電流", "(d) コンデンサ電流(拡大)", "(e) 回生電流", "(f) コンデンサ電圧"), cap:[$N_0$=1000 rpmにおける波形], lab:<analysis:wave_1000>, place:bottom)

#imgN(("graph/wave/2000/N.svg", "graph/wave/2000/W.svg", "graph/wave/2000/Ic.svg", "graph/wave/2000/Ic_EXT.svg", "graph/wave/2000/I.svg", "graph/wave/2000/vc.svg"),("(a) 回転数", "(b) 消費電力量", "(c) コンデンサ電流", "(d) コンデンサ電流(拡大)", "(e) 回生電流", "(f) コンデンサ電圧"), cap:[$N_0$=2000 rpmにおける波形], lab:<analysis:wave_2000>, place:bottom)

#imgN(("graph/wave/3000/N.svg", "graph/wave/3000/W.svg", "graph/wave/3000/Ic.svg", "graph/wave/3000/Ic_EXT.svg", "graph/wave/3000/I.svg", "graph/wave/3000/vc.svg"),("(a) 回転数", "(b) 消費電力量", "(c) コンデンサ電流", "(d) コンデンサ電流(拡大)", "(e) 回生電流", "(f) コンデンサ電圧"), cap:[$N_0$=3000 rpmにおける波形], lab:<analysis:wave_3000>, place:bottom)

#pb
== 1000 rpmにおける$C$非挿入時の実験結果
$R$=125 Ω, $N_0$=1000 rpm, $C$を挿入しない場合について実験を行った。消費電力量は21 J程度となり、100 Ωでの解析とおおむね同じ値となった。
#imgN(("graph/exp/N.svg", "graph/exp/V.svg", "graph/exp/I.svg", "graph/exp/W_V2R.svg", "graph/exp/W_IV.svg"),("(a) 回転数", "(b) 抵抗電圧", "(c) 電流", [(d) 消費電力量($W=V^2/R$)], [(e) 消費電力量($W=I V$)]), cap:[$N_0$=1000 rpmにおける実験結果], lab:<analysis:exp_1000>, place:bottom, w:7cm)