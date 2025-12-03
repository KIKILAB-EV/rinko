#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

//#title(date:datetime(year:2025,month:10,day:22),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:12,day:3),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))

= はじめに
今回は回生電流の測定位置を変更し、再び制御を行った。

= 実験方法
@fig:circuit に回生回路を示す。整流回路の後段に平滑コンデンサを並列に接続し、回生開始回転数$N_0$ = 1000 rpmとする。平滑コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm, $C$は0.1 #unit.uF はセラミックコンデンサ, その他の容量は電解コンデンサである。またPWM周波数は500 Hzである。電流の測定位置を平滑コンデンサの前に移動した。測定方法は前回同様クランプ式の電流プローブを用いている。
#img("img/regeneration_circuit.pdf", cap:"実験回路図", lab:<fig:circuit>, w:90%)

= 実験結果
@fig:deceleration - 4に各コンデンサ容量における減速特性、トルク特性、電流特性を示す。コンデンサ容量が大きくなるにつれて、電流制限区間における電流値の変動が軽減されている。そのためトルクの変動も抑制されている。$C=100 #unit.uF$における昇圧区間の電流値の変動はPIパラメータの調整により軽減できると考えている。

@fig:energy に各コンデンサ容量における充電電圧と最大回生電流を示す。コンデンサ容量が大きくなるにつれて最大回生電流も減少している。また充電電圧の推移に関しては、以前までの結果と同様であった。
#let file = "Deceleration"
#imgN(("img/C_none/"+file+".pdf","img/0.1/"+file+".pdf","img/1/"+file+".pdf","img/10/"+file+".pdf","img/100/"+file+".pdf"), ([(a) コンデンサなし],[(b) $C=0.1 #unit.uF$],[(c) $C=1.0 #unit.uF$],[(d) $C=10 #unit.uF$],[(e) $C=100 #unit.uF$]), cap:"各平滑コンデンサ容量における減速特性", lab:<fig:deceleration>, w:7cm)
#let file = "Torque"
#imgN(("img/C_none/"+file+".pdf","img/0.1/"+file+".pdf","img/1/"+file+".pdf","img/10/"+file+".pdf","img/100/"+file+".pdf"), ([(a) コンデンサなし],[(b) $C=0.1 #unit.uF$],[(c) $C=1.0 #unit.uF$],[(d) $C=10 #unit.uF$],[(e) $C=100 #unit.uF$]), cap:"各平滑コンデンサ容量におけるトルク特性", lab:<fig:toruq>, w:7cm)
#let file = "Current"
#imgN(("img/C_none/"+file+".pdf","img/0.1/"+file+".pdf","img/1/"+file+".pdf","img/10/"+file+".pdf","img/100/"+file+".pdf"), ([(a) コンデンサなし],[(b) $C=0.1 #unit.uF$],[(c) $C=1.0 #unit.uF$],[(d) $C=10 #unit.uF$],[(e) $C=100 #unit.uF$]), cap:"各平滑コンデンサ容量における電流特性", lab:<fig:current>, w:7cm)

#imgN(("img/plots_energy/ChargingVoltage_1000rpm.png", "img/plots_energy/MaxRegenerativeCurrent_1000rpm.png"), ([(a) 充電電圧], [(b) 最大回生電流]), cap:"各平滑コンデンサ容量における充電電圧と最大回生電流", lab:<fig:energy>, w:7cm)