#import "../utils/style.typ": 字号, 字体
#import "../../others/bachelor-assignment.typ":bachelor-assignment

// 本科生声明页
#let bachelor-decl-page(
  // need-assignment: false,
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
) = {
  // 0. 如果需要匿名则短路返回
  if anonymous {
    return
  }

  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("基于 Typst 的", "苏理工学位论文"),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }


  // 3.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  v(48pt)




  align(
    center,
    text(
      font: fonts.宋体,
      size: 字号.小二,
      weight: "semibold",
      "江苏科技大学苏州理工学院学位论文原创性声明",
    ),
  )

  v(32pt)

  block[
    #set text(font: fonts.宋体, size: 字号.四号)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 1.28em)

    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。
  ]

  v(100pt)

  grid(
    columns: (100pt, 260pt),
    [],
    align(left)[
      #set text(font: fonts.宋体, size: 字号.四号, )
      
      学位论文作者签名（手签）

      #v(1cm)

      　　　　　　　　　　年　　月　　日
    ]
  )

//使用授权书
  pagebreak(weak: true, to: if twoside { "odd" })

  v(52pt)




  align(
    center,
    text(
      font: fonts.宋体,
      size: 字号.小二,
      weight: "semibold",
      "江苏科技大学苏州理工学院学位论文版权使用授权书",
    ),
  )

  v(32pt)

  block[
    #set text(font: fonts.宋体, size: 字号.四号)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 1.28em)

    本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权江苏科技大学可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。
  ]

  v(32pt)

  block[
    #set text(font: fonts.宋体, size: 字号.四号)
    #set par(justify: true, first-line-indent:  (amount: 2em, all: true), leading: 1.28em)

    本学位论文属于： 
    
    1、保密 □，在#h(3em)年解密后适用本授权书。

    2、不保密 □ 。

  ]

  v(7cm)

  grid(
    columns: (50fr,50fr),
    align(center)[
      #set text(font: fonts.宋体, size: 字号.四号, )
      
      学位论文作者签名（手签）:

      #v(1cm)

      年　　月　　日
    ],
    align(center)[
      #set text(font: fonts.宋体, size: 字号.四号, )
      
      指导教师签名（手签）:

      #v(1cm)

      年　　月　　日
    ]
  )

//任务书
pagebreak(weak: true, to: if twoside { "odd" })
// if need-assignment {
//   bachelor-assignment()
// }else{
  text(font: fonts.宋体, size: 字号.四号, fill: red,)[#align(center)[任务书添加至此处]]
// }



}