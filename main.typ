#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

//#title(date:datetime(year:2025,month:4,day:1),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:7,day:30),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
前回までに、PSIMで整流回路と並列にコンデンサを挿入した場合の特性について解析した。今回は実際にコンデンサを挿入して実験を行い、各種特性を測定する。

= 実験方法
@fig:circuit に回生回路を示す。整流回路の後段にコンデンサを並列に接続し、回生開始回転数$N_0$ = 1000 rpm及び2000 rpmとする。回転数$N$を初期回転数$N_"init"$=$N_0 + 300$ rpmから$N=N_"0"$になったらスイッチSを閉じる。コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm, $C$は0.1 #unit.uF はセラミックコンデンサ, その他の容量は電解コンデンサである。
#img("graph/circuit.svg", cap:"実験回路図", lab:<fig:circuit>, w:90%)
#pb
= 実験結果
@fig:energy に$C$を変化させた場合のEDLCの充電電圧, 最大回生電流, 回生エネルギー, 回生効率を示す。また、@fig:percentage に$C$非挿入時に対する比率を示す。$C$非挿入時は停止時において$N_0$=1000 rpmでは充電電圧は19.2 V, 回生効率は8.86 %であり、$N_0$=2000 rpmでは充電電圧は44.5 V, 回生効率は11.9 %であった。$C$を挿入した場合は$C$非挿入時に比べて$N_0$=1000 rpmでは充電電圧は$C$=0.1 #unit.uF で99.2 %, 100 #unit.uF で100.9 %、$N_0$=2000 rpmでは充電電圧は$C$=0.1 #unit.uF で99.2 %, $C$=100 #unit.uF で99.9 %で$C$が大きくなると回生効率は上がる傾向にあった。また回生電流の最大値は$C$に比例して増加し、$C$=100 #unit.uF では150 %程度まで増加した。
#imgN(("graph/energy/Vedlc.svg", "graph/energy/MaxCurrent.svg", "graph/energy/RegenerationEnergy.svg", "graph/energy/RegenerativeRate.svg"), ([(a) EDLC充電電圧],[(b) 最大回生電流],[(c) 回生エネルギー],[(d) 回生効率]), cap:[各種特性], lab:<fig:energy>, w:105%,place:none)
#imgN(("graph/energy/percentage/Vedlc.svg", "graph/energy/percentage/MaxCurrent.svg", "graph/energy/percentage/RegenerationEnergy.svg", "graph/energy/percentage/RegenerativeRate.svg"), ([(a) EDLC充電電圧],[(b) 最大回生電流],[(c) 回生エネルギー],[(d) 回生効率]), cap:[$C$非挿入時に対する比率], lab:<fig:percentage>, w:105%,place:none)

@fig:1000_wave, 5に各回転数における波形を示す。$C$が大きいとコンデンサから出力させる電流が大きくなる。また回生電流の変動が小さくなる。$C$が小さいとコンデンサ電圧は回生電流がゼロになった後に減少し、$C$が大きいとEDLC充電電圧と同じ電圧を維持する。また$N_0$=1000 rpm, $C$非挿入時以外の場合でコンデンサ電圧は実験前に0にならず7.3 V付近であった。$C$ = 10, 100 #unit.uF の場合にコンデンサ電流にオフセットがかかっている。コンデンサ電圧及び電流にオフセットがかかる理由は不明だが、電流に関しては実験開始前にメモリーハイコーダでゼロ点補正を行うことで解消すると考えられる。

= 今後の予定
- 各パラメータにおいて1回ずつの実験しかしていないため、複数回実験を行い特性を確認する
- 解析結果と比較をする
- 減速度制御をした場合の特性を確認する
#imgN(("graph/1000_VEDLC.svg", "graph/1000_I.svg", "graph/1000_N.svg", "graph/1000_Vc.svg", "graph/1000_Ic.svg", "graph/1000_Ic_ext.svg"), ([(a) EDLC充電電圧],[(b) 回生電流],[(c) 回転数],[(d) コンデンサ電圧],[(e) コンデンサ電流],[(f) コンデンサ電流(拡大)]), cap:[$N_0$ = 1000 rpm 各種波形], lab:<fig:1000_wave>, w:100%,place:none)

#imgN(("graph/2000_VEDLC.svg", "graph/2000_I.svg", "graph/2000_N.svg", "graph/2000_Vc.svg", "graph/2000_Ic.svg", "graph/2000_Ic_ext.svg"), ([(a) EDLC充電電圧],[(b) 回生電流],[(c) 回転数],[(d) コンデンサ電圧],[(e) コンデンサ電流],[(f) コンデンサ電流(拡大)]), cap:[$N_0$ = 2000 rpm 各種波形], lab:<fig:2000_wave>, w:100%,place:none)