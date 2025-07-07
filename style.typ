#import "bxbibwrite.typ": *

#let roman_font = (name: "Times New Roman", covers: regex("[ -~]"))
#let bold_font = (name: "HGMinchoE", covers: regex("[^ -~]"))
#let normal_font = (name: "MS Mincho", covers: regex("[^ -~]"))

#let title(date:datetime.today(), id : "25M6302", name : "荻野 健太", year : 2025, content : "研究経過報告") = {
	
	let title_font(body) = {
		set text(font: (roman_font, bold_font), size:14pt) 
		body
	}
	set align(center)
	set text(size:12pt)
	block[電気機器研究室#h(0.5em)#year 年度#h(0.5em)輪講資料]
	v(0.5em)
	block(title_font([電気自動車班#h(0.5em)#content]))
	v(0.5em)
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
	block[#data (#wd)#h(1em)#id#h(1em)#name]
	v(0.5em)
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
#let pb = {
	pagebreak()
}

// 画像を配置する
//
// パラメータ:
// - path: 画像のパス
// - cap: 画像の説明
// - lab: 画像へのラベル
// - w: 画像の横幅 
// - h: 画像の高さ
// - bib: 参考文献
// - place: 画像の配置 
#let img(path, cap:none, lab:none, w:auto, h:auto, bib:none, place:none) = {
	set align(center)
	let captioon = []
	if (cap != none){
		captioon = [#std.h(0.5em)#cap]
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

// 画像を複数配置する
//
// パラメータ:
// - imgs: 画像のパスの配列
// - caps: 画像の説明の配列
// - cap: 説明
// - lab: 画像へのラベル
// - w: 画像の横幅 
// - h: 画像の高さ
// - bib: 参考文献
// - place: 画像の配置 
#let imgN(imgs, caps, cap:none, lab:none, w:auto, h:auto, bib:none, place:none,col : 2) = {
	set align(center)
	let captioon = []
	if (cap != none){
		captioon = [#std.h(0.5em)#cap]
	}
	let ary = array(())
	for i in range(imgs.len()) {
		if (i == imgs.len() -1 and calc.rem(imgs.len(),col)==1){
			ary.push(grid.cell(colspan:col, grid(image(imgs.at(i), width: w), v(0.3em), caps.at(i), v(0.5em))))
		}
		else {
			ary.push(grid(image(imgs.at(i), width: w), v(0.3em), caps.at(i), v(0.5em)))
		}
	}
		v(1em)
		[
			#figure(
				grid(columns: col, row-gutter: 5mm, column-gutter: 5mm,
					..ary.map((i) => i).flatten(),
					align: center+horizon,
				),
				caption: captioon,
				supplement: [図],
				numbering: "1",
				kind: "image",
				placement: place
			) 
			#if (lab != none) {
				lab	
			}
			#if (bib != none) {
				bib
			}
		]
		v(1em)
	
}

// 表を配置する
//
//  パラメータ:
//  - body: 表
//  - cap: 表の説明
//  - lab: 表へのラベル
// 	- bib: 参考文献
//  - place: 表の配置
#let tab(body, cap:none, lab:none, bib:none, place:none) = {
	let captioon = []
	if (cap != none){
		captioon = [#std.h(0.5em)#cap]
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
	#if (bib != none) {
		bib
	}
	]
	v(1em)
}

// スタイルの適用
// パラメータ
//  - bibliography-file: 参考文献ファイルのパス
#let thesis(
	bibliography-file: none,
	body,
) = {
	let leading = 0.8em
	let heading_font(body) = {
		set text(font: (roman_font, bold_font),size : 12pt)
		body
	}
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
	show figure.where(
		kind: "table"
	): it => {
		set figure.caption(position: top, separator: none)
		[#it.supplement#it.counter.display(it.numbering)#h(0.25em)#it.caption.body]
		it.body
	}
	show figure.where(
		kind: "image"
	): it => {
		it.body
		set figure.caption(position: top, separator: none)
		[#it.supplement#it.counter.display(it.numbering)#h(0.25em)#it.caption.body]
	}

	set text(font: (roman_font, normal_font), size:12pt, lang:"ja")
	
	show label("bold"): set text(font: (roman_font, bold_font), size: 12pt)
	show label("boldL"): set text(font: (roman_font, bold_font), size: 14pt)

	set page(paper:"a4", numbering: "1", margin: (top:30mm,bottom:35mm,x:30mm))

	counter(page).update(1)

	set heading(numbering: (..args) => {
		let nums = args.pos()
		let n = nums.at(2)
		if nums.len() == 1 { 
			return numbering("1. ", n)
		} else {
			return numbering("1. ", n)
		}
	}, level: 3)
	show heading: it => {
		heading_font(it)
		v(0.5em)
	}
	counter(page).update(1)

	set math.equation(supplement: [式], numbering: "(1)")
	
	show: use-bib-item-ref.with(numbering: "(1)")
	set par(justify: true, first-line-indent: (amount: 1.0em, all: true), leading: leading, spacing: leading)
	body

	set heading(level: 1, numbering: none)
	show heading: it => {
		heading_font(it)
	}

	if bibliography-file != none {
		show bibliography: set text(12pt)
		bibliography(bibliography-file, style: "輪講.csl", title:"参考文献")
	}
}