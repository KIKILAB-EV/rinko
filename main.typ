#import "./style.typ":*
#import "@preview/metro:0.1.0": *
#import "bxbibwrite.typ": *

#show: thesis.with(
  bibliography-file: none
)

#title("12","11","水")

= はじめに <beg>
#pr()
前回は保護抵抗を削除し、コイル接続時のPI制動トルク制御を行った。そこで、解析と実験に差異が生じたことを確認した。今回は再度コイル接続時のPI制動トルク制御実験を行う。また、荻野君のパラメータを使用し、PI制動トルク制御実験を行う。
#lb()
#lb()
= コイル接続時のPI制動トルク制御 <inductor>
#pr()
前回は解析と実験で差異が生じていたが、原因としては実験において抵抗を接続したまま行っていたためである。@inductor:circuit に回生回路，@inductor:result に実験結果を示す。ただし、回生開始回転数 $N_0$ = 1000[rpm]，回生開始時刻 $t$ = 0，EDLC静電容量 $C_"EDLC"$ = 0.0556[F]，EDLC内部抵抗 $R_"EDLC"$ = 4.55[Ω]，コイルはインダクタンス10[mH]，直列抵抗87[mΩ]，ピーク定格電流10[A]とする。

#img("pic/Inductor_fig/cir.svg", "回生回路", "inductor:circuit")
#np()
#imgN(("pic/Inductor_fig/decel.svg", "pic/Inductor_fig/torque.svg","pic/Inductor_fig/N.svg", "pic/Inductor_fig/current.svg","pic/Inductor_fig/duty.svg", "pic/Inductor_fig/vedcl.svg"), ("(a) Deceleration", "(b) Torque","(a) Deceleration", "(b) Torque","(a) Deceleration", "(b) Torque"), "コイル接続時の PI 制動トルク制御（電流制限モード）の実験結果", "inductor:result", w:7.5cm)

@inductor:result (a)と@inductor:result (c)より、減速度および回転数は概ね一致していることから減速度制御ができていることがわかる。また、@inductor:result (d)より実験では回生開始直後に解析よりも大きい8.47[A]であり、突入電流が懸念される。しかし、エネルギーの内訳では保護抵抗考慮時と比較して回生エネルギーが1%しており、減速度制御が可能かつエネルギーの向上が見られる点からコイル接続は案の一つとして考慮できるのではないかと思われる。
//#include("reference.typ")