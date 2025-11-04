#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

//#title(date:datetime(year:2025,month:10,day:22),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:11,day:5),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))

= はじめに
今回は平滑コンデンサを挿入した状態で減速度制御を行った。

= 実験方法
@fig:circuit に回生回路を示す。整流回路の後段に平滑コンデンサを並列に接続し、回生開始回転数$N_0$ = 1000 rpmとする。コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm, $C$は0.1 #unit.uF はセラミックコンデンサ, その他の容量は電解コンデンサである。またPWM周波数は500 Hzである。
#img("img/regeneration_circuit.svg", cap:"実験回路図", lab:<fig:circuit>, w:90%)
#pb
= 実験結果
@fig:torque, 3に各容量における制動トルク特性を示す。各容量において停止直前までおおむね目標減速度に沿って減速できている。$C=100 #unit.uF$では昇圧開始後にトルクの変動が大きいが減速度の大きな変化は見られない
#imgN(("img/C_none/グラフ/Torque.svg","img/0.1/グラフ/Torque.svg","img/1.0/グラフ/Torque.svg","img/10/グラフ/Torque.svg","img/100_2/グラフ/Torque.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"制動トルク", w:7cm, lab:<fig:torque>)
#imgN(("img/C_none/グラフ/Deceleration.svg","img/0.1/グラフ/Deceleration.svg","img/1.0/グラフ/Deceleration.svg","img/10/グラフ/Deceleration.svg","img/100_2/グラフ/Deceleration.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"減速度", w:7cm,lab:<fig:deceleration>)

@fig:energy に各容量における回生エネルギー特性を示す。赤色破線がコンデンサ挿入前の値である。$C=1.0 #unit.uF$では挿入前に比べて充電電圧は約1 V増加した。しかし容量を増加させていくと充電電圧は低下し、最大電流値も大きく増加した。
#imgN(("img/energy/Vedlc.svg", "\img\energy\maxI.svg", "\img\energy\Energy.svg", "\img\energy\Efficiency.svg"), ("(a) EDLC充電電圧", [(b) 最大回生電流], [(c) 回生エネルギー], [(d) 回生効率]), cap:"各種容量特性", w:7cm, lab:<fig:energy>)

@fig:current_memory にメモリーハイコーダで測定した回生電流を、@fig:current_adc に制御用マイコンに入力されているADCでの測定値を示す。なおそれぞれの値は同一のプローブからの電圧を分配しているものであり、ADCは12bit, 4CHのMCP3204を使用している。制動トルクの計算にはADCの測定結果を用いている。しかしメモリーハイコーダとADCでの測定値では大きな差異が見られる。これは、PWM周波数が500 Hzであり、メモリーハイコーダのサンプリング周波数が10 kHzであるのに対し、ADCのサンプリング周波数（=制御周波数）は1 kHzであるためエイリアシングが発生しているのだと考えられる。またEDLCの充電波形において、$C=100 #unit.uF$などの昇圧区間で大きな電流波形が生じている箇所でも、内部抵抗による電圧降下での大きな電圧変動はないためメモリーハイコーダでの測定値通りの大きな電流が流れているかは不明である。
#imgN(("img/C_none/グラフ/CurrentMH.svg","img/0.1/グラフ/CurrentMH.svg","img/1.0/グラフ/CurrentMH.svg","img/10/グラフ/CurrentMH.svg","img/100_2/グラフ/CurrentMH.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"回生電流（メモリーハイコーダ）", w:7cm, lab:<fig:current_memory>)
#imgN(("img/C_none/グラフ/Current.svg","img/0.1/グラフ/Current.svg","img/1.0/グラフ/Current.svg","img/10/グラフ/Current.svg","img/100_2/グラフ/Current.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"回生電流（ADC測定値）", w:7cm, lab:<fig:current_adc>)
= 参考資料
#imgN(("img/C_none/グラフ/N.svg","img/0.1/グラフ/N.svg","img/1.0/グラフ/N.svg","img/10/グラフ/N.svg","img/100_2/グラフ/N.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"EDLC充電電圧", w:7cm)
#imgN(("img/C_none/グラフ/Vedlc.svg","img/0.1/グラフ/Vedlc.svg","img/1.0/グラフ/Vedlc.svg","img/10/グラフ/Vedlc.svg","img/100_2/グラフ/Vedlc.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"EDLC充電電圧", w:7cm)

#imgN(("img/C_none/グラフ/Duty.svg","img/0.1/グラフ/Duty.svg","img/1.0/グラフ/Duty.svg","img/10/グラフ/Duty.svg","img/100_2/グラフ/Duty.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"デューティ比", w:7cm)
#imgN(("img/C_none/グラフ/Kp.svg","img/0.1/グラフ/Kp.svg","img/1.0/グラフ/Kp.svg","img/10/グラフ/Kp.svg","img/100_2/グラフ/Kp.svg"),("(a) Without Capacitor", [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"比例ゲイン", w:7cm)