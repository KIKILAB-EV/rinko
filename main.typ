#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2026,month:1,day:7),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
今回はDDPGおよびTD3を用いて、目標値を乱数で変化させ幅を持たせて学習させた。

= 学習パラメータ
@tab:rlparam にDDPGとTD3の学習のパラメータを、報酬関数を@exp:rf1 に示す。また最大減速度に$k=$0, 0.1, 0.2, 0.3, 0.4とし、最大減速度$D_"max" times (1±k)$の乱数を掛けた値を目標減速度とした。なお乱数生成は一様分布で行った。

各$k$で学習させたエージェントに対し最大減速度に$k'=0.6 ~ 1.4$を掛けた値を目標減速度の最大値となるよう設定した。ただし$k'=0.6$では初期の減速度を下回るため、最大減速度を初期の減速度と同じ値に設定した。
#tab(
  table(
    columns: 2,
    column-gutter: 1em,
    [(a) DDPG],[(b) TD3],
    stroke:none,
    table(
    columns: 2, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Parameter],[Value],
    table.hline(),
    [割引係数$gamma$], [0.99],
    [Actor学習率], [$0.001$],
    [Critic学習率], [$0.0001$],
    [バッチサイズ], [64],    
    [平滑モデル標準偏差],[0.2],
    [標準偏差減少率],[$10^(-5)$],
    [サンプリング周期], [10 ms],
    [エピソード数], [200],
    table.hline(),
  ),
  table(
    columns: 2, column-gutter: 1em,
    stroke:none,
    table.hline(),
    [Parameter],[Value],
    table.hline(),
    [割引係数], [0.99],
    [Actor学習率], [$0.001$],
    [Critic学習率], [$0.0001$],
    [バッチサイズ], [100],
    [平滑モデル標準偏差],[0.2],
    [標準偏差減少率],[0],
    [サンプリング周期], [10 ms],
    [エピソード数], [200],
    table.hline(),
  )
  ),
  cap: "強化学習パラメータ",
  lab: <tab:rlparam>
)
$
  R = 10 exp(-0.5 e_d ^"  2")-9.8
$<exp:rf1>

// #pb
= 結果
#let ep = 200
@img:Dk0 - 5にDDPGの，@img:Tk0 - 10にTD3エピソード数#ep の各$k$で学習させたエージェントの、各$k'$に対するグラフを示す。

エピソード数にもよるが、いずれにおいても$k=0.2,0.3$で良好な追従性を見せた。しかし$k=0.1,0.4$では$k=0$に比べてもあまり追従しなかった。なおSACを使用したときは$k=0.4$が最も追従性がよかった。

#let eg_k = 0
#let type = "DDPG"
#let name = "Dflt"
#let im(t, a, k) = {
  return "img/"+t+"/"+str(a)+"/"+str(k)+"/"+str(ep)+"/"+name+".png"
}
#pb
#let eg_k = 0

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Dk0>, w:8.5cm)
#pb
#let eg_k = 0.1
#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Dk0.1>, w:8.5cm)
#pb
#let eg_k = 0.2

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Dk0.2>, w:8.5cm)
#pb
#let eg_k = 0.3

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Dk0.3>, w:8.5cm)
#pb
#let eg_k = 0.4

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Dk0.4>, w:8.5cm)
#pb
#let type = "TD3"
#let eg_k = 0

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Tk0>, w:8.5cm)
#pb
#let eg_k=0.1

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Tk0.1>, w:8.5cm)
#pb
#let eg_k = 0.2

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Tk0.2>, w:8.5cm)
#pb
#let eg_k = 0.3

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Tk0.3>, w:8.5cm)
#pb
#let eg_k = 0.4

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Tk0.4>, w:8.5cm)