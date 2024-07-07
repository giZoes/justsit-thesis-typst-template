#import "style.typ": 字体, 字号

#let table-stroke = 0.5pt
#let indent = h(2em)
#let proposal ={
// set page(numbering: "1")
// counter.(page).update(0)
align(center, text(
  font: 字体.宋体,
  size: 字号.小三,
  weight: "bold",
  "江苏科技大学苏州理工学院毕业设计（论文）中期检查表"
))

set text(font: 字体.宋体, size: 字号.五号)
set par(first-line-indent: 2em)
// #set underline(offset: 0.1em)


{
  set text(size: 字号.五号)
  table(
    columns: (58pt, 1fr, 58pt, 1fr, 58pt, 1fr),
    stroke: table-stroke,
    rows: 1.5cm,
    align: center + horizon,
    //标题部分
    [学生姓名], 
    [张居正], 
    [学号], 
    [218111545200], 
    [指导教师], 
    [某某], 
    table.cell(colspan: 2)[毕业设计(论文)题目], 
    table.cell(colspan: 4)[量子力学下的代码质量与代码进化论],
  )
}

v(-1.2em)

table(
  columns: (60pt,1fr),
  stroke: table-stroke,
  inset: 10pt,
  rows: auto,
  align: (center+horizon,left),

)[
  #v(10pt)
  毕业设计的主要工作内容和计划进度(由学生填写)
  #v(10pt)
][
  #v(15em)
][
  #v(10pt)
  目前已完成工作情况(由学生填写)
  #v(10pt)
][
  #v(10em)
][
  #v(10pt)
  存在的主要问题和解决方案(由学生填写)
  #v(10pt)
][
  #v(25em)
]

v(-1.2em)

table(
  columns: (190pt,1fr),
  stroke: table-stroke,
  inset: 10pt,
  rows: auto,
  align: (center+horizon,),

)[
  #v(10pt)
  指导教师对学生工作态度评价
  #v(10pt)
][
   #sym.ballot.x 认真　　
   #sym.ballot 较认真　　
   #sym.ballot 一般　　
   #sym.ballot 差 
][
  #v(10pt)
  指导教师对学生完成工作质量评价
  #v(10pt)
][
  #sym.ballot 优　　
  #sym.ballot.x 良　　
  #sym.ballot 中　　
  #sym.ballot 一般　　
  #sym.ballot 差
]

v(-1.2em)

table(
  columns: (60pt,1fr),
  stroke: table-stroke,
  inset: 10pt,
  rows: auto,
  align: (center+horizon,left),

)[
  #v(10pt)
  指导教师意见和建议
  #v(10pt)
][
  还行
  #set align(right+bottom)
  #v(1em)
  指导教师签名： #h(7em)

  #v(0.5em)

  　　　　年　　月　　日
]}


#proposal