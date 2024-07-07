#import "../utils/style.typ": 字号, 字体
#import "../utils/indent.typ": fake-par
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生中文摘要页
#let bachelor-abstract(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  display-header:true,
  keywords: (),
  outline-title: "中文摘要",
  outlined: false,
  anonymous-info-keys: ("author", "supervisor", "supervisor-ii"),
  leading: 1.28em,
  spacing: 1.28em,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info =  info


  // 4.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  set page(
    
    header: {
      grid(
        columns: (1fr), align: center,
        [#text(font: fonts.宋体, size: 字号.五号, baseline: -4pt)[江苏科技大学苏州理工学院毕业设计（论文）]],
        [#line(length: 100%, stroke: 0.5pt)]
      )
    }
  )
  
  [
    #set text(font: fonts.宋体, size: 字号.小四)
    #set par(leading: leading, justify: true)
    #show par: set block(spacing: spacing)

    // 标记一个不可见的标题用于目录生成
    // #invisible-heading(level: 1, outlined: outlined, outline-title)
    #align(center)[
      #set text(size: 字号.三号, font: 字体.黑体)
      = #text(weight: "medium")[摘　要]
      #v(1em)
    ]

    #[
      #set par(first-line-indent: 2em)

      #fake-par
      
      #body
    ]

    #v(1em)

    #text(font: 字体.黑体, weight: "medium")[关键词：]#(("",)+ keywords.intersperse("；")).sum()
  ]

}