#import "bxbibwrite.typ": *
#import "@preview/metro:0.1.0": *

#let heading_font(body) = {
	set text(font: ("Times New Roman", "HGMinchoE"))
	body
}

#let title_font(body) = {
  set text(font: ("Times New Roman", "HGMinchoE"), size:14pt) 
	body
}

#let title(MM, DD, ddd) = {
	set align(center)
	set text(size:12pt)
	"電気機器研究室　2024年度　輪講資料"
	parbreak()
  title_font("電気自動車班　研究経過報告")
	set align(right)
	v(0em)
	MM + "月" + DD + "日（" + ddd + "）"
	"　電21-40　荻野　健太"
}

//改行
#let lb() = {
	linebreak()
}

//新しい段落
#let br() = {
	linebreak()
	h(1em)
}

//改ページ
#let np() = {
	pagebreak()
}

//セクションはじめ
#let pr() = {
	v(0.5em)
	h(1em)
}

#let img(path, cap, lab, w:15cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	[
		
		#v(1em)
		#figure(
			image(path, width: w),
			caption: cap,
			supplement: [図],
			kind: "image",
		) 
		#label(lab)
		
		#v(1em)
	]
}

#let imgh(path, cap, lab, h:15cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	[
		
		#v(1em)
		#figure(
			image(path, height: h),
			caption: cap,
			supplement: [図],
			kind: "image",
		) 
		#label(lab)
		
		#v(1em)
	]
}

#let imgN(imgs, caps, cap, lab, w:7cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
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
	[
		#v(1em)
		#figure(
			grid(columns: 2, row-gutter: 5mm, column-gutter: 5mm,
				..ary.map((i) => i).flatten(),
				align: center+horizon,
			),
			caption: cap,
			supplement: [図],
			kind: "image",		) 
		#label(lab)
		#v(1em)
	]
}

#let vimgN(imgs, caps, cap, lab, w:7cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	let ary = array(())
	for i in range(imgs.len()) {
		if (i == imgs.len() -1 and calc.odd(imgs.len())){
			ary.push(grid.cell(colspan:2, grid(image(imgs.at(i), width: w), v(0.5em), caps.at(i), v(0.8em))))
		}
		else {
			ary.push(grid(image(imgs.at(i), width: w), v(0.5em), caps.at(i), v(0.8em)))
		}
	}
	[
		#v(1em)
		#figure(
			grid(columns: 1, row-gutter: 5mm, column-gutter: 5mm,
				..ary.map((i) => i).flatten(),
				align: center+horizon,
			),
			caption: cap,
			supplement: [図],
			kind: "image",		) 
		#label(lab)
		#v(1em)
	]
}

#let img2h(img1, img2, cap1, cap2, cap, lab, h:7cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	[
		//#image_num.step()
		#v(1em)
		#figure(
			grid(columns: 2, row-gutter: 2mm, column-gutter: 1mm,
				image(img1, height: h),
				image(img2, height: h),
				cap1,
				cap2,
				align: center,
			),
			caption: cap,
			supplement: [図],
			kind: "image",
		) 
		#label(lab)
		#v(1em)
	]
}

#let vimg2(img1, img2, cap1, cap2, cap, lab, w:14cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	[
		#v(1em)
		#figure(
			grid(rows: 2, row-gutter: 2mm, column-gutter: 1mm,
				image(img1, width: w),
				cap1,
				v(1em),
				image(img2, width: w),
				cap2,
				align: center,
			),
			caption: cap,
			supplement: [図],
			kind: "image",
		)
		#label(lab)
		#v(1em)
	]
}

#let vimg3(img1, img2, img3, cap1, cap2, cap3, cap, lab, w:7cm, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	[
		#v(1em)
		#figure(
			grid(rows: 2, row-gutter: 2mm, column-gutter: 1mm,
				image(img1, width: w),
				cap1,
				v(1em),
				image(img2, width: w),
				cap2,
				v(1em),
				image(img3, width: w),
				cap3,
				v(1em),
				align: center,
			),
			caption: cap,
			supplement: [図],
			kind: "image",
		)
		#label(lab)
		#v(1em)
	]
}

#let tab(body, cap, lab, bib:"") = {
	set align(center)
	if(bib != ""){
		cap = cap + ref((label(bib)))
	}
	[
		#v(1em)
		#figure(
			body,
			caption: cap,
			supplement: [表],
			kind: "table"
		) #label(lab)
		#v(1em)
	]
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
  // counting caption number
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      "　" + it.caption.body
    } else if it.kind == "table" {
      set text(size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      "　" + it.caption.body
      set text(size: 12pt)
      it.body
    } else {
      it
    }
  }

  set text(font: ("Times New Roman", "MS Mincho"), size:12pt, lang:"ja") 
	show label("bold"): set text(font: ("Times New Roman", "HGMinchoE"), size: 12pt)

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

  set math.equation(numbering: "(1)", supplement: "式")
	//show math.equation: it => [#h(0.15em,weak:true) #it #h(0.15em,weak:true)]
	show: use-bib-item-ref.with(numbering: "(1)")

  body

  // Display bibliography.
  if bibliography-file != none {
    show bibliography: set text(12pt)
    bibliography(bibliography-file, title: "", style: "style.csl")
  }
}