#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

//#title(date:datetime(year:2025,month:9,day:24),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:10,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
前回までの輪講において、発電電圧の波形を測定した際に大きなノイズが乗ってしまった。今回はこのノイズについて調査した。

= 測定結果
測定回路を@fig:circuit に示す。整流回路にモータからの3相を接続し、整流回路と回生回路を接続した場合と開放した場合の整流後波形$V_"rec"$と各相とGND間の波形をオシロスコープで観測した。

#img("img/circuit.svg", cap: "回生回路", lab: <fig:circuit>)

#imgN(("img/接続中整流後波形.jpg", "img/接続中相波形.jpg"), ("(a) 整流後波形", "(b) 相波形"), cap: "回生回路接続時の波形")

#imgN(("img/解放整流後波形.jpg", "img/解放相波形.jpg"), ("(a) 整流後波形", "(b) 相波形"), cap: "回生回路開放時の波形")