#import "./style.typ": *
#import "./unit.typ"
#show: thesis
#title(date: datetime(year: 2026, month: 11, day: 11), year: 2026)

= 概要
回生ブレーキの減速度制御に用いる反転型昇降圧コンバータについて、入力10～60 Vの抵抗負荷試験から、スイッチング周波数による効率と損失の変化を調べた。測定Aの動作点は5 kHzで10点、50 kHzで28点であり、このうち同じ入出力目標の10点を周波数間で比較した。

= 実験方法
図1の回路を用い、負荷抵抗は実測202.5 Ω、入力電流測定抵抗は実測0.962 Ωとした。出力正側をGNDとし、入力・出力の目標は10 V刻みとした。重複測定は2回目を採用した。50 kHzの20 V→−30 Vでは、テスター③の記録を−29.96 Vに訂正した。
#img("circuit.png", cap: [反転型昇降圧コンバータの回路図。図中R2とR1の実験時の抵抗値はそれぞれ0.962 Ωと202.5 Ω], w: 112mm, place: bottom)

テスター①で回路端入力電圧 $V_"in"$、②で入力電流測定抵抗の電圧 $V_"sh"$、③で出力電圧 $V_"out"$ を測定した。$I_"in" = V_"sh"/R_"sh"$、$I_"out" = abs(V_"out")/R_"load"$ とし、$P_"in" = V_"in" I_"in"$、$P_"out" = V_"out"^2/R_"load"$ から効率 $eta = P_"out"/P_"in"$ と全損失 $P_"loss" = P_"in" - P_"out"$ を求めた。入力電流測定抵抗と別電源のゲート駆動の消費電力は集計対象から除いた。

MOSFETとL1は測定A、ダイオードD1は測定Bの端子電圧・枝電流から、ゼロ点と電圧・電流間の時間ずれを補正して $v(t)i(t)$ を整数周期で平均した。AとBは回路端入力電圧・出力電圧の差が各2%以内、入力電流差が5%以内の点を組み合わせた。全損失から採用した素子損失を引いた差を未配分とした。未配分には未評価の素子・配線損失と測定誤差が含まれる。

#pagebreak()
= 効率と全損失
#imgN(("A_eff_pct.svg", "A_total_loss_mW.svg"), ([(a) 効率], [(b) 全損失]), cap: [全測定点の効率と全損失。破線は5 kHz、実線は50 kHz。凡例の電圧は出力目標], w: 73mm, place: top)

出力−10 Vでは5 kHzが全6点で4.50～14.4ポイント高効率で、50 kHzの全損失は入力電圧とともに増えた。出力−20 Vでは50 kHzが全4点で23.6～29.9ポイント高効率で、全損失は5 kHzの1.70～1.91 Wから0.478～0.627 Wに下がった。周波数を上げた効果は負荷条件で逆転した。

#let compare = csv("comparison.csv")
#tab(table(columns: (auto, auto, auto, auto, auto, auto), align: center,
  inset: (x: 7pt, y: 2pt),
  table.header([入力 (V)], [出力 (V)], [効率 (%)\ 5 / 50 kHz], [効率差\ (ポイント)], [全損失 (W)\ 5 / 50 kHz], [全損失差 (W)]),
  ..compare.slice(1).flatten(),
), cap: [共通10点の比較。差は50 kHzから5 kHzを引いた値], place: bottom)

#pagebreak()
= 素子別の損失
#imgN(("breakdown10.svg", "breakdown20.svg"), ([(a) 出力−10 V], [(b) 出力−20 V]), cap: [共通10点の損失内訳。左の斜線棒は5 kHz、右の棒は50 kHz], w: 73mm, place: top)

== 出力−10 V
入力10 Vと20 Vでは両周波数の3素子を比較できた。50 kHzにするとL1の損失は減ったが、MOSFET損失の増加が上回り、全損失が増えた。入力30～50 Vの50 kHzでは、波形から求めた素子損失の合計がテスターによる全損失を超えたため、棒は全損失を未配分で表示した。

== 出力−20 V
5 kHzでは共通4点すべてでL1のピークが5 Aを超え、補正後もL1の周期平均電力が負値になった。棒にはテスターから求めた全損失を表示した。50 kHzで3素子の収支が成立した入力30 V、40 Vでは、MOSFETが算出できた素子のうち最大だった。入力50 V、60 Vでは素子損失の合計が全損失を超えたため、内訳を未配分とした。

#pagebreak()
= 波形比較
#imgN(("wave_10_5.svg", "wave_10_50.svg"), ([(a) 5 kHz], [(b) 50 kHz]), cap: [出力−10 VのL1電流。凡例は入力目標], w: 73mm, place: top)
#imgN(("wave_20_5.svg", "wave_20_50.svg"), ([(a) 5 kHz], [(b) 50 kHz]), cap: [出力−20 VのL1電流。縦軸は0.2 A以内を線形、それより上を対数とした], w: 73mm, place: top)

横軸はスイッチング周期で規格化した。5 kHzの1周期は200 µs、50 kHzは20 µsである。出力−20 Vでは、5 kHzのオン区間末尾に8.58～9.36 Aのピークが現れ、50 kHzでは0.269～0.324 Aだった。電流上昇が終盤で急になる形はL1の飽和と整合し、全損失の周波数差と同時に観察された。

#pagebreak()
= スイッチング波形と50 kHzの全域
#imgN(("vds_10.svg", "vds_20.svg"), ([(a) 出力−10 V], [(b) 出力−20 V]), cap: [入力40 VでのMOSFETドレイン・ソース間電圧。横軸は周期で規格化], w: 73mm, place: top)
#imgN(("all50_low.svg", "all50_high.svg"), ([(a) 出力−10～−30 V], [(b) 出力−40～−60 V]), cap: [50 kHzの全28点における全損失に対する内訳の割合], w: 73mm, place: top)

今回の抵抗負荷試験では、−20 Vで50 kHzの利点が大きい一方、−10 Vでは5 kHzの方が高効率だった。回生制御で想定するモータ側平均約1 Aでの運転は、今回の周波数比較とは別の負荷条件になる。

#pagebreak()
= 付表
#let detail(path, caption) = {
  let data = csv(path)
  tab(table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), align: center,
    inset: (x: 3.5pt, y: 1.35pt),
    table.header([入力\ (V)], [出力\ (V)], [効率\ (%)], [全損失\ (W)], [MOSFET\ (W)], [L1\ (W)], [D1\ (W)], [未配分\ (W)], [備考]),
    ..data.slice(1).flatten(),
  ), cap: caption, place: top)
}
#detail("detail5.csv", [5 kHzの全10点。括弧内は全損失に対する割合])

備考の「B波形」はダイオード評価、「A波形」はMOSFETまたはL1評価に用いた波形の判定を示す。「収支超過」はA・Bの素子損失合計がAの全損失を上回った点である。「—」は値を割り当てられなかった箇所を示す。

#pagebreak()
#detail("detail50a.csv", [50 kHzの全28点。括弧内は全損失に対する割合])

#pagebreak()
#detail("detail50b.csv", [50 kHzの測定結果（2）。括弧内は全損失に対する割合])

= 今後の予定

