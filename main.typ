#import "style.typ": *
#import "unit.typ"
#show: thesis
#title(date: datetime(year: 2026, month: 11, day: 11), year: 2026, id: "電23-153", name: "細川 智")

= 概要
回生ブレーキの減速度制御に用いる反転型昇降圧コンバータについて、スイッチング周波数による効率と損失の変化を調べた。

= 実験方法
図@fig:circuit に昇降圧コンバータの回路を示す。
入力電圧と出力電圧をそれぞれ10～60 Vの範囲で変化させ、スイッチング周波数5 kHz及び50 kHzで効率と各素子の損失を測定した。
測定はA・Bの2回に分け、測定AではMOSFET及び$L_1$、測定Bではダイオードの電圧と電流を測定した。
また、入力電流の上限を電源装置の保護機能の最低値である0.8 Armsに設定した。

入力電圧 $V_"in"$、入力抵抗の電圧 $V_"shunt"$、出力電圧 $V_"out"$ を測定し、入力抵抗 $R_"shunt" = 1 unit.Ohm$ と負荷抵抗 $R_"load" = 200 unit.Ohm$ から入力電流と効率を求めた。
$ I_"in" = V_"shunt" / R_"shunt", quad eta = (V_"out"^2 / R_"load") / (V_"in" I_"in") times 100 % $

各素子の損失は、測定した電圧と電流の積をスイッチング周期の整数倍の時間で積分し、時間平均することで求めた。
$ P = 1/T integral_0^T v(t)i(t) dif t $

#img("2026-11-11_全点比較/circuit.png", cap: [反転型昇降圧コンバータの測定回路], w: 10cm, place: none, lab: <fig:circuit>)

#pagebreak()
= 実験結果
#tab(table(
  columns: 3,
  stroke: none,
  table.hline(),
  [スイッチング\ 周波数 (kHz)], [入力電圧 (V)], [出力電圧 (V)],
  table.hline(),
  table.cell(rowspan: 3, align:horizon)[5kHz],
  [10], [−10],
  [20], [−10],
  [30 - 60], [−10, −20],
  table.hline(),
  table.cell(rowspan: 4, align:horizon)[50kHz],
  [10], [−10 - −30],
  [20, 30], [−10 - − 40],
  [40], [−10 - −50],
  [50, 60], [−10 - −60],
  table.hline(),
), cap: [測定範囲], place: none, lab: <tab:condition>)

#imgN(("2026-11-11_全点比較/A_eff_pct.svg", "2026-11-11_全点比較/A_total_loss_mW.svg"), ([(a) 効率], [(b) 全損失]), cap: [入力電圧と効率及び全損失], w: 73mm, place: none, lab: <fig:eff_loss>)
表@tab:comparison に両周波数で測定できた条件の結果を示す。
この条件外では、入力電流が0.8 Armsを超え、測定しなかった。
50 kHzでは出力電圧の範囲が広く、測定点数も多かった。

図@fig:eff_loss に入力電圧と効率及び全損失の関係を、表@tab:comparison に両周波数で測定した同一条件のときの結果を示す。
図@fig:eff_loss の破線は5 kHz、実線は50 kHzを示す。表@tab:comparison の差は50 kHzから5 kHzの値を引いたものである。
出力約−10 Vでは5 kHzの方が4.50 - 14.4ポイント高効率となり、50 kHzでは入力電圧が高くなるにつれて全損失が増加した。
一方、出力約−20 Vでは50 kHzの方が23.6 - 29.9ポイント高効率となり、全損失は5 kHzの1.70 - 1.91 Wから0.478 - 0.627 Wに低下した。
周波数の変更による効率への影響は入出力条件によって異なった。

