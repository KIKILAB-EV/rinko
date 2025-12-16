#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

//#title(date:datetime(year:2025,month:10,day:22),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:12,day:17),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))

= はじめに
今回は回転数を2000 rpmとした場合における平滑コンデンサを挿入した場合の制御を行った。

= 実験方法
図@fig:circuit に回生回路を示す。整流回路の後段に平滑コンデンサを並列に接続し、回生開始回転数$N_0$ = 1000, 2000 rpmとする。平滑コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm, $C$は0.1 #unit.uF はセラミックコンデンサ, その他の容量は電解コンデンサである。またPWM周波数は500 Hzである。
#img("img/regeneration_circuit.pdf", cap:"実験回路図", lab:<fig:circuit>, w:90%)
#pb
= 実験結果
図@fig:cv にEDLC充電電圧の比較を示す。2000 rpmにおいても1000 rpmの時と同様の傾向であり、$C=1.0 unit.uF$の時に最大となり、以降は減少傾向をとり$C=100 unit.uF$で最低値となった。

図@fig:decel 〜@fig:vc に各波形を示す。図@fig:edlc_charged のEDLCの充電電圧は、EDLC両端の電圧から電流による電圧降下を引いたものを100 HzのHPFにかけ、元の波形から引くことで算出している。$C=100 unit.uF$では昇圧区間で充電ほとんどされておらず、そのため充電電圧が低下している。図@fig:vc で$C=100 unit.uF$の電圧が小さく、電流も小さいためである。

また図@fig:torque において、2000 rpmの回生失効直前や$C=100 unit.uF$の昇圧区間において発振や目標値からの逸脱が見られる。いずれもPIパラメータの調整不足によるものだと思われるが、調整しきることができなかった。
#imgN(("img/plots/1000rpm/plots_energy/ChargingVoltage.png", "img/plots/2000rpm/plots_energy/ChargingVoltage.png"), ([(a) 1000 rpm], [(b) 2000 rpm]), cap:"EDLC充電電圧比較", lab:<fig:cv>, w:7cm)

#let imgn(i, c, l) = {
	imgN(("img/overray/1000rpm/"+i+".pdf", "img/overray/2000rpm/"+i+".pdf"), ([(a) 1000 rpm], [(b) 2000 rpm]), cap:c, lab:l, w:7.5cm)
}

#imgn("D", "減速度", <fig:decel>)
#imgn("T", "トルク", <fig:torque>)
#imgn("N", "回転数", <fig:n>)
#imgn("Iedlc", "EDLC電流", <fig:iedlc>)
#imgn("Vedlc", "EDLC電圧", <fig:vedlc>)
#imgn("Vcharged2", "EDLC充電電圧", <fig:edlc_charged>)
#imgn("mode", "モード変化", <fig:mode>)
#imgn("Current", "回生電流", <fig:i>)
#imgn("Ic", "平滑コンデンサ電流", <fig:ic>)
#imgn("Vc", "平滑コンデンサ電圧", <fig:vc>)



// #let v = "Deceleration"
// #let n = "2000rpm"
// #imgN(("img/" + n + "/C_none/" + v + ".pdf", "img/" + n + "/0.1/" + v + ".pdf", "img/" + n + "/1.0/" + v + ".pdf", "img/" + n + "/10/" + v + ".pdf", "img/" + n + "/100/" + v + ".pdf"), ([(a) コンデンサなし], [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"減速度波形", lab:<fig2:decel>, w:7cm)
// #let v = "Torque"
// #imgN(("img/" + n + "/C_none/" + v + ".pdf", "img/" + n + "/0.1/" + v + ".pdf", "img/" + n + "/1.0/" + v + ".pdf", "img/" + n + "/10/" + v + ".pdf", "img/" + n + "/100/" + v + ".pdf"), ([(a) コンデンサなし], [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"トルク波形", lab:<fig2:torque>, w:7cm)
// #let v = "Current"
// #imgN(("img/" + n + "/C_none/" + v + ".pdf", "img/" + n + "/0.1/" + v + ".pdf", "img/" + n + "/1.0/" + v + ".pdf", "img/" + n + "/10/" + v + ".pdf", "img/" + n + "/100/" + v + ".pdf"), ([(a) コンデンサなし], [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"回生電流波形", lab:<fig2:i>, w:7cm)
// #let v = "Ic"
// #imgN(("img/" + n + "/0.1/" + v + ".pdf", "img/" + n + "/1.0/" + v + ".pdf", "img/" + n + "/10/" + v + ".pdf", "img/" + n + "/100/" + v + ".pdf"), ([(a) $C$ = 0.1 #unit.uF], [(b) $C$ = 1 #unit.uF], [(c) $C$ = 10 #unit.uF], [(d) $C$ = 100 #unit.uF]), cap:"平滑コンデンサ電流", lab:<fig2:ic>, w:7cm)
// #let v = "Iedlc"
// #imgN(("img/" + n + "/C_none/" + v + ".pdf", "img/" + n + "/0.1/" + v + ".pdf", "img/" + n + "/1.0/" + v + ".pdf", "img/" + n + "/10/" + v + ".pdf", "img/" + n + "/100/" + v + ".pdf"), ([(a) コンデンサなし], [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"EDLC電流", lab:<fig2:iedlc>, w:7cm)
// #let n = "1000rpm"
// #imgN(("img/" + n + "/C_none/" + v + ".pdf", "img/" + n + "/0.1/" + v + ".pdf", "img/" + n + "/1.0/" + v + ".pdf", "img/" + n + "/10/" + v + ".pdf", "img/" + n + "/100/" + v + ".pdf"), ([(a) コンデンサなし], [(b) $C$ = 0.1 #unit.uF], [(c) $C$ = 1 #unit.uF], [(d) $C$ = 10 #unit.uF], [(e) $C$ = 100 #unit.uF]), cap:"EDLC電流", lab:<fig2:iedlc2>, w:7cm)