#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with(bibliography-file: "ref.bib")

// #title(date:datetime(year:2025,month:9,day:17),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
#title(date:datetime(year:2025,month:9,day:17))


= 概要
現在PI制御による減速度制御を行っているが、回転数や各素子パラメータの変更、環境の変化に対して柔軟な対応は難しい。そのため、機械学習により減速度制御を行うことを提案する。

= 機械学習のアルゴリズム
機械学習には大きく分けて教師あり学習、教師なし学習、強化学習の3つのカテゴリがある。教師あり学習は、入力と出力のペアを学習し、未知の入力に対して適切な出力を予測する。教師なし学習は、データの構造を理解するために使用され、クラスタリングや次元削減などが含まれる。強化学習は、エージェントが環境と相互作用しながら報酬を最大化するための戦略を学ぶ。今回の内容では、強化学習を用いる。@table:algorithms に強化学習のアルゴリズムを示す。Actor-Criticは、Actorが方策に基づき行動を選択しCriticが行動によって環境から状態や報酬を観測および評価をし、これを基にActorが方策を更新する@用語。本研究では行動空間が連続でOff-policyであり、Actor-Criticの改良版に当たるDDPG(Deep Deterministic Policy Gradient)やTD3(Twin Delayed DDPG), SAC(Soft Actor-Critic)を用いる比較する予定である。
#lb
#tab(
table(
  columns: (1fr,1fr,1fr),
  stroke:none,
  align: center+horizon,
  [],[On-Policy エージェント],[],
  table.hline(),
  [エージェント],[タイプ],[行動空間],
  table.hline(),
  [SARSA],[Value-base],[離散],
  [Policy Gradient],[Policy-base],[離散/連続],
  [Actor-Critic],[actor-critic],[離散/連続],
  [TRPO],[actor-critic],[離散/連続],
  [PPO],[actor-critic],[離散/連続],
  table.hline(),
  [],[],[],
  [],[Off-policy エージェント],[],
  table.hline(),
  [エージェント],[タイプ],[行動空間],
  table.hline(),
  [Q Learning],[Value-base],[離散],
  [LSPI], [Value-base],[離散],
  [Deep Q Network(DQN)],[Value-base],[離散],
  [DDPG], [actor-critic],[連続],
  [TD3], [actor-critic],[連続],
  [SAC], [actor-critic],[離散/連続/ ハイブリッド],
  [MBPO], [model-based],[離散/連続],
  table.hline()

),
cap:"強化学習のアルゴリズム一覧",
place:bottom,
lab: <table:algorithms>,
bib: ref(<MATLAB>)
)
#img("img/RL_exp.png", w: 80%, cap: "強化学習の概念図", bib: ref(<東芝論文>), lab:<RL_exp>)
#img("img/AC_exp.png", w: 60%, cap: "Actor-Criticの概念図", bib: ref(<RLIntro>), lab:<AC_exp>)
= 学習の構成
学習に用いる環境の構成を@env に示す。スイッチング素子は簡単のため理想スイッチとする。シミュレーション上での学習にはSimulinkのReinforcement Learning Toolboxを用いる。Actorはスイッチング素子のPWM入力のデューティ比を出力し、Criticには現在の環境（回転速度や減速度, 電流, デューティ比など）を入力する。報酬には目標減速度と実際の減速度の誤差を変数としたガウス関数を用いる。

#img("img/env.svg", w: 80%, cap: "学習に用いる環境の構成", lab:<env>)