#let compare = csv("2026-11-11_全点比較/comparison.csv")
#tab(table(columns: (auto, auto, auto, auto, auto, auto), align: center,
  inset: (x: 7pt, y: 5pt),
  stroke:none,
  table.hline(),
  table.header([入力 (V)], [出力 (V)], [効率 (%)\ 5 / 50 kHz], [効率差\ (ポイント)], [全損失 (W)\ 5 / 50 kHz], [全損失差 (W)]),
  table.hline(),
  ..compare.slice(1).flatten(),
  table.hline(),
), cap: [5 kHzと50 kHzの効率及び全損失], place: none, lab: <tab:comparison>)


#imgN(("2026-11-11_全点比較/breakdown10.svg", "2026-11-11_全点比較/breakdown20.svg"), ([(a) 出力−10 V], [(b) 出力−20 V]), cap: [各条件における損失内訳], w: 73mm, place: none, lab: <fig:breakdown>)

図@fig:breakdown に両周波数で測定した条件における損失内訳を示す。
左の斜線を付けた棒が5 kHz、右の棒が50 kHzである。
出力約−10 V、入力約10 V及び20 Vでは、50 kHzにすると$L_1$の損失が減少した一方で、MOSFETの損失が増加し、全損失も増加した。

5 kHzでは出力約−20 Vのとき$L_1$の電圧と電流から求めた平均電力は負となった。
またMOSFET、ダイオードの損失についても全損失を上回ったため、5 kHzでの損失内訳を正しく評価できていない。

50 kHzでは入力約30 V及び40 Vで、算出した3素子のうちMOSFETの損失が最大となった。



#img("2026-11-11_全点比較/all50_grouped.svg", cap: [50 kHzにおける損失割合], w: 155mm, place: none, lab: <fig:all50>)

#imgN(("2026-11-11_全点比較/l1_vi.svg", "2026-11-11_全点比較/l1_vi_60v.svg"), ([(a) 入力40V、出力−30V], [(b) 入力60V、出力−60V]), cap: [$L_1$の電流電圧波形], h: 73mm, place: none, lab: <fig:l1_vi>)
#imgN(("2026-11-11_全点比較/mos_vi.svg", "2026-11-11_全点比較/mos_vi_60v.svg"), ([(a) 入力40V、出力−30V], [(b) 入力60V、出力−60V]), cap: [MOSFETの電流電圧波形], h: 73mm, place: none, lab: <fig:mos_vi>)



図@fig:all50 に50 kHzにおける各素子の損失割合を示す。
今回の抵抗負荷試験では、出力約−20 Vで50 kHzの方が高効率である一方、出力約−10 Vでは5 kHzの方が高効率であった。
また50 kHzでは、MOSFETによる損失が全損失の大部分を占め、出力電圧が高くなると$L_1$の損失の割合は小さくなった。

図@fig:l1_vi および図@fig:mos_vi に50 kHzにおける入力電圧40V/出力電圧−30Vのときと入力電圧60V/出力電圧−60Vのときの$L_1$とMOSFETの電流電圧波形を示す。
いずれの波形でも、入出力60V / −60Vのときの方が、電流が0.6 A程度から12 A程度に増加しており、損失が大きくなっている。

// #pagebreak()

// #let detail(path, caption) = {
//   let data = csv(path)
//   tab(table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), align: center,
//     inset: (x: 3.5pt, y: 1.35pt),
//     table.header([入力\ (V)], [出力\ (V)], [効率\ (%)], [全損失\ (W)], [MOSFET\ (W)], [$L_1$\ (W)], [D1\ (W)], [未配分\ (W)], [判定]),
//     ..data.slice(1).flatten(),
//   ), cap: caption, place: top)
// }
// #detail("2026-11-11_全点比較/detail5.csv", [5 kHzにおける損失内訳])

// 括弧内は全損失に対する割合を示す。

// #pagebreak()
// #detail("2026-11-11_全点比較/detail50a.csv", [50 kHzにおける損失内訳（1）])

// #pagebreak()
// #detail("2026-11-11_全点比較/detail50b.csv", [50 kHzにおける損失内訳（2）])

= 今後の予定
幅広い範囲で安定動作した50 kHzを採用し、強化学習での制御の検証を進める。
また、インダクタを交換した場合についての評価も行う。





