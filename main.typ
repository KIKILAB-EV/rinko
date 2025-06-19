#import "./style.typ":*
#import "bxbibwrite.typ": *

#show: thesis.with(bibliography-file: none)

#title(date:datetime(year:2025,month:6,day:18), id:"電22-113", name: "中島　壮")

= はじめに
#pr
減速度制御において、回転数や回生電流値のサンプリング周波数はデータ精度に関係し、制御において重要な要素の一つである。また、現在の実験ではサンプリングと制御は同時に行っており、サンプリング周波数と制御周波数は同じである。そのため制御の応答性に直結する要素である。前回の輪講において、サンプリング周波数を高くするとノイズの影響を受けるという話があった。そのため、サンプリング周波数による影響を調べる。

= 実験結果
#pr
回生開始回転数$N$ = 1000 rpm, スイッチング周波数$f_"sw"$ = 500 Hzとし、サンプリング周波数$f_s$を500 Hzから3000 Hzまで変化させたときの回生開始時のトルク, 減速度, 回転数, デューティ比, 回生電流, 回生電圧の変化を示す。
#br
サンプリング周波数による制御への影響は特に見られなかった。そのため今後は引き続き$f_s$ = 2000 Hzで実験を行う。
#img("img/regeneration_circuit.svg", cap:"回生回路", lab:<regeneration_circuit>, w:80%)
#pagebreak()
#imgN(
    ("\img\Fs500\グラフ\Torque.svg","\img\Fs1000\グラフ\Torque.svg", "\img\Fs1500\グラフ\Torque.svg", "\img\Fs2000\グラフ\Torque.svg", "\img\Fs2500\グラフ\Torque.svg", "\img\Fs3000\グラフ\Torque.svg"),
    ([(a) $f_s = 500$ Hz], [(b) $f_s = 1000$ Hz], [(c) $f_s = 1500$ Hz], [(d) $f_s = 2000$ Hz], [(e) $f_s = 2500$ Hz], [(f) $f_s = 3000$ Hz]),
    cap:"トルク",
    lab:<torque>,
    w:95%
)

#imgN(
    ("\img\Fs500\グラフ\Deceleration.svg","\img\Fs1000\グラフ\Deceleration.svg", "\img\Fs1500\グラフ\Deceleration.svg", "\img\Fs2000\グラフ\Deceleration.svg", "\img\Fs2500\グラフ\Deceleration.svg", "\img\Fs3000\グラフ\Deceleration.svg"),
    ([(a) $f_s = 500$ Hz], [(b) $f_s = 1000$ Hz], [(c) $f_s = 1500$ Hz], [(d) $f_s = 2000$ Hz], [(e) $f_s = 2500$ Hz], [(f) $f_s = 3000$ Hz]),
    cap:"減速度",
    lab:<torque>,
    w:100%
)

#imgN(
    ("\img\Fs500\グラフ\N.svg","\img\Fs1000\グラフ\N.svg", "\img\Fs1500\グラフ\N.svg", "\img\Fs2000\グラフ\N.svg", "\img\Fs2500\グラフ\N.svg", "\img\Fs3000\グラフ\N.svg"),
    ([(a) $f_s = 500$ Hz], [(b) $f_s = 1000$ Hz], [(c) $f_s = 1500$ Hz], [(d) $f_s = 2000$ Hz], [(e) $f_s = 2500$ Hz], [(f) $f_s = 3000$ Hz]),
    cap:"回転数",
    lab:<torque>,
    w:100%
)

#imgN(
    ("\img\Fs500\グラフ\Duty.svg","\img\Fs1000\グラフ\Duty.svg", "\img\Fs1500\グラフ\Duty.svg", "\img\Fs2000\グラフ\Duty.svg", "\img\Fs2500\グラフ\Duty.svg", "\img\Fs3000\グラフ\Duty.svg"),
    ([(a) $f_s = 500$ Hz], [(b) $f_s = 1000$ Hz], [(c) $f_s = 1500$ Hz], [(d) $f_s = 2000$ Hz], [(e) $f_s = 2500$ Hz], [(f) $f_s = 3000$ Hz]),
    cap:"デューティ比",
    lab:<torque>,
    w:100%
)

#imgN(
    ("\img\Fs500\グラフ\Current.svg","\img\Fs1000\グラフ\Current.svg", "\img\Fs1500\グラフ\Current.svg", "\img\Fs2000\グラフ\Current.svg", "\img\Fs2500\グラフ\Current.svg", "\img\Fs3000\グラフ\Current.svg"),
    ([(a) $f_s = 500$ Hz], [(b) $f_s = 1000$ Hz], [(c) $f_s = 1500$ Hz], [(d) $f_s = 2000$ Hz], [(e) $f_s = 2500$ Hz], [(f) $f_s = 3000$ Hz]),
    cap:"回生電流",
    lab:<torque>,
    w:100%
)

#imgN(
    ("\img\Fs500\グラフ\Vedlc.svg","\img\Fs1000\グラフ\Vedlc.svg", "\img\Fs1500\グラフ\Vedlc.svg", "\img\Fs2000\グラフ\Vedlc.svg", "\img\Fs2500\グラフ\Vedlc.svg", "\img\Fs3000\グラフ\Vedlc.svg"),
    ([(a) $f_s = 500$ Hz], [(b) $f_s = 1000$ Hz], [(c) $f_s = 1500$ Hz], [(d) $f_s = 2000$ Hz], [(e) $f_s = 2500$ Hz], [(f) $f_s = 3000$ Hz]),
    cap:"充電電圧",
    lab:<torque>,
    w:100%
)