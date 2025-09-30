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

@fig:connected に回生回路接続時の波形、@fig:disconnected に回生回路開放時の波形を示す。回生回路接続時には整流後波形に大きなノイズが乗っていることがわかる。@fig:wav に接続時と開放時の整流後波形の比較を示す。接続後の波形はpeak-to-peak電圧が3V程度低下しやや波形もなまっている。これは回生回路に含まれるインダクタによるものと考えられる。

#img("img/circuit.svg", cap: "回生回路", lab: <fig:circuit>)

#imgN(("img/接続中整流後波形.jpg", "img/接続中相波形.jpg"), ("(a) 整流後波形", "(b) 相波形"), cap: "回生回路接続時の波形", lab: <fig:connected>)

#imgN(("img/解放整流後波形.jpg", "img/解放相波形.jpg"), ("(a) 整流後波形", "(b) 相波形"), cap: "回生回路開放時の波形", lab: <fig:disconnected>)

#img("img/wav.svg", cap: "整流後波形の比較", lab: <fig:wav>, w:12cm)

= 参考資料
#img("img/FFT.svg", cap: "FFT解析結果", lab: <fig:FFT>, w:12cm)