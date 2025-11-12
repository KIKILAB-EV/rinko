#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2025,month:11,day:12),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
前回に引き続き強化学習による制御をMATLAB/Simulinkで行った。今回はSACにおいて、学習時に目標減速度を乱数により変化させて学習させた。

= 環境の設定
@tab:rlparam に強化学習のパラメータを示す。また報酬関数を@exp:rf1 に示す。また最大減速度に$k=$0.1, 0.2, 0.3, 0.4とし、最大減速度$D_"max" times (1±k)$の乱数を掛けた値を目標減速度とした。なお乱数生成は一様分布で行った。
#tab(
  table(
    columns: 2, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Parameter],[Value],
    table.hline(),
    [割引係数$gamma$], [0.99],
    [学習率 $eta$], [$0.0003$],
    [エントロピー重み$alpha$], [0.0003],
    [バッチサイズ$n$], [64],
    [サンプリング周期], [10 ms],
    [エピソード数], [200],
    table.hline(),
  ),
  cap: "強化学習パラメータ",
  lab: <tab:rlparam>
)
$
  R = 10 exp(-0.5 e_d ^"  2")-9.8
$<exp:rf1>
#pb
= 結果
@img:reward に各減速度での報酬を示す。また@img:decel0.2 - 5 に各目標減速度での減速度波形を示す。30エピソード付近から基本的な制御はできるようになり、160エピソードあたりで良好な制御ができるようになってきている。目標値に幅を持たせたためか、過学習のような傾向は見られなかった。

しかし$k$の違いによる変化は特にみられなかった。次回はこの学習させたエージェントを用いて、目標減速度に幅を持たせた場合にどの程度追従できるのかを確認し、$k$の違いによる変化があるかを見る。
#imgN(("img/0.1/EpisodeReward.svg","img/0.2/EpisodeReward.svg","img/0.3/EpisodeReward.svg","img/0.4/EpisodeReward.svg"), ([(a) $k = 0.1$] ,[(b) $k = 0.2$],[(c) $k = 0.3$],[(d) $k = 0.4$]), cap:"各エピソードの減速度", lab:<img:reward>, w:8.5cm)

#imgN(("img/0.1/Agent10/Dflt.svg","img/0.1/Agent30/Dflt.svg","img/0.1/Agent60/Dflt.svg", "img/0.1/Agent110/Dflt.svg", "img/0.1/Agent160/Dflt.svg", "img/0.1/Agent200/Dflt.svg"), ([(a) Episode 10] ,[(b) Episode 30],[(c) Episode 60],[(c) Episode 110],[(c) Episode 160],[(c) Episode 200]), cap:[$k = 0.1$ での減速度], lab:<img:decel0.1>, w:8.5cm)

#imgN(("img/0.2/Agent10/Dflt.svg","img/0.2/Agent60/Dflt.svg","img/0.2/Agent100/Dflt.svg", "img/0.2/Agent120/Dflt.svg", "img/0.2/Agent160/Dflt.svg", "img/0.2/Agent200/Dflt.svg"), ([(a) Episode 10] ,[(b) Episode 30],[(c) Episode 60],[(c) Episode 110],[(c) Episode 140],[(c) Episode 200]), cap:[$k = 0.2$ での減速度], lab:<img:decel0.2>, w:8.5cm)
#pb
#imgN(("img/0.3/Agent10/Dflt.svg","img/0.3/Agent30/Dflt.svg","img/0.3/Agent60/Dflt.svg", "img/0.3/Agent110/Dflt.svg", "img/0.3/Agent160/Dflt.svg", "img/0.3/Agent200/Dflt.svg"), ([(a) Episode 10] ,[(b) Episode 30],[(c) Episode 60],[(c) Episode 110],[(c) Episode 160],[(c) Episode 200]), cap:[$k = 0.3$ での減速度], lab:<img:decel0.3>, w:8.5cm)
#imgN(("img/0.4/Agent10/Dflt.svg","img/0.4/Agent30/Dflt.svg","img/0.4/Agent60/Dflt.svg", "img/0.4/Agent110/Dflt.svg", "img/0.4/Agent160/Dflt.svg", "img/0.4/Agent200/Dflt.svg"), ([(a) Episode 10] ,[(b) Episode 30],[(c) Episode 60],[(c) Episode 110],[(c) Episode 160],[(c) Episode 200]), cap:[$k = 0.4$ での減速度], lab:<img:decel0.4>, w:8.5cm)