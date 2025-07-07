#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:7,day:9),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
回生回路に、整流回路に並列にコンデンサを挿入した場合の、初期回転数を2000, 3000 rpmとした場合の無制御時の各種特性を解析する。

= 解析方法
@fig:circuit に回生回路を示す。PSIM上で整流回路の後段にコンデンサを並列に接続し、回生開始回転数$N_0$ = 2000 rpm及び3000 rpmとする。回転数$N$をから初期回転数$N_"init"$=$N + 100$ rpmから$N=N_"init"$になったらスイッチSを閉じる。コンデンサ容量$C$を0.1 #unit.uF から1000 #unit.uF まで変化させ各特性を解析した。コンデンサの等価直列抵抗は$C_"ESR"$ = 0.1 #unit.Ohm, 保護抵抗$R_"p"$ = 10 #unit.Ohm, EDLCは容量$C_"EDLC"$ = 0.0556 F, 抵抗$R_"EDLC"$ = 4.55 #unit.Ohm とする。
#img("\graph\circuit.svg", cap:"回生回路図", lab:<fig:circuit>,w:90%)
//#pb
= 解析結果
@fig:capacitor_characteristics_2000rpm, 3に各静電容量ごとの充電電圧, 回生電流の最大電流値, 回生開始から#lb $N$ < 0.1となる停止までの減速時間を示す。
#grid(columns:2,
[#imgN(("graph/2000rpm/voltage.svg", "graph/2000rpm/max_current.svg", "graph/2000rpm/time.svg"), ("(a) 充電電圧", "(b) 最大電流値", "(c) 減速時間"), cap:[$N_0=2000$ rpm], w:7cm, place:bottom, lab:<fig:capacitor_characteristics_2000rpm>, col:1)],
[#imgN(("graph/3000rpm/voltage.svg", "graph/3000rpm/max_current.svg", "graph/3000rpm/time.svg"), ("(a) 充電電圧", "(b) 最大電流値", "(c) 減速時間"), cap:[$N_0=3000$ rpm], w:7cm, place:bottom, lab:<fig:capacitor_characteristics_3000rpm>, col:1)]
)

@fig:energy_2000rpm, 5に各静電容量ごとの回生開始時のコンデンサの静電エネルギー, 停止時のEDLCの静電エネルギー, 回生開始時の運動エネルギーとコンデンサの静電エネルギーの合計に対する回生効率を示す。ただし、回生効率はコンデンサの回生開始直前の静電エネルギーと回転の運動エネルギーに対する回生エネルギーの割合である。
#figure(grid(columns:2,
[#imgN(("graph/2000rpm/energy_vs_capacity.svg", "graph/2000rpm/reg_vs_capacity.svg", "graph/2000rpm/rate_vs_capacity.svg"), ("(a) コンデンサの初期エネルギー", "(b) 回生エネルギー", "(c) 回生効率"), cap:[$N_0=2000$ rpm], w:6.8cm, place:bottom, lab:<fig:energy_2000rpm>, col:1)],
[#imgN(("graph/3000rpm/energy_vs_capacity.svg", "graph/3000rpm/reg_vs_capacity.svg", "graph/3000rpm/rate_vs_capacity.svg"), ("(a) コンデンサの初期エネルギー", "(b) 回生エネルギー", "(c) 回生効率"), cap:[$N_0=3000$ rpm], w:6.8cm, place:bottom, lab:<fig:energy_3000rpm>, col:1)],),
placement:bottom
)
@fig:time_characteristics_2000rpm, 7にコンデンサを挿入していない場合と$C$ = 1, 4.7, 22, 100, 1000 #unit.uF の各特性を示す。$C$の増加によってコンデンサ電流が増加し、コンデンサからEDLCへの充電がより行われていることがわかる。

#imgN(("\graph\2000rpm\overlay\all_ChargingVoltage_C.svg", "\graph\2000rpm\overlay\all_RegenerativeCurrent.svg", "\graph\2000rpm\overlay\all_RotationalSpeed.svg", "\graph\2000rpm\overlay\all_V_C.svg","\graph\2000rpm\overlay\all_I_C.svg", "graph/2000rpm/overlay/all_I_C_ext.svg"), ("(a) 充電電圧", "(b) 回生電流", "(c) 回転数", "(d) コンデンサ電圧", "(e) コンデンサ電流", "(f) コンデンサ電流(拡大)"), w:8cm, cap:[$N_0=2000$ rpm], place:bottom,lab:<fig:time_characteristics_2000rpm>)

#imgN(("\graph\3000rpm\overlay\all_ChargingVoltage_C.svg", "\graph\3000rpm\overlay\all_RegenerativeCurrent.svg", "\graph\3000rpm\overlay\all_RotationalSpeed.svg", "\graph\3000rpm\overlay\all_V_C.svg","\graph\3000rpm\overlay\all_I_C.svg", "graph/3000rpm/overlay/all_I_C_ext.svg"), ("(a) 充電電圧", "(b) 回生電流", "(c) 回転数", "(d) コンデンサ電圧", "(e) コンデンサ電流", "(f) コンデンサ電流(拡大)"), w:8cm, cap:[$N_0=3000$ rpm], place:bottom,lab:<fig:time_characteristics_3000rpm>)
