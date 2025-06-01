#import "./style.typ":*
#import "bxbibwrite.typ": *

#show: thesis.with()

#title(date:datetime(year:2025,month:6,day:4))

= はじめに <beg>
#pr
#imgN(("image.png", "image-1.png"), ("昨年度の実験装置", "今年度の実験装置"), "実験装置の比較", <fig:equipment>)

//#set text(font: ("Times New Roman", "MS Mincho"), size:12pt, lang:"zh")//日付フォーマット(YYYY/MM/DD)のために中国語に変更

//#bibliography("./ref.bib", style: "輪講.csl", title:"参考文献")
//#include "reference.typ"