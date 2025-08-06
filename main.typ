#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:8,day:8),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
今回は各回転数ごとの回生前と停止後のエネルギーの割合を解析によって求める。

= 解析方法
@circuit に解析回路図を示す。初期回転数を$N_0$ = 500 - 3000 rpmと変化させ、@exp:calcW より初期エネルギー$W_0$, 機械損エネルギー$W_"m"$, ジュール熱$W_"joule"$, EDLCの充電エネルギー$W_"EDLC"$, その他のエネルギー$W_"other"$とその割合を求める。またEDLCの静電容量を$C$=0.0556 F, 内部抵抗を$R_"EDLC"$=4.5 #unit.Ohm, 保護抵抗を$R_"p"$ = 10 #unit.Ohm とする。
#img("graph/circuit.svg", cap:"解析回路図", lab:<circuit>, w:80%)
$ 
    T_"m" &= ((6 times 10 ^ (-4))/1.1 + 0.0025)omega + 0.55\
    W_0 &= 1/2 J omega^2 \
    W_"m" &= integral T_"m" omega "d" t \
    W_"joule" &= integral(R_"EDLC" + R_"p")I^2 "d" t \
    W_"EDLC" &= 1/2 C V_"EDLC"^2 \
    W_"other" &= W_0 - (W_"m" + W_"joule" - W_"EDLC") 
$<exp:calcW>
#pb
= 解析結果
@chart に各回転数ごとのエネルギーの割合を, @EnergyRatePlot に各回転数ごとの変化を示す。回転数が増加するに従い機械損の割合が減少し、ジュール損及び回生エネルギーが増加している。また、回転数が増加すると回転時間および回生時間は増加するが回生時間の割合は減少し、回生失効後の割合が増加している。
@Mloss に回転数ごとの機械損の時間変化を示す。#cred([●])が回生失効, #cblue([●])が停止時刻を表す。
#imgN(("\graph\pie\1000.png", "\graph\pie\2000.png", "\graph\pie\3000.png"), ([(a) $N_0$=1000 rpm], [(b) $N_0$=2000 rpm], [(c) $N_0$=3000 rpm]), cap:"各回転数ごとのエネルギーの割合", lab:<chart>, w:8cm)
#imgN(("\graph\N\EnergyRate.svg", "\graph\N\Times.svg"), ("(a) エネルギーの割合", "(b) 回転時間と回生時間の割合"), cap:"回転数による変化", lab:<EnergyRatePlot>, w:100%)

#imgN(("/graph/timed/Mloss.svg", "graph/timed/Tm.svg", "graph/timed/N.svg"), ([(a) 機械損$W_"m"$], "(b) 機械損トルク", [(c) 回転数]), cap:"機械損の時間変化", lab:<Mloss>, w:7.5cm)