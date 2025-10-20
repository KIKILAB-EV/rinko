#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

//#title(date:datetime(year:2025,month:4,day:1),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:10,day:15),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
前回はグランドを1kΩを介してアースと接続した。今回はキャパシタを接続した際の充電特性を再度測定した。

= 実験方法
@fig:circuit に回生回路を示す。整流回路の後段にコンデンサを並列に接続し、回生開始回転数$N_0$ = 1000 rpmとする。回転数$N=N_"0"$になったらリレーSを閉じる。コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm, $C$ = 0.1 #unit.uF はセラミックコンデンサ, その他の容量は電解コンデンサである。
#img("img/circuit.svg", cap:"実験回路図", lab:<fig:circuit>, w:100%)
#pb
= 実験結果
@fig:energy に$C$を変化させた場合のEDLCの充電電圧, 最大回生電流, 回生エネルギー, 回生効率を示す。なおいずれの値も$N <= 1$ rpm となった瞬間の値である。図中赤線は以前測定したコンデンサ非挿入時の値であり充電電圧は19.2 Vであった。EDLCの充電電圧は最大0.12 V程度増加してる。また、@fig:wave に各静電容量における各種波形を示す。 以前見られたコンデンサ電圧のオフセットは見られない。また回生開始の回転数が1000 rpmから950 rpm程度まで低下している。そのためマイコンでの回転数の測定値および制御プログラムを再度確認する必要がある。
#imgN(("img/graph/vedlc.svg", "img/graph/current.svg", "img/graph/er.svg", "img/graph/eff.svg"), ([(a) EDLC充電電圧],[(b) 最大回生電流],[(c) 回生エネルギー],[(d) 回生効率]), cap:[各種特性], lab:<fig:energy>, w:105%,place:none)

= 今後の予定
次回以降はキャパシタを接続した状態で減速度制御を行う予定である。

#imgN(("img/graph/overlay/Charging Voltage.svg", "img/graph/overlay/Regenerative Current.svg", "img/graph/overlay/Rotational Speed.svg", "img/graph/overlay/Capacitor Voltage.svg"), ([(a) EDLC充電電圧],[(b) 回生電流],[(c) 回転数],[(d) コンデンサ電圧]), cap:[各種波形], lab:<fig:wave>, w:105%,place:none)