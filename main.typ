#import "./style.typ":*
#import "./unit.typ"
#import "@preview/pillar:0.3.2"

#show: thesis.with(bibliography-file: "ref.bib")

//#title(date:datetime(year:2025,month:10,day:22),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:12,day:24),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))

= はじめに
今回は挿入するコンデンサの抵抗値の測定、および平滑コンデンサを挿入した場合の充電特性を測定した。

= コンデンサの抵抗値測定
平滑コンデンサ$C$の直列抵抗値$R_s$および直列静電容量$C_s$をLCRメータで測定した。測定に用いた周波数は$f=10 ~ 10000 unit.Hz$である。また、各$C$の仕様を表@tab:capacitor_specs に示す。ESRに関して、データシートへ記載は見当たらなかった。

#tab(
	table(
		..pillar.cols("c|cccc"),
		columns: 5,
		stroke:none,
		align: horizon,
		table.hline(),
		[], [0.1 #unit.uF], [1 #unit.uF], [10 #unit.uF], [100 #unit.uF],
		table.hline(),
		[メーカー], [村田製作所], table.cell(colspan: 3)[ニチコン],
		[品番], [RCER72J#linebreak()104K4K1H03B], [UVZ2G010#linebreak()MPD1TA], [UVZ2G100#linebreak()MHD1TO], [UVY2G101#linebreak()MHD],
		[シリーズ], [RCE], table.cell(colspan: 2)[UVZ], [UVY],
		[種類], [MLCC], table.cell(colspan:3)[アルミニウム電解コンデンサ],
		[データシート],[文献@RCE],table.cell(colspan:2)[文献@UVZ], [文献@UVY],
		[定格電圧], [630 V], table.cell(colspan:3)[450 V],
		[容量誤差], [±10 %], table.cell(colspan:3)[±20 %],
		table.hline()
	),
	cap:"各コンデンサの仕様",
	lab:<tab:capacitor_specs>
)
= 抵抗値測定結果
図@fig:cap_specs に各コンデンサの直列抵抗値$R_s$および直列静電容量$C_s$の測定結果を示す。$C_s$は公称容量に対する割合で示している。$C$が増加するに従い$R_s$は減少し、$C_s$は周波数増加に伴い減少する傾向が見られた。
#imgN(("img/C_r/Rs_all.pdf", "img/C_r/Cs_all.pdf"), ([(a) 直列抵抗値$R_s$], [(b) 直列静電容量値$C_s$]), cap: "測定結果", lab:<fig:cap_specs>)

= 充電特性測定方法
図@fig:circuit に回生回路を示す。整流回路の後段に平滑コンデンサを並列に接続し、回生開始回転数$N_0$ = 1000, 2000 rpmとする。平滑コンデンサ容量$C$を0.1, 1, 10, 100 #unit.uF と変化させ各特性を測定した。保護抵抗$R_"p"$ = 10 #unit.Ohm である。
#img("img/regeneration_circuit.pdf", cap:"実験回路図", lab:<fig:circuit>, w:90%)
#pb
= 充電特性測定結果
図@fig:cv にEDLC充電電圧の比較を示す。1000, 2000 rpmにおいて、減速度制御時に比べてコンデンサ容量による変化はみられず、コンデンサなしの場合とほぼ同じ電圧であった。

図@fig:n - @fig:vc に各波形を示す。基本的にいずれの波形においても、容量による変化は小さい。ただし回生電流と平滑コンデンサ電流は、容量が大きくなるにつれてリプルが増加した。

#imgN(("img/plots/1000rpm/plots_energy/ChargingVoltage.png", "img/plots/2000rpm/plots_energy/ChargingVoltage.png"), ([(a) 1000 rpm], [(b) 2000 rpm]), cap:"EDLC充電電圧比較", lab:<fig:cv>, w:7cm)

#let imgn(i, c, l) = {
	imgN(("img/overray/1000/"+i+".pdf", "img/overray/2000/"+i+".pdf"), ([(a) 1000 rpm], [(b) 2000 rpm]), cap:c, lab:l, w:7.5cm)
}

#imgn("N", "回転数", <fig:n>)
#imgn("Iedlc", "EDLC電流", <fig:iedlc>)
#imgn("Vedlc", "EDLC電圧", <fig:vedlc>)
#imgn("Vcharged2", "EDLC充電電圧", <fig:edlc_charged>)
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