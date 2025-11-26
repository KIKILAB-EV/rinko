#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

//#title(date:datetime(year:2025,month:10,day:22),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:11,day:26),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))

= はじめに
前回は平滑コンデンサを挿入した状態で減速度制御を行った。その際容量が大きいと測定時に電流値が大きくなり制御が不安定になっていた。今回は電流プローブの出力電圧にキャパシタを挿入しフィルタをかけ制御を行った。

= 実験方法
@fig:circuit に回生回路を示す。整流回路の後段に平滑コンデンサを並列に接続し、回生開始回転数$N_0$ = 1000 rpmとする。平滑コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm, $C$は0.1 #unit.uF はセラミックコンデンサ, その他の容量は電解コンデンサである。またPWM周波数は500 Hzである。またフィルタコンデンサ$C_F$=47, 100 #unit.uF を電流プローブの出力に接続しノイズ除去を行った。
#img("img/regeneration_circuit.pdf", cap:"実験回路図", lab:<fig:circuit>, w:90%)
#pb
= 実験結果
@fig:Cf0 - 4に各$C_F$における減速度および回生電流を示す。フィルタを挿入するとこで電流値の急激な変化はある程度除去され、減速度の変動も小さくなった。$C_F=47 #unit.uF$に比べて$C_F=100 #unit.uF$では電流値の変動がより抑えられている。しかし減速度の変動はあまり変化が見られなかった。

#imgN(("img/C0/100/グラフ/Deceleration.svg","img/C0/100/グラフ/Current.svg"), ("(a) 減速度", [(b) 回生電流]), cap:[$C=100#unit.uF$, フィルタなし], w:7cm, lab:<fig:Cf0>)
#imgN(("img/C47/100/グラフ/Deceleration.svg","img/C47/100/グラフ/Current.svg"), ("(a) 減速度", [(b) 回生電流]), cap:[$C=100#unit.uF$, $C_F=47 #unit.uF$], w:7cm, lab:<fig:Cf47>)
#imgN(("img/C100/100/グラフ/Deceleration.svg","img/C100/100/グラフ/Current.svg"), ("(a) 減速度", [(b) 回生電流]), cap:[$C=100#unit.uF$, $C_F=100 #unit.uF$], w:7cm, lab:<fig:Cf100>)
@fig:vedlc に充電電圧の比較を、@fig:Cf0_ - 8 に平滑コンデンサなしの場合の減速度およびデューティ比を示す。。フィルタの有無による充電電圧の傾向の変化は見られない。$C=0.1, 100 #unit.uF$ではフィルタによる変化はなかった。一方$C=1.0 #unit.uF$ではフィルタにより充電電圧が低下、$C=10 #unit.uF$では充電電圧が上昇した。また平滑コンデンサなしの場合の充電電圧は$C_F$が大きくなるにつれて低下した。減速度波形に変化は見られないが、わずかに昇圧動作の開始が遅れている。フィルタを挿入したことにより応答性が低下したためと考えられる。
#img("img/energy/vedlc.png", cap:"充電電圧比較", lab:<fig:vedlc>,w:12cm)

#imgN(("img/C0/10/グラフ/Deceleration.svg","img/C0/10/グラフ/Duty.svg"), ("(a) 減速度", [(b) デューティ比]), cap:[$C$なし, フィルタなし], w:7cm, lab:<fig:Cf0_>)
#imgN(("img/C47/10/グラフ/Deceleration.svg","img/C47/10/グラフ/Duty.svg"), ("(a) 減速度", [(b) デューティ比]), cap:[$C$なし, $C_F=47 #unit.uF$], w:7cm, lab:<fig:Cf47_>)
#imgN(("img/C100/10/グラフ/Deceleration.svg","img/C100/10/グラフ/Duty.svg"), ("(a) 減速度", [(b) デューティ比]), cap:[$C$なし, $C_F=100 #unit.uF$], w:7cm, lab:<fig:Cf100_>)