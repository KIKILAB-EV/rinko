#import "./style.typ":*
#import "./unit.typ"

#show: thesis.with()

#title(date:datetime(year:2025,month:4,day:1))

= はじめに
#img("img/regeneration_circuit.pdf", cap:"回生回路図", lab: <fig:circuit>, w:90%)

#pb

#let image_result(run:"Run3", ep:10, width:auto, height:auto, lab) = {
	let name = "img/" + run + "/EvalEp" + str(ep)
	imgN((name+"/deceleration.pdf", name+"/torque.pdf", name+"/errors.pdf", name+"/current_0_to_2_A.pdf", name+"/duty_cycle.pdf", name+"/pid_gains.pdf", name+"/rotation_speed.pdf"), ("(a) 減速度","(b) トルク","(c) 誤差","(d) 回生電流","(e) デューティー比","(f) PIDゲイン", "(g) 回転速度"), cap:"エピソード" + str(ep) + "の結果", lab:lab, w:width, h:height)
}

#image_result(run:"Run3", ep:10, width:6.5cm, <fig:result_ep10>)
#image_result(run:"Run3", ep:70, width:6.5cm, <fig:result_ep70>)
#image_result(run:"Run3", ep:100, width:6.5cm, <fig:result_ep100>)