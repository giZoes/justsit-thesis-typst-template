#import "@preview/i-figured:0.2.4"
#import "../utils/style.typ": 字号, 字体
#import "../utils/custom-numbering.typ": custom-numbering
#import "../utils/custom-heading.typ": heading-display, active-heading, current-heading
#import "../utils/unpairs.typ": unpairs
#import "@preview/numbly:0.1.0": numbly

#let mainmatter(
  // documentclass 传入参数
  twoside: false,
  fonts: (:),
  // 其他参数
  leading: 1.5 * 15.6pt - 0.7em,
  spacing: 1.5 * 15.6pt - 0.7em,
  justify: true,
  first-line-indent: (amount: 2em, all: true),
  numbering: custom-numbering.with(first-level: "第一章 ", depth: 4, "1.1 "),
  // 正文字体与字号参数
  text-args: auto,
  // 标题字体与字号
  heading-font: auto,
  heading-size: (字号.小三, 字号.四号, 字号.小四, 字号.小四,),
  heading-weight: ("medium",),
  heading-above: (2 * 15.6pt - 0.7em, 2 * 15.6pt - 0.7em),
  heading-below: (2 * 15.6pt - 0.7em, 1.5 * 15.6pt - 0.7em),
  heading-pagebreak: (true, false),
  heading-align: (center, auto),
  // 页眉
  header-render: auto,
  header-vspace: 0em,
  display-header: true,
  skip-on-first-level: true,
  stroke-width: 0.5pt,
  reset-footnote: true,
  // caption 的 separator
  separator: "  ",
  // caption 样式
  caption-style: strong,
  caption-size: 字号.五号,
  // figure 计数
  show-figure: i-figured.show-figure.with(numbering: "1-1"),
  // equation 计数
  show-equation: i-figured.show-equation.with(numbering: "(1-1)"),
  ..args,
  it,
) = {
  // 0.  标志前言结束
  set page(numbering: "1")

  // 1.  默认参数
  fonts = 字体 + fonts
  if (text-args == auto) {
    text-args = (font: fonts.宋体, size: 字号.小四)
  }
  // 1.1 字体与字号
  if (heading-font == auto) {
    heading-font = (fonts.黑体,)
  }
  // 1.2 处理 heading- 开头的其他参数
  let heading-text-args-lists = args.named().pairs()
    .filter((pair) => pair.at(0).starts-with("heading-"))
    .map((pair) => (pair.at(0).slice("heading-".len()), pair.at(1)))

  // 2.  辅助函数
  let array-at(arr, pos) = {
    arr.at(calc.min(pos, arr.len()) - 1)
  }

  // 3.  设置基本样式
  // 3.1 文本和段落样式
  set text(..text-args)
  set par(
    leading: leading,
    justify: justify,
    first-line-indent: first-line-indent,
    spacing: spacing
  )
  show raw: set text(font: fonts.等宽)
  // 3.2 脚注样式
  show footnote.entry: set text(font: fonts.宋体, size: 字号.五号)
  // 3.3 设置 figure 的编号
  show heading: i-figured.reset-counters
  show figure: show-figure
  // 3.4 设置 equation 的编号和假段落首行缩进
  show math.equation.where(block: true): show-equation
  // 3.5 表格表头置顶 + 不用冒号用空格分割 + 样式
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  set figure.caption(separator: separator)
  show figure.caption: caption-style
  show figure.caption: set text(font: fonts.宋体, size: 字号.五号, weight: "extralight")
  // 3.6 优化列表显示
  //     术语列表 terms 不应该缩进
  show terms: set par(first-line-indent: 0pt)
  //3.7 有序列表
  set enum(numbering: numbly("{1})", "({2})","{3}."), full: true)

  // 4.  处理标题
  // 4.1 设置标题的 Numbering
  set heading(numbering: numbering)
  // 4.2 设置字体字号并加入假段落模拟首行缩进

  show heading: it => {
  //需要特殊处理的标题

    set text(
      font: array-at(heading-font, it.level),
      size: array-at(heading-size, it.level),
      weight: array-at(heading-weight, it.level),
      ..unpairs(heading-text-args-lists
        .map((pair) => (pair.at(0), array-at(pair.at(1), it.level))))
    )
    set block(
      above: array-at(heading-above, it.level),
      below: array-at(heading-below, it.level),
    )
    it
  }
  // 4.3 标题居中与自动换页
  show heading: it => {
    if (array-at(heading-pagebreak, it.level)) {
      // 如果打上了 no-auto-pagebreak 标签，则不自动换页
      if ("label" not in it.fields() or str(it.label) != "no-auto-pagebreak") {
        pagebreak(weak: true)
      }
    }
    if (array-at(heading-align, it.level) != auto) {
      set align(array-at(heading-align, it.level))
      it
    } else {
      it
    }
  }

  // 5.  处理页眉
  set page(..(if display-header {
    (
      header: {
        // 重置 footnote 计数器
        if reset-footnote {
          counter(footnote).update(0)
        }
        grid(
          columns: (1fr), align: center,
          [#text(font: fonts.宋体, size: 字号.五号, baseline: -4pt)[江苏科技大学苏州理工学院毕业设计（论文）]],
          [#line(length: 100%, stroke: 0.5pt)]
        )
      }
    )
  } else {
    (
      header: {
        // 重置 footnote 计数器
        if reset-footnote {
          counter(footnote).update(0)
        }
      }
    )
  }))

  counter(page).update(1)

  it
}