#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2026,month:11,day:18), id : "電23-109", name : "鶴田 寛大")

= はじめに
今回は、前回までに評価した昇降圧コンバータを用いて強化学習による減速度制御を行った。

= 実験方法
図@fig:circuit に回生回路図を示す。
モータを1300 rpmまで加速させ、1000 rpmから回生制御を開始し停止するまでを1エピソードとし、強化学習を行った。
学習は100エピソード行い、10エピソードごとに評価実行を3回行った。
強化学習のパラメータを表@tbl:parameter に示す。
また、スイッチング周波数は50 kHzとした。
#img("img/regeneration_circuit.pdf", cap:"回生回路図", lab: <fig:circuit>, w:86%,)
#tab(table(
	align:left,
	columns: (16em,6em),
	stroke:none,
	table.hline(),
	[Parameter], [Value],
	table.hline(),
	[Optimizer],[Adam],
	[Discount factor], [0.99],
	[Actor/Critic learning rate], [$3.0 times 10^(-4)$],
	[Alpha learning rate], [$3.0 times 10^(-4)$],
	[Batch size], [64],
	[Nonlinearity $(alpha)$], [ReLU],
	[Initial temperture cofficient $(tau)$], [0.001],
	[Number of hidden units per layer], [64],
	[Number of hidden layers], [3],
	table.hline()
),lab: <tbl:parameter>, cap:"強化学習のパラメータ")

#pb
エージェントが観測する状態は減速度、目標減速度、減速度誤差、推定トルク、目標トルク、トルク誤差、回生電流、デューティ比、回転数、PIDゲインの12次元であり、すべて0–1に正規化して観測する。
エージェントの出力する行動はPIDゲインの3次元であり、0–1で出力する。その後各ゲインの最小値と最大値の間に変換して使用する。最小値と最大値は[0, 0, 0], [0.1, 0.1, 0.1]とした。

= 結果
図@fig:episode_rewards にエピソード報酬の推移を、図@fig:result_ep10–@fig:result_ep100 に10, 30, 70, 100エピソード目の評価実行の各種波形を示す。
いずれも3回目の評価実行時の結果である。

30エピソード目あたりで評価実行の報酬値が安定した。また3回の実行の分散も落ち着いた。

各種波形については、エピソードが進むにつれてトルクの追従性は向上していったが、ジャーク区間終了直後の部分については70エピソード目が最も追従性が良く、100エピソード目では追従性が悪化していた。
またいずれのエピソードにおいても、ジャーク区間の箇所において減速度の大きな変動があるが、推定トルクには表れていない。
そのため、ジャーク区間はトルクの制御はできているが、減速度の制御はできていない可能性がある。

= 今後の予定
今回は制御目標を制動トルクに設定して制御を行っていたため、減速度を制御目標に戻した際の挙動を確認する。

また、電流を測定するADコンバータの入力部分に平滑用のコンデンサを入れてあり電流が遅れているため、取り除いて学習を行い減速度の制御性能が向上するかを確認する。

#let image_result(run:"Run3", ep:10, width:auto, height:auto, lab) = {
	let name = "img/" + run + "/EvalEp" + str(ep)
	imgN((name+"/deceleration.pdf", name+"/torque.pdf", name+"/errors.pdf", name+"/current_0_to_2_A.pdf", name+"/duty_cycle.pdf", name+"/pid_gains.pdf", name+"/rotation_speed.pdf"), ("(a) 減速度","(b) トルク","(c) 誤差","(d) 回生電流","(e) デューティー比","(f) PIDゲイン", "(g) 回転速度"), cap:str(ep) + "エピソード目", lab:lab, w:width, h:height)
}

#img("img/episode_rewards.pdf", cap:"エピソード報酬の推移", lab: <fig:episode_rewards>, w:9cm)
#image_result(run:"Run3", ep:10, width:6.5cm, <fig:result_ep10>)
#image_result(run:"Run3", ep:30, width:6.5cm, <fig:result_ep30>)
#image_result(run:"Run3", ep:70, width:6.5cm, <fig:result_ep70>)
#image_result(run:"Run3", ep:100, width:6.5cm, <fig:result_ep100>)