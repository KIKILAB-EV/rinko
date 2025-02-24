#import "bxbibwrite.typ": *
#import "@preview/metro:0.1.0": *

#let heading_font(body) = {
	set text(font: ("Times New Roman", "HGMinchoE"),size : 12pt)
	body
}

#let title_font(body) = {
	set text(font: ("Times New Roman", "HGMinchoE"), size:14pt) 
	body
}

#let title(date:datetime.today(), id : "電21-40", name : "荻野 健太") = {
	set align(center)
	set text(size:12pt)
	[電気機器研究室#h(0.5em)#date.display("[year]年度")#h(0.5em)輪講資料]
	parbreak()
	title_font([電気自動車班#h(0.5em)研究経過報告])
	set align(right)
	v(0em)
	let wd = date.display("[weekday]")
	if(wd == "Sunday"){
		wd = "日"
	}
	else if(wd == "Monday"){
		wd = "月"
	}
	else if(wd == "Tuesday"){
		wd = "火"
	}
	else if(wd == "Wednesday"){
		wd = "水"
	}
	else if(wd == "Thursday"){
		wd = "木"
	}
	else if(wd == "Friday"){
		wd = "金"
	}
	else if(wd == "Saturday"){
		wd = "土"
	}
	let data = date.display("[month padding:space]月[day padding:space]日")
	[#data (#wd)#h(1em)#id#h(0.5em)#name]
}

#let value(v,e:none,u:none) = {
	qty(v,u,e:e,per-mode: "symbol")
}

//改行
#let lb = {
	linebreak()
}

//新しい段落
#let br = {
	linebreak()
	h(1em)
}

//改ページ
#let np = {
	pagebreak()
}

//セクションはじめ
#let pr = {
	v(0.5em)
	h(1em)
}

#let img(path, cap:none, lab:none, w:auto, h:auto, bib:none, place:none) = {
	set align(center)
	let captioon = []
	if (cap != none){
		if(bib != none){
			captioon = [#std.h(0.5em)#cap#bib]
		}
		else{
			captioon = [#std.h(0.5em)#cap]
		}
	}

	v(1em)
	[
		#figure(
			image(path, width: w, height: h),
			caption: captioon,
			supplement: [図],
			numbering: "1",
			kind: "image",
			placement: place
		) 
		#if (lab != none) {
			lab	
		}
	]
	v(1em)

}

#let imgN(imgs, caps, cap, lab, w:auto, h:auto, bib:"", place:none) = {
	set align(center)
	let captioon = []
	if (cap != none){
		if(bib != none){
			captioon = [#std.h(0.5em)#cap#bib]
		}
		else{
			captioon = [#std.h(0.5em)#cap]
		}
	}
	let ary = array(())
	for i in range(imgs.len()) {
		if (i == imgs.len() -1 and calc.odd(imgs.len())){
			ary.push(grid.cell(colspan:2, grid(image(imgs.at(i), width: w), v(0.3em), caps.at(i), v(0.5em))))
		}
		else {
			ary.push(grid(image(imgs.at(i), width: w), v(0.3em), caps.at(i), v(0.5em)))
		}
	}
		v(1em)
		[
			#figure(
				grid(columns: 2, row-gutter: 5mm, column-gutter: 5mm,
					..ary.map((i) => i).flatten(),
					align: center+horizon,
				),
				caption: captioon,
				supplement: [図],
				numbering: image_num,
				kind: "image",
				placement: place
			) 
			#if (lab != none) {
				lab	
			}
		]
		v(1em)
	
}

#let tab(body, cap:none, lab:none, bib:none, place:none) = {
	let captioon = []
	if (cap != none){
		if(bib != none){
			captioon = [#std.h(0.5em)#cap#bib]
		}
		else{
			captioon = [#std.h(0.5em)#cap]
		}
	}
	v(1em)
	[#figure(
		body,
		caption: captioon,
		supplement: [表],
		numbering: "1",
		kind: "table",
		placement: place
	)
	#if (lab != none) {
		lab	
	}
	]
	v(1em)
}

#let thesis(
	bibliography-file: none,
	body,
) = {
	// citation number
	show ref: it => {
		let el = it.element
		if el == none{
			it
		}
		else {
			if el.func() == math.equation {
				link(el.location(),el.supplement + numbering(
				el.numbering,
				..counter(math.equation).at(el.location())
			))
			} else if el.func() == heading {
				let loc = el.location()
				let num = numbering(el.numbering, ..counter(heading).at(loc)).at(0)
				link(el.location(), "第" + str(num) + "節")
			} 
			else{
				it
			}
		}
	}
// 	#show figure.caption: it => [
//   #underline(it.body) |
//   #it.supplement
//   #context it.counter.display(it.numbering)
// ]
	// counting caption number
	show figure.where(
		kind: "table"
	): it => [
		#set figure.caption(position: top, separator: none)
		#it
	]
	show figure.where(
		kind: "image"
	): it => [
		#set figure.caption(position: bottom, separator: none)
		#it
	]
		//it.body
		//it
	
	// show figure: it => {
	// 	set align(center)
	// 	if it.kind == "image" {
	// 		set text(size: 12pt)
	// 		it.body
	// 		it.supplement
	// 		" " + it.counter.display(it.numbering)
	// 		if (it.caption != none){
	// 			"　" + it.caption.body
	// 		}
	// 	} 
	// 	// else if it.kind == "table" {
	// 	// 	set text(size: 12pt)
	// 	// 	it.supplement
	// 	// 	" " + it.counter.display(it.numbering)
	// 	// 	if (it.caption != none){
	// 	// 		"　" + it.caption.body
	// 	// 	}
	// 	// 	set text(size: 12pt)
	// 	// 	it.body
	// 	// } 
	// 	else {
	// 		//it
	// 	}
	//}

	set text(font: ("Times New Roman", "MS Mincho"), size:12pt, lang:"ja") 
	show label("bold"): set text(font: ("Times New Roman", "HGMinchoE"), size: 12pt)
	show label("boldL"): set text(font: ("Times New Roman", "HGMinchoE"), size: 14pt)

	// Configure the page properties.
	set page(paper:"a4", numbering: "1", margin: (top:30mm,bottom:35mm,x:30mm))

	counter(page).update(1)

	// Configure paragraph properties.
	//set par(first-line-indent: 1em, justify: true, leading: 0.8em)
	// Configure chapter headings.
	set heading(numbering: (..args) => {
		let nums = args.pos() // 引数の位置引数を`array`として取得
		let n = nums.at(2)
		if nums.len() == 1 { // 階層総数が1しかない、即ち最高階層
			return numbering("1. ", n)
		} else {
			return numbering("1. ", n)
		}
	}, level: 3)
	show heading: it => {
		heading_font(it)
		//
	}
	counter(page).update(1)

	set math.equation(supplement: [式], numbering: "(1)")
	//show math.equation: it => [#h(0.15em,weak:true) #it #h(0.15em,weak:true)]
	show: use-bib-item-ref.with(numbering: "(1)")

	body

	set heading(level: 1, numbering: none)
	show heading: it => {
		heading_font(it)
	}

	// Display bibliography.
	if bibliography-file != none {
		show bibliography: set text(12pt)
		bibliography(bibliography-file, title: "", style: "style.csl")
	}
}