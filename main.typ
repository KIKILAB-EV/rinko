#import "./style.typ":*
#import "bxbibwrite.typ": *

#show: thesis.with()

#title(date:datetime(year:2025,month:4,day:1))

= はじめに <beg>
#pr
#set text(font: ("Times New Roman", "MS Mincho"), size:12pt, lang:"zh")//日付フォーマット(YYYY/MM/DD)のために中国語に変更
//#bibliography("./ref.bib", style: "輪講.csl", title:"参考文献")
//#include "reference.typ"