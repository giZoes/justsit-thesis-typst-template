#import "../resources/utils/datetime-display.typ": datetime-display
#import "style.typ": 字号, 字体
#import "../resources/utils/bilingual-bibliography.typ": bilingual-bibliography

// 本科生r任务书
#let bachelor-assignment(
  // documentclass 传入的参数
  anonymous: false,
  // anonymous: true,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-width: 72pt,
  column-gutter: -3pt,
  row-gutter: 18pt,
  anonymous-info-keys: ("grade", "student-id", "author", "supervisor", "supervisor-ii"),
  bold-info-keys: ("title",),
  bold-level: "semibold",
  datetime-display: datetime-display,
  
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: "基于 Typst 的苏理工学位论文",
    grade: "20XX",
    student-id: "218111545200",
    author: "张居正",
    department: "电气与信息工程学院",
    major: "软件工程",
    supervisor: ("某某", "教授"),
    sign-date: datetime(day: 17, month: 7, year: 2024),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表

  // 2.3 处理提交日期
  if type(info.sign-date) == datetime {
    info.sign-date = datetime-display(info.sign-date)
  }

  // 3.  内置辅助函数
  let info-key(body) = {
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(font: fonts.宋体, size: 字号.小三, body),
    )
  }

  let info-value(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: (bottom: stoke-width + black),
      text(
        font: fonts.宋体,
        size: 字号.小三,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let info-long-value(key, body) = {
    grid.cell(colspan: 3,
      info-value(
        key,
        if anonymous and (key in anonymous-info-keys) {
          "██████████"
        } else {
          body
        }
      )
    )
  }

  let info-short-value(key, body) = {
    info-value(
      key,
      if anonymous and (key in anonymous-info-keys) {
        "█████"
      } else {
        body
      }
    )
  }
  
  let info-title(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(
        font: fonts.宋体,
        size: 字号.小三,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }
  // 4.  正式渲染
  {
  pagebreak(weak: true, to: if twoside { "odd" })

  // 居中对齐
  set align(center)

  // 匿名化处理去掉封面标识
 if anonymous {
    v(8.2cm)
  } else {
    // 封面图标
    v(3cm)
    // 调整一下左边的间距
    text(size: 字号.小一, font: fonts.仿宋, spacing: 180%, weight: "bold")[江 苏 科 技 大 学 苏 州 理 工 学 院]
    v(3cm)
  }

  // 将中文之间的空格间隙从 0.25 em 调整到 0.5 em
  text(size: 字号.小初, font: fonts.宋体, spacing: 100%, weight: "bold")[毕业设计（论文）任务书]
  

    v(7cm)



  block(width: 100%, grid(
    columns: (info-key-width, 1fr, 18pt, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    info-key("学院名称："),
    info-short-value("department", info.department),[],
    info-key("专　　业："),
    info-short-value("major", info.major),
    info-key("学生姓名："),
    info-short-value("author", info.author),[],
    info-key("学　　号："),
    info-short-value("student-id", info.student-id),
    info-key("指导教师："),
    info-short-value("supervisor", info.supervisor.at(0)),[],
    info-key("职　　称："),
    info-short-value("supervisor", info.supervisor.at(1)),

  ))
  v(2cm)
  info-key(info.sign-date)
}

//表格部分

let table-stroke = 0.5pt
pagebreak(weak: true)

set text(size: 字号.小四, font: fonts.宋体)
table(
  columns: 1fr,
  stroke: table-stroke,
  inset: 10pt,
)[
  #text(size: 字号.小三, "毕业设计（论文）题目：")

  #info-title("title",info.title)
][
  一、毕业设计（论文）内容及要求（包括原始数据、技术要求、达到的指标和应做的实验等）
  #v(25em)
][
  二、完成后应交的作业（包括各种说明书、图纸等）

  #v(25em)
][
  四、主要参考资料（包括书刊名称、出版年月等）: 
  #show heading.where(level: 1):""
  //可以用新的bib
  #bilingual-bibliography(bibliography: bibliography.with("../ref.bib"), full: true)
][
  #v(1em)
  #set underline(offset: 0.2em)
  系(教研室)主任:#underline("　　　　　　　　")（签章）　　　　#info.sign-date
  #v(1em)
][
  #v(1em)
  #set underline(offset: 0.2em)
  分管教学院长：#underline("　　　　　　　　")（签章）　　　　#info.sign-date
  #v(1em)
]
}

#bachelor-assignment()
