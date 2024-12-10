#import "./style.typ":*
#import "@preview/metro:0.1.0": *
#import "bxbibwrite.typ": *

#show: thesis.with(
  bibliography-file: none
)

#title("12","11","水")

= はじめに <beg>
#pr()
前回は保護抵抗を削除し、コイル接続時のPI制動トルク制御を行った。そこで、解析と実験に差異が生じたことを確認した。今回は再度コイル接続時のPI制動トルク制御実験を行う。また、卒論に向けてPI制動トルク制御実験を合同で行う。
#lb()
#lb()
= コイル接続時のPI制動トルク制御 <inductor>
#pr()
前回は解析と実験で差異が生じていたが、原因としては実験において抵抗を接続したまま行っていたためである。@inductor:circuit に回生回路，@inductor:result に実験結果を示す。ただし、回生開始回転数 $N_0$ = 1000[rpm]，回生開始時刻 $t$ = 0，EDLC静電容量 $C_"EDLC"$ = 0.0556[F]，EDLC内部抵抗 $R_"EDLC"$ = 4.55[Ω]，コイルはインダクタンス10[mH]，直列抵抗87[mΩ]，ピーク定格電流10[A]とする。

#img("pic/Inductor_fig/cir.svg", "回生回路", "inductor:circuit")
#np()
#imgN(("pic/Inductor_fig/deceleration.svg", "pic/Inductor_fig/torque.svg","pic/Inductor_fig/N.svg", "pic/Inductor_fig/current.svg","pic/Inductor_fig/duty.svg", "pic/Inductor_fig/v_edlc.svg"), ("(a) Deceleration", "(b) Torque","(c) Rotational speed", "(d) Regenerative current","(e) Duty ratio", "(f) Charging voltage"), "コイル接続時のPI制動トルク制御（電流制限モード）の実験結果", "inductor:result", w:7.5cm)

@inductor:result (a)と@inductor:result (c)より、減速度および回転数は概ね一致していることから減速度制御ができていることがわかる。また、@inductor:result (d)より実験では回生開始直後に解析よりも大きい8.47[A]であり、突入電流が懸念される。しかし、エネルギーの内訳では保護抵抗考慮時と比較して回生エネルギーが1%上昇しており、減速度制御が可能かつエネルギーの向上が見られる点からコイル接続は案の一つとして考慮できるのではないかと思われる。
#lb()
#lb()
= PI制動トルク制御実験 <exp>
#pr()
@exp:circuit に回生回路，@exp:result に実験結果を示す。ただし、回生開始回転数 $N_0$ = 1000[rpm]，回生開始時刻 $t$ = 0，EDLC静電容量 $C_"EDLC"$ = 0.0556[F]，EDLC内部抵抗 $R_"EDLC"$ = 4.55[Ω]，保護抵抗 $R_p$ = 10[Ω]とする。また、サンプリング周波数を1200[Hz]、スイッチング周波数を500[Hz]とする。
#img("pic/exp/regeneration_circuit.svg", "回生回路", "exp:circuit", w:11cm)
#imgN(("pic/exp/グラフ/Deceleration.svg", "pic/exp/グラフ/torque.svg","pic/exp/グラフ/N.svg", "pic/exp/グラフ/current.svg","pic/exp/グラフ/duty.svg", "pic/exp/グラフ/v_edlc.svg"), ("(a) Deceleration", "(b) Torque","(c) Rotational speed", "(d) Regenerative current","(e) Duty ratio", "(f) Charging voltage"), "実験および解析結果比較図", "exp:result", w:7.5cm)

@exp:result から、実験と解析の結果が概ね一致しており充電電圧は解析において15.66[V]、実験においては15.46[V]であり、追従時間は解析においては0.91秒、実験においては0.82秒であった。
//#include("reference.typ")