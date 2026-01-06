#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2026,month:1,day:7),id:"電21-065", name:"木村 駿太")
//#title(date:datetime(year:2025,month:4,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
今回はDDPGおよびTD3を用いて、目標値を乱数で変化させ幅を持たせて学習させた。

= 学習パラメータ
@tab:rlparam に前回行った学習のパラメータを、報酬関数を@exp:rf1 に示す。また最大減速度に$k=$0, 0.1, 0.2, 0.3, 0.4とし、最大減速度$D_"max" times (1±k)$の乱数を掛けた値を目標減速度とした。なお乱数生成は一様分布で行った。
#tab(
  table(
    columns: 2,
    [(a) DDPG],[(b) TD3],
    stroke:none,
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
  )
  ),
  cap: "強化学習パラメータ",
  lab: <tab:rlparam>
)
$
  R = 10 exp(-0.5 e_d ^"  2")-9.8
$<exp:rf1>
= 検証設定
各$k$で学習させたエージェントに対し最大減速度に$k'=0.6 ~ 1.4$を掛けた値を目標減速度の最大値となるよう設定した。ただし$k'=0.6$では初期の減速度を下回るため、最大減速度を初期の減速度と同じ値に設定した。
#pb
= 結果
#let ep = 200
@img:Dk0 - 4にエピソード数#ep の各$k$で学習させたエージェントの、各$k'$に対するグラフを示す。

いずれにおいても、最大減速度が低いほど目標への追従性は高い傾向にある。一方で、最大減速度が高い場合は目標への追従性が低下する傾向にあり1.4倍では追従する前に減速度が低下している。出力デューティ比はほぼ1であるため、今回使用しているモデルではもとの最大減速度より高い減速度を維持しながら回生を行うのは困難であると考えられる。

また使用したエージェントのエピソード数にもよるが、$k$が大きいほど幅広い目標減速度に対して追従性が高い傾向にある。これは学習時に幅広い目標減速度に対して学習しているため、各目標減速度に対する出力が適切に学習されているためと考えられる。元の最大減速度での追従性も若干ではあるが向上しているようにも見える。

= 今後の予定
今回の結果から、学習時に目標減速度に幅を持たせることで、幅広い目標減速度に対して追従性を向上させることができると考えられる。そのため最大減速度に$0.6~1.4$倍程度の幅を持たせて学習を行い、パラメータや報酬の調整を行う。また初期回転数を変化させるなども検討する。

#let eg_k = 0
#let type = "DDPG"
#let name = "D"
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

#imgN((im(type, eg_k, 0.6),im(type, eg_k, 0.8),im(type, eg_k, 1.0), im(type, eg_k, 1.2), im(type, eg_k, 1.4)), ([(a) $k'=0.6$] ,[(b) $k'=0.8$],[(c) $k'=1.0$],[(e) $k'=1.2$],[(f) $k'=1.4$]), cap:[#type, $k = #eg_k$ 学習のエージェントの減速度], lab:<img:Tk0.2>, w:8.5cm)
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