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
    
    W_"EDLC" &= 1/2 C V_"EDLC"^2 \
    W_"PMSM" &= R_"Stator" (I_"U"^" 2" + I_"V"^" 2" + I_"W"^" 
    2") \
    W_"Diode" &= sum(V_"f" I_"Diode") \
    W_"joule" &= integral(R_"EDLC" + R_"p")I^2 "d" t + W_"PMSM" + W_"Diode" \
    W_"other" &= W_0 - (W_"m" + W_"joule" + W_"EDLC") 
$<exp:calcW>
#pb
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
        [PMSM固定子抵抗], [$R_"Stator"$], [0.35 #unit.Ohm],
        [ダイオード順方向電圧], [$V_f$], [1.3 V],
        table.hline(),
    ), cap:"実験装置諸元"
)
#pb
= 解析結果
@chart に各回転数ごとのエネルギーの割合を、@EnergyRatePlot に回転数ごとのエネルギーの割合およびダイオード損の変化を示す。前回の輪講の「その他のエネルギー」の内訳はダイオードとモータ内の固定子抵抗によるものがほとんどであり、いずれにも該当しないものはいずれの回転数においても全体の0.01%以下であった。これは解析の際に解析ステップ幅などにより生じた誤差であると考えられる。
#imgN(("\graph\chart\1000.svg", "\graph\chart\2000.svg", "\graph\chart\3000.svg"), ([(a) $N_0$=1000 rpm], [(b) $N_0$=2000 rpm], [(c) $N_0$=3000 rpm]), cap:"各回転数ごとのエネルギーの割合", lab:<chart>, w:7.5cm)

#imgN(("graph/N/EnergyRate.svg", "\graph\N\Dloss.svg"), ([(a) エネルギーの割合], [(b) ダイオード損の変化]), cap:"回転数による変化", lab:<EnergyRatePlot>, w:7.5cm)

#pb
= 補足資料
#imgN(
    ("\graph\N.svg", "\graph\I.svg", "\graph\Mloss.svg","\graph\Rloss.svg","\graph\RegE.svg","\graph\T.svg","\graph\Treg.svg","\graph\Tm.svg"),
    ([(a) 回転数], [(b) 電流], [(c) 機械損], [(d) ジュール損], [(e) 回生エネルギー], [(f) トルク], [(g) 回生トルク], [(h) 機械トルク]),
    cap:"各回転数ごとの時間変化", lab:<NIMRTE>, w:92%
)