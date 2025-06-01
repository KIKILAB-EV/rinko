#import "./style.typ":*
#import "bxbibwrite.typ": *

#show: thesis.with()

#title(date:datetime(year:2025,month:6,day:4))

= はじめに <beg>
#pr
@fig:equipment に実験装置の写真を示す。
#imgN(("image.png", "image-1.png"), ("昨年度の実験装置", "今年度の実験装置"), "実験装置の比較", <fig:equipment>)


= マイコンの変更
#pr
昨年度までは、実験の際にスイッチングの制御を行うマイコンとしてArduino Uno R3を使用していた。また減速度やデューティ比等の実験データの測定の際にはArduinoからPWM信号でアナログ値として出力し、フィルタを通してメモリーハイコーダへ入力し測定および記録をしていた。この方法ではデューティ比などの内部生成のデータでさえ正確に記録することは難しい。そのため、ArduinoからUSBを通じてシリアル通信を用いてPCへデータを送信し、PC側でデータを記録することを検討した。しかし、Uno R3ではクロック速度が16 MHzでは足りず、設定していたサンプリング周波数でサンプリングできず制御もできていなかった。
#br
そこで使用するマイコンをUno R3からRaspberry Pi Pico2に変更した。Picoはクロック周波数が150 MHzと高い。そのためシリアル通信を行っても十分な余裕をもってサンプリングおよび制御が可能である。
//#set text(font: ("Times New Roman", "MS Mincho"), size:12pt, lang:"zh")//日付フォーマット(YYYY/MM/DD)のために中国語に変更

//#bibliography("./ref.bib", style: "輪講.csl", title:"参考文献")
//#include "reference.typ"