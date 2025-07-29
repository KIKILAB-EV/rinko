#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

//#title(date:datetime(year:2025,month:4,day:1),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:7,day:30),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
前回までに、PSIMで整流回路と並列にコンデンサを挿入した場合の特性について解析した。今回は実際にコンデンサを挿入して実験を行い、各種特性を測定する。

= 実験方法
@fig:circuit に回生回路を示す。整流回路の後段にコンデンサを並列に接続し、回生開始回転数$N_0$ = 1000 rpm及び2000 rpmとする。回転数$N$を初期回転数$N_"init"$=$N_0 + 300$ rpmから$N=N_"0"$になったらスイッチSを閉じる。コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm とする。
#img("graph/circuit.svg", cap:"実験回路図", lab:<fig:circuit>, w:90%)
#pb
= 実験結果
@fig:energy に$C$を変化させた場合のEDLCの充電電圧$V_"EDLC"$, 最大回生電流$I_"max"$, 回生エネルギー$E_"reg"$, 回生効率$η_"reg"$を示す。EDLCの充電電圧は、コンデンサ容量が大きいほど高くなる。最大回生電流は、コンデンサ容量が大きいほど小さくなる。回生エネルギーは、コンデンサ容量が大きいほど大きくなる。回生効率は、コンデンサ容量が大きいほど高くなる。
#imgN(("graph/energy/Vedlc.svg", "graph/energy/MaxCurrent.svg", "graph/energy/RegenerationEnergy.svg", "graph/energy/RegenerativeRate.svg"), ([(a) EDLC充電電圧],[(b) 最大回生電流],[(c) 回生エネルギー],[(d) 回生効率]), cap:[各種特性], lab:<fig:energy>, w:105%,place:none)
#imgN(("graph/energy/percentage/Vedlc.svg", "graph/energy/percentage/MaxCurrent.svg", "graph/energy/percentage/RegenerationEnergy.svg", "graph/energy/percentage/RegenerativeRate.svg"), ([(a) EDLC充電電圧],[(b) 最大回生電流],[(c) 回生エネルギー],[(d) 回生効率]), cap:[$C$非挿入時に対する比率], lab:<fig:percentage>, w:105%,place:none)

#imgN(("graph/1000_VEDLC.svg", "graph/1000_I.svg", "graph/1000_N.svg", "graph/1000_Vc.svg", "graph/1000_Ic.svg", "graph/1000_Ic_ext.svg"), ([(a) EDLC充電電圧],[(b) 回生電流],[(c) 回転数],[(d) コンデンサ電圧],[(e) コンデンサ電流],[(f) コンデンサ電流(拡大)]), cap:[$N_0$ = 1000 rpm 各種波形], lab:<fig:1000_wave>, w:100%,place:none)

#imgN(("graph/2000_VEDLC.svg", "graph/2000_I.svg", "graph/2000_N.svg", "graph/2000_Vc.svg", "graph/2000_Ic.svg", "graph/2000_Ic_ext.svg"), ([(a) EDLC充電電圧],[(b) 回生電流],[(c) 回転数],[(d) コンデンサ電圧],[(e) コンデンサ電流],[(f) コンデンサ電流(拡大)]), cap:[$N_0$ = 2000 rpm 各種波形], lab:<fig:2000_wave>, w:100%,place:none)