#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:8,day:8),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:4,day:1))


= はじめに
今回は各回転数ごとの回生前と停止後のエネルギーの割合を解析によって求める。

= 解析方法
初期回転数を$N_0$ = 500 - 3000 rpmと変化させ、@exp:calcW より初期エネルギー$W_0$, 機械損エネルギー$W_"m"$, ジュール熱$W_"joule"$, EDLCの充電エネルギー$W_"EDLC"$, その他のエネルギー$W_"other"$とその割合を求める。またEDLCの静電容量を$C$=0.0556 F, 内部抵抗を$R_"EDLC"$=4.5 #unit.Ohm, 保護抵抗を$R_"p"$ = 10 #unit.Ohm とする。
#v(2em)
$ 
    T_"m" &= ((J_"PMSM")/tau + K_1)omega + T_"C"\
    W_0 &= 1/2 J omega^2 \
    W_"m" &= integral T_"m" omega "d" t \
    W_"joule" &= integral(R_"EDLC" + R_"p")I^2 "d" t \
    W_"EDLC" &= 1/2 C V_"EDLC"^2 \
    W_"other" &= W_0 - (W_"m" + W_"joule" - W_"EDLC") 
$<exp:calcW>
#v(1em)
#tab(
    table(
        columns: 3,
        column-gutter: 2em,
        row-gutter: 0.5em,
        stroke:none,
        table.hline(),
        [サーボモータ慣性],[$J_"PMSM"$],[$6.0 times 10^(-4)$ #unit.kgm2],
        [回転体慣性], [$J$], [0.0211106 #unit.kgm2],
        [フライホイールトルク係数],[$K_1$],[$0.0025$],
        [フライホイールトルク定数],[$T_"C"$],[$0.55$ #unit.Nm],
        [軸時定数], [$tau$], [1.1 s],
        [ダイオード順方向電圧], [$V_f$], [1.3 V],
        table.hline(),
    ), cap:"実験装置諸元"
)
#pb
= 解析結果
@chart に各回転数ごとのエネルギーの割合を, @EnergyRatePlot に各回転数ごとの変化を示す。回転数が増加するに従い機械損の割合が減少し、ジュール損及び回生エネルギーが増加している。また、回転数が増加すると回転時間および回生している時間は増加するが回生時間の割合は減少し、回生失効後の割合が増加している。

@rate に回生失効時の回転数, 機械損トルク, 機械損の割合を示す。停止時の機械損に対して回生失効時の機械損の割合は$N_0$が大きくなると小さくなり、回生失効後の機械損の割合が増加している。$N_0$が大きい場合は発電電圧が高く回生電流も大きいため、ブレーキが強くなり回生している時間の割合が小さくなる。また、回生失効時の回転数の増加幅より機械損トルクの減少幅が大きい。よって、回生中の機械損の減少幅が回生失効後の機械損の増加幅を上回っており、全体として機械損の割合が減少していると考えられる。
#imgN(("\graph\pie\1000.png", "\graph\pie\2000.png", "\graph\pie\3000.png"), ([(a) $N_0$=1000 rpm], [(b) $N_0$=2000 rpm], [(c) $N_0$=3000 rpm]), cap:"各回転数ごとのエネルギーの割合", lab:<chart>, w:7.5cm)
#imgN(("\graph\N\EnergyRate.svg", "\graph\N\Times.svg"), ("(a) エネルギーの割合", "(b) 回転時間と回生時間の割合"), cap:"回転数による変化", lab:<EnergyRatePlot>, w:7.5cm)

#imgN(("graph/N/N.svg","graph/N/trq.svg","graph/N/Wm.svg"), ([(a) 回転数], [(b) 機械損トルク], [(c) 機械損]), cap:"回生失効時の割合", lab:<rate>, w:7.5cm)
#pb
= 補足資料
#imgN(
    ("\graph\N.svg", "\graph\I.svg", "\graph\Mloss.svg","\graph\Rloss.svg","\graph\RegE.svg","\graph\T.svg","\graph\Treg.svg","\graph\Tm.svg"),
    ([(a) 回転数], [(b) 電流], [(c) 機械損], [(d) ジュール損], [(e) 回生エネルギー], [(f) トルク], [(g) 回生トルク], [(h) 機械トルク]),
    cap:"各回転数ごとの時間変化", lab:<NIMRTE>, w:92%
)
#pb
#img("graph/circuit.svg", cap:"解析回路図")