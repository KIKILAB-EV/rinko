#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2025,month:9,day:24),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
強化学習を用いた制御のシミュレーションをMATLAB/Simulinkで行った。

= 環境の設定
@tab:env に学習環境のパラメータを、@img:env にシミュレーション環境の図を示す。回生開始回転数$N_0$=1000 rpmから制御を開始し、$N<0.1$rpmとなれば制御終了とする。また、即値報酬の関数を@exp:reward および@img:rewardFnc に示す。目標減速度との誤差$e$をもとに報酬を計算し、誤差が小さいほど報酬が高くなり離れると報酬が低くなる。アルゴリズムはSAC(Soft Actor-Critic)を用いる。@tab:rlparam に学習のパラメータを示す。また @img:agent にエージェントの構成を示す。観測項目は目標減速度, 減速度, 目標との誤差の誤差, デューティ比, 車両速度の5項目とした。
#tab(
  table(
    columns: 3, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Item],[Symbol],[Value],
    table.hline(),
    [ダイオード順方向電圧],[$"V"_"f"$],[1.3 V],
    [ダイオードオン抵抗], [$"R"_"ON"$], [0.1 Ω],
    [ダイオードオフコンダクタンス], [$"G"_"OFF"$], [$10^(-8)$ S],
    [MOSFETしきい電圧],[$"V"_"th"$],[2 V],
    [MOSFETオン抵抗], [$"R"_"DS"$], [0.01 Ω],
    [MOSFETコンダクタンス], [$"G"_"OFF"$], [$1.0 times 10^(-6)$ S],
    [PMSM極数], [$"p"$], [4],
    [PMSM逆起電力定数], [$"K"_"e"$], [0.0404 V/rpm],
    [PMSM固定子抵抗], [$"R"_"s"$], [0.35 Ω],
    [PMSM d軸インダクタンス], [$"L"_"d"$], [4.73 mH],
    [PMSM q軸インダクタンス], [$"L"_"q"$], [4.23 mH],
    [PMSM回転子慣性], [$"J"$], [0.0006 #unit.kgm2],
    [PMSM回転子減衰], [$"B"$], [$1.0 times 10^(-6)$ Nm/(rad/s)],
    table.hline(),
    [車両ギア比], [$mu$], [10],
    [車重], [$"M"$], [58.86 kg],
    [タイヤ半径],[$"r"$], [0.18 m],
    table.hline(),
  ), cap:"学習環境パラメータ",
  lab: <tab:env>
)
#tab(
  table(
    columns: 2, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Parameter],[Value],
    table.hline(),
    [割引係数], [0.9],
    [Actor学習率], [0.01],
    [Critic学習率], [0.01],
    [バッチサイズ], [64],
    [サンプリング周期], [10 ms],
    [エピソード数], [200],
    table.hline(),
  ),
  cap: "強化学習パラメータ",
  lab: <tab:rlparam>
)
#imgN(("img/env1.png","img/env2.png"), ("(a) シミュレーション全体図","(b) 回生回路"), cap:"シミュレーション環境", lab:<img:env>)
#img("img/rewardFnc.png", cap:"報酬関数", lab:<img:rewardFnc>,w:11cm)
$
  R = 10 exp(-20 e^2)-9.8
$<exp:reward>
#img("img/agent.png", cap:"SACエージェントの構成", lab:<img:agent>,w:11cm)
= 結果
@img:reward にエピソード報酬の推移を示す。学習が進むにつれて報酬が高くなっていることがわかる。60回程度の学習でエピソード報酬は落ち着いている。また、@img:decel -7に各エピソードの減速度, 回生電流, デューティ比, 充電電圧を示す。50回目程度からジャーク区間での減速度は目標値に追従するようになってきている。100回目程度以降からはデューティ比が大きくなってからの制御が不安定となり減速度が大きく変動しているほか、ジャーク区間の追従も不安定となっている。

= 今後の予定
観測項目の内容や即値報酬の関数などの学習のパラメータを変更し、学習の改善を図る。またTD3やDDPGなど他のアルゴリズムを用いた学習も試みる。
#img("img/graphSAC/EpisodeReward.svg", cap: "エピソード数と報酬の推移", lab:<img:reward>)
#imgN(("img/graphSAC/Agent10/D.svg","img/graphSAC/Agent50/D.svg","img/graphSAC/Agent100/D.svg","img/graphSAC/Agent150/D.svg","img/graphSAC/Agent200/D.svg"), ("(a) Episode 10","(b) Episode 50","(c) Episode 100","(d) Episode 150","(e) Episode 200"), cap:"各エピソードの減速度", lab:<img:decel>, w:8.5cm)
#imgN(("img/graphSAC/Agent10/I.svg","img/graphSAC/Agent50/I.svg","img/graphSAC/Agent100/I.svg","img/graphSAC/Agent150/I.svg","img/graphSAC/Agent200/I.svg"), ("(a) Episode 10","(b) Episode 50","(c) Episode 100","(d) Episode 150","(e) Episode 200"), cap:"各エピソードの回生電流", lab:<img:current>, w:8.5cm)
#imgN(("img/graphSAC/Agent10/Duty.svg","img/graphSAC/Agent50/Duty.svg","img/graphSAC/Agent100/Duty.svg","img/graphSAC/Agent150/Duty.svg","img/graphSAC/Agent200/Duty.svg"), ("(a) Episode 10","(b) Episode 50","(c) Episode 100","(d) Episode 150","(e) Episode 200"), cap:"各エピソードの出力デューティ比", lab:<img:duty>, w:8.5cm)
#imgN(("img/graphSAC/Agent10/Vc.svg","img/graphSAC/Agent50/Vc.svg","img/graphSAC/Agent100/Vc.svg","img/graphSAC/Agent150/Vc.svg","img/graphSAC/Agent200/Vc.svg"), ("(a) Episode 10","(b) Episode 50","(c) Episode 100","(d) Episode 150","(e) Episode 200"), cap:"各エピソードの充電電圧", lab:<img:voltage>, w:8.5cm)