#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:7,day:2),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
回生回路に、整流回路に並列にコンデンサを挿入した場合の、無制御時の各種特性を解析する。


= 解析方法
@fig:circuit に回生回路を示す。PSIM上で整流回路の後段にコンデンサを並列に接続し、初期回転数$N$ = 1100 rpm から自然減速させ、回生開始回転数$N$ = 1000 rpm になったらスイッチSを閉じる。コンデンサ容量$C$を0.1 #unit.uF から1000 #unit.uF まで変化させ各特性を解析した。コンデンサの等価直列抵抗は$C_"ESR"$ = 0.1 #unit.Ohm, 保護抵抗$R_"p"$ = 10 #unit.Ohm, EDLCは容量$C_"EDLC"$ = 0.0556 F, 抵抗$R_"EDLC"$ = 4.55 #unit.Ohm とする。
#img("\graph\circuit.svg", cap:"回生回路図", lab:<fig:circuit>)
#pb
= 解析結果
@fig:capacitor_characteristics に各静電容量ごとの充電電圧, 回生電流の最大電流値, 回生開始から$N$ < 0.1となる停止までの減速時間を示す。充電電圧は21.03 Vから21.46 Vまで$C$に比例して2%増加した。回生電流の最大値は $C$ = 47 #unit.uF で5.12 Aでピークとなり、$C$ = 100 #unit.uF で3.66 Aで最小となった。これはいずれも回生開始直後の突入電流である。また減速時間は $C$ = 100 #unit.uF 以降は2.27 sから2.30 sまで増加した。
#imgN(("graph/voltage.svg", "graph/max_current.svg", "graph/time.svg"), ("(a) 充電電圧", "(b) 最大電流値", "(c) 減速時間"), cap:"コンデンサ容量特性", w:8cm, place:bottom, lab:<fig:capacitor_characteristics>)
#pb
@fig:energy に各静電容量ごとの回生開始時のコンデンサの静電エネルギー, 停止時のEDLCの静電エネルギー, 回生開始時の運動エネルギーとコンデンサの静電エネルギーの合計に対する回生効率を示す。コンデンサ容量に比例して回生エネルギーは増加し、回生効率は容量にある程度比例し、挿入する前に比べて0.11 %増加した。
#imgN(("graph/energy_vs_capacity.svg", "graph/reg_vs_capacity.svg", "graph/rate_vs_capacity.svg"), ("(a) コンデンサの初期エネルギー", "(b) 停止時の回生エネルギー", "(c) 回生効率"), cap:"コンデンサ容量によるエネルギー変化", w:8cm, place:bottom, lab:<fig:energy>)

@fig:time_characteristics にコンデンサを挿入していない場合と$C$ = 1, 4.7, 22, 100, 1000 #unit.uF の各特性を示す。$C$の増加によってコンデンサ電流が増加し、コンデンサからEDLCへの充電がより行われていることがわかる。

$C$ = 100 #unit.uF まで変化は小さいが、100 #unit.uF 以降はコンデンサ容量が増えるに従い充電電圧は増加し、回生効率も増加した。また、減速時間も減少し減速度も低下した。
#imgN(("\graph\overlay\all_ChargingVoltage_C.svg", "\graph\overlay\all_RegenerativeCurrent.svg", "\graph\overlay\all_RotationalSpeed.svg", "\graph\overlay\all_V_C.svg","\graph\overlay\all_I_C.svg", "graph/overlay/all_I_C_ext.svg"), ("(a) 充電電圧", "(b) 回生電流", "(c) 回転数", "(d) コンデンサ電圧", "(e) コンデンサ電流", "(f) コンデンサ電流(拡大)"), w:8cm, cap:"各コンデンサ容量における特性", place:bottom,lab:<fig:time_characteristics>)
