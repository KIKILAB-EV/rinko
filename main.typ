#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:7,day:9),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
回生回路に、整流回路に並列にコンデンサを挿入した場合の、初期回転数を2000, 3000 rpmとした場合の無制御時の各種特性を解析する。

= 解析方法
@fig:circuit に回生回路を示す。PSIM上で整流回路の後段にコンデンサを並列に接続し、回生開始回転数$N_0$ = 2000 rpm及び3000 rpmとする。回転数$N$を初期回転数$N_"init"$=$N + 100$ rpmから$N=N_"0"$になったらスイッチSを閉じる。コンデンサ容量$C$を0.1 #unit.uF から1000 #unit.uF まで変化させ各特性を解析した。コンデンサの等価直列抵抗は$C_"ESR"$ = 0.1 #unit.Ohm, 保護抵抗$R_"p"$ = 10 #unit.Ohm, EDLCは容量$C_"EDLC"$ = 0.0556 F, 抵抗$R_"EDLC"$ = 4.55 #unit.Ohm とする。
#img("\graph\circuit.svg", cap:"回生回路図", lab:<fig:circuit>,w:90%)
//#pb
= 解析結果
@fig:capacitor_characteristics_2000rpm, 3に各静電容量ごとの充電電圧, 回生電流の最大電流値, 回生開始から#lb $N$ < 0.1となる停止までの減速時間を示す。充電電圧は$N_0=2000$ rpmでは48.97 Vから49.63 V, $N_0$=3000 rpmでは77.94 Vから78.79 Vに増加した。最大電流は$N_0$=2000 rpmでは$C$=4.7 #unit.uF で8.81 A, $C$=100 #unit.uF で6.90 Aが最大であった。$N_0$=3000 rpmの場合は$C$=1000 #unit.uF 以降に電流値のピークが来る可能性もあるため、さらに範囲を広げて解析をする必要がある。また減速時間は$N_0$=2000 rpmでは3.807 sから3.842 sまで, $N_0$=3000 rpmでは5.088 sから5.125 sまで増加した。
#figure(grid(columns:2,
[#imgN(("graph/2000rpm/voltage.svg", "graph/2000rpm/max_current.svg", "graph/2000rpm/time.svg"), ("(a) 充電電圧", "(b) 最大電流値", "(c) 減速時間"), cap:[$N_0=2000$ rpm], w:7cm, place:bottom, lab:<fig:capacitor_characteristics_2000rpm>, col:1)],
[#imgN(("graph/3000rpm/voltage.svg", "graph/3000rpm/max_current.svg", "graph/3000rpm/time.svg"), ("(a) 充電電圧", "(b) 最大電流値", "(c) 減速時間"), cap:[$N_0=3000$ rpm], w:7cm, place:bottom, lab:<fig:capacitor_characteristics_3000rpm>, col:1)]
), placement: bottom)
@fig:energy_2000rpm, 5に各静電容量ごとの回生開始時のコンデンサの静電エネルギー, 停止時のEDLCの静電エネルギー, 回生開始時の運動エネルギーとコンデンサの静電エネルギーの合計に対する回生効率を示す。ただし、回生効率はコンデンサの回生開始直前の静電エネルギーと回転の運動エネルギーに対する回生エネルギーの割合である。$N_0$=2000 rpmのときは$C$=22 #unit.uF で回生効率がいったんピークとなり、以降はまた増加している。$N_0$=3000 rpmのときは$C$=10 #unit.uF でピークを迎え、以降減少している。 
#figure(grid(columns:2,
[#imgN(("graph/2000rpm/energy_vs_capacity.svg", "graph/2000rpm/reg_vs_capacity.svg", "graph/2000rpm/rate_vs_capacity.svg"), ("(a) コンデンサの初期エネルギー", "(b) 回生エネルギー", "(c) 回生効率"), cap:[$N_0=2000$ rpm], w:6.8cm, place:bottom, lab:<fig:energy_2000rpm>, col:1)],
[#imgN(("graph/3000rpm/energy_vs_capacity.svg", "graph/3000rpm/reg_vs_capacity.svg", "graph/3000rpm/rate_vs_capacity.svg"), ("(a) コンデンサの初期エネルギー", "(b) 回生エネルギー", "(c) 回生効率"), cap:[$N_0=3000$ rpm], w:6.8cm, place:bottom, lab:<fig:energy_3000rpm>, col:1)],),
// placement:bottom
)
@fig:vs1000 に$N_0$=1000 rpmのときに対する$N_0$=2000, 3000 rpm時の最大回生電流, EDLC充電電圧, 回生効率の比率を示す。回転体の初期エネルギーは回転数の2乗に比例するため、初期エネルギーはそれぞれ4倍および9倍である。回生電流は$C$=100 #unit.uF 前後で最小値をとり、EDLC充電電圧は$C$=0.22 #unit.uF で最大, $C$=100 #unit.uF で最小値をとる。回生効率は$C$=100 #unit.uF 以降は減少傾向にあり、1.356倍及び1.526倍から1.346倍1.510倍まで減少する。
#imgN(("graph/current_vs1000.svg", "graph/vc_vs1000.svg", "graph/energy_vs1000.svg", "graph/rate_vs1000.svg"), ([(a) 最大回生電流], [(b) EDLC充電電圧], [(c) 回生エネルギー], [(d) 回生効率]), cap:[$N_0=1000$ rpmに対する比率], w:8cm, place:bottom, lab:<fig:vs1000>)
#pb

= 補足資料
#imgN(("graph/1000rpm/voltage.svg", "graph/1000rpm/max_current.svg", "graph/1000rpm/time.svg", "graph/1000rpm/energy_vs_capacity.svg", "graph/1000rpm/reg_vs_capacity.svg", "graph/1000rpm/rate_vs_capacity.svg"), ("(a) 充電電圧", "(b) 最大電流値", "(c) 減速時間", "(d) コンデンサの初期エネルギー", "(e) 回生エネルギー", "(f) 回生効率"), cap:[$N_0=1000$ rpm時の各特性], w:7cm, place:bottom)

#imgN(("\graph\1000rpm\overlay\all_ChargingVoltage_C.svg", "\graph\1000rpm\overlay\all_RegenerativeCurrent.svg", "\graph\1000rpm\overlay\all_RotationalSpeed.svg", "\graph\1000rpm\overlay\all_V_C.svg","\graph\1000rpm\overlay\all_I_C.svg", "graph/1000rpm/overlay/all_I_C_ext.svg"), ("(a) 充電電圧", "(b) 回生電流", "(c) 回転数", "(d) コンデンサ電圧", "(e) コンデンサ電流", "(f) コンデンサ電流(拡大)"), w:8cm, cap:[$N_0=1000$ rpm時の各波形], place:bottom)

#imgN(("\graph\2000rpm\overlay\all_ChargingVoltage_C.svg", "\graph\2000rpm\overlay\all_RegenerativeCurrent.svg", "\graph\2000rpm\overlay\all_RotationalSpeed.svg", "\graph\2000rpm\overlay\all_V_C.svg","\graph\2000rpm\overlay\all_I_C.svg", "graph/2000rpm/overlay/all_I_C_ext.svg"), ("(a) 充電電圧", "(b) 回生電流", "(c) 回転数", "(d) コンデンサ電圧", "(e) コンデンサ電流", "(f) コンデンサ電流(拡大)"), w:8cm, cap:[$N_0=2000$ rpm時の各波形], place:bottom)

#imgN(("\graph\3000rpm\overlay\all_ChargingVoltage_C.svg", "\graph\3000rpm\overlay\all_RegenerativeCurrent.svg", "\graph\3000rpm\overlay\all_RotationalSpeed.svg", "\graph\3000rpm\overlay\all_V_C.svg","\graph\3000rpm\overlay\all_I_C.svg", "graph/3000rpm/overlay/all_I_C_ext.svg"), ("(a) 充電電圧", "(b) 回生電流", "(c) 回転数", "(d) コンデンサ電圧", "(e) コンデンサ電流", "(f) コンデンサ電流(拡大)"), w:8cm, cap:[$N_0=3000$ rpm時の各波形], place:bottom)
