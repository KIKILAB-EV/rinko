#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

//#title(date:datetime(year:2025,month:9,day:24),id:"電21-065", name:"木村 駿太")
#title(date:datetime(year:2025,month:10,day:1),id:"電22-113", name:"中島 壮")
//#title(date:datetime(year:2025,month:9,day:17))


= 概要
前回までの輪講において、平滑コンデンサを挿入した際の発電電圧の波形を測定した際に大きなノイズが乗ってしまった。今回はこのノイズについて調査した。

= 測定結果
測定回路を@fig:circuit に示す。整流回路にモータからの3相を接続し、整流回路と回生回路を接続した場合と開放した場合の整流後波形$V_"rec"$と各相とGND間の波形をオシロスコープで観測した。

@fig:connected に回生回路接続時の波形、@fig:disconnected に回生回路開放時の波形を示す。回生回路接続時には整流後波形に大きなノイズが乗っていることがわかる。@fig:wav に接続時と開放時の整流後波形の比較を示す。接続後の波形はpeak-to-peak電圧が3V程度低下しやや波形もなまっている。これは回生回路に含まれるインダクタによるものと考えられる。

#img("img/circuit.svg", cap: "回生回路", lab: <fig:circuit>)

#imgN(("img/接続中整流後波形.jpg", "img/接続中相波形.jpg"), ("(a) 整流後波形", "(b) 相波形"), cap: "回生回路接続時の波形", lab: <fig:connected>)

#imgN(("img/解放整流後波形.jpg", "img/解放相波形.jpg"), ("(a) 整流後波形", "(b) 相波形"), cap: "回生回路開放時の波形", lab: <fig:disconnected>)

#imgN(("img/wav.svg", "img/FFT.svg"), ("(a) 整流後波形", "(b) FFT解析結果"), cap: "整流後波形の比較", lab: <fig:wav>, w:7cm)

#pb
次に回生回路を切り離した状態で、PMSMのアース端子と回生回路のGNDを抵抗で接続した場合の波形を@fig:grounded に示す。1kΩの抵抗を接続した場合、まではノイズが大きく減少したが、10kΩ以上はやや減少したもののノイズがみられた。また1kΩ以下では第3高調波以降の成分は大きく減少している。
#img("img/circuit_EG.svg", cap: "アースとGNDの接続", lab: <fig:circuit_EG>)
#imgN(("img/R/wav.svg", "img/R/FFT.svg"), ("(a) 整流後波形", "(b) FFT解析結果"), cap: "PMSMのアース端子と回生回路のGNDを抵抗で接続した場合の波形", lab: <fig:grounded>)

= 今後の予定
アースとGNDの間に1kΩ程度の抵抗入れた状態で減速度制御を実施する。また平滑コンデンサを挿入した際の実験を再度行う。