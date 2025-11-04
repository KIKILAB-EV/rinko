#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2025,month:10,day:29),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
前回に引き続き強化学習による制御をMATLAB/Simulinkで行った。今回はDDPGにおいて学習のパラメータを調整して再度学習させた。また目標の減速度を変更した際の影響について調査した。

= 環境の設定
@tab:rlparam に強化学習のパラメータを示す。赤字部分が前回からの変更部分である。また報酬関数を@exp:rf1 に示す。
#tab(
  table(
    columns: 2, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Parameter],[Value],
    table.hline(),
    [割引係数$gamma$], rt[0.99],
    [平滑化係数$tau$], rt[0.001],
    [探索ノイズ標準偏差$sigma$], rt[0.2],
    [最小探索ノイズ標準偏差$sigma_("min")$], rt[0.01],
    [探索ノイズ標準偏差減少率$sigma_("dec")$], rt[$10^(-5)$],
    [Actor学習率 $eta_("Actor")$], rt[$10^(-3)$],
    [Critic学習率 $eta_("Critic")$], rt[$10^(-4)$],
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
@img:reward にエピソード報酬の推移を示す。累計報酬が-170から-60程度の値をとっておりあまり安定していないが、100エピソード付近を境に上昇しているようにも見える。@img:decel に各エピソードの減速度を、@img:duty に出力デューティ比を示す。140エピソードから減速度が目標値に追従するようになっている。200エピソードでは目標値をやや下回るようになった。

#img("img/DDPG/EpisodeReward.svg", cap: "エピソード数と報酬の推移", lab:<img:reward>)
#imgN(("img/DDPG/Agent10/D.svg","img/DDPG/Agent100/D.svg","img/DDPG/Agent150/D.svg","img/DDPG/Agent180/D.svg","img/DDPG/Agent200/D.svg"), ("(a) Episode 10","(b) Episode 100","(c) Episode 150","(d) Episode 180","(e) Episode 200"), cap:"各エピソードの減速度", lab:<img:decel>, w:8.5cm)
#imgN(("img/DDPG/Agent10/Duty.svg","img/DDPG/Agent100/Duty.svg","img/DDPG/Agent150/Duty.svg","img/DDPG/Agent180/Duty.svg","img/DDPG/Agent200/Duty.svg"), ("(a) Episode 10","(b) Episode 100","(c) Episode 150","(d) Episode 180","(e) Episode 200"), cap:"各エピソードの出力デューティ比", lab:<img:duty>, w:8.5cm)

= 減速度変更
次にSACにおいて学習後同一のエージェントを用いて、最大減速度をもとの0.8, 1.0, 1.2倍にして制御を行った。なお学習パラメータは以前とは変更している。@tab:rlparamSAC に強化学習のパラメータを、@exp:rf2 に報酬関数を示す。また報酬関数の計算には減速度の値にLPFをかけたものを使用した。

@img:decel0.8 - 6 に各目標値での減速度を示す。100エピソード以降のエージェントであればいずれの減速度でもそれなりに目標値に追従している。しかし150 - 200エピソードでは目標値をやや上回るもしくは下回っている。100エピソード付近ではいずれの減速度においても目標値に追従している。120エピソード以降では過学習のような状態になっている可能性も考えられる。パラメータや報酬関数をさらに調整することでより安定したエージェントが得られると考えられる。また目標減速度を乱数によって若干変化させることでより汎用性の高いエージェントが得られる可能性もある。
#tab(
  table(
    columns: 2, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Parameter],[Value],
    table.hline(),
    [割引係数$gamma$], rt[0.99],
    [エントロピー重み$alpha$], rt[$3 times 10^(-4)$],
    [Actor学習率 $eta_("Actor")$], rt[$3 times 10^(-4)$],
    [Critic学習率 $eta_("Critic")$], rt[$3 times 10^(-4)$],
    [バッチサイズ$n$], [64],
    [サンプリング周期], [10 ms],
    [エピソード数], [200],
    table.hline(),
  ),
  cap: "強化学習パラメータ",
  lab: <tab:rlparamSAC>
)
$
  R = 10 exp(-1.5 e_d ^"  2")-9.8
$<exp:rf2>
#imgN(("img/SAC0.8/Agent10/Dflt.svg","img/SAC0.8/Agent100/Dflt.svg","img/SAC0.8/Agent120/Dflt.svg","img/SAC0.8/Agent150/Dflt.svg","img/SAC0.8/Agent200/Dflt.svg"), ("(a) Episode 10","(b) Episode 100","(c) Episode 120","(d) Episode 150","(e) Episode 200"), cap:"目標減速度0.8倍", lab:<img:decel0.8>, w:8.5cm)
#imgN(("img/SAC1.0/Agent10/Dflt.svg","img/SAC1.0/Agent100/Dflt.svg","img/SAC1.0/Agent120/Dflt.svg","img/SAC1.0/Agent150/Dflt.svg","img/SAC1.0/Agent200/Dflt.svg"), ("(a) Episode 10","(b) Episode 100","(c) Episode 120","(d) Episode 150","(e) Episode 200"), cap:"目標減速度1.0倍", lab:<img:decel1.0>, w:8.5cm)
#imgN(("img/SAC1.2/Agent10/Dflt.svg","img/SAC1.2/Agent100/Dflt.svg","img/SAC1.2/Agent120/Dflt.svg","img/SAC1.2/Agent150/Dflt.svg","img/SAC1.2/Agent200/Dflt.svg"), ("(a) Episode 10","(b) Episode 100","(c) Episode 120","(d) Episode 150","(e) Episode 200"), cap:"目標減速度1.2倍", lab:<img:decel1.2>, w:8.5cm)