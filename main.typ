#import "./style.typ":*
#import "bxbibwrite.typ": *

#show: thesis.with()

#title(date:datetime(year:2025,month:4,day:20))

= はじめに <beg>
#pr

$3 times 2 = #value(5.2,u:"m/s^2")$

#img("VG.svg",cap:[$V_G$に関して],h:8cm, lab:<img:VG>,place:none)
#tab(table(columns: 3,
[a],[b],[c],
[1],[2],[3],
[4],[5],[6],
[7],[8],[9],
),cap:"aaa",lab:<tab:aaa>)
#tab(table(columns: 3,
[a],[b],[c],
[1],[2],[3],
[4],[5],[6],
[7],[8],[9],
),cap:"bbb",lab:<tab:bbb>)
@tab:aaa, @tab:bbb, @img:VG で
//#bibliography("./ref.bib", style: "./ieej.csl", title: "参考文献")