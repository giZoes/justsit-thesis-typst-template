#import "../utils/datetime-display.typ": datetime-cn-display
#import "../utils/style.typ": 字号, 字体
#import "@preview/a2c-nums:0.0.1": int-to-cn-num, int-to-cn-ancient-num, int-to-cn-simple-num, num-to-cn-currency

// 本科生封面
#let bachelor-titlepage(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 1,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-font: "宋体",
  info-value-font: "黑体",
  column-gutter: -3pt,
  row-gutter: 11.5pt,
  anonymous-info-keys: ("grade", "student-id", "author", "supervisor", "supervisor-ii"),
  bold-info-keys: ("title",),
  bold-level: "regular",
  datetime-cn-display: datetime-cn-display,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: "基于 Typst 的学位论文",
    title-en: "NJU Thesis Template for Typst",
    grade: "20XX",
    student-id: "218111545233",
    author: "张三",
    department: "某学院",
    major: "某专业",
    supervisor: ("李四", "教授"),
    submit-date: datetime.today(),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  // if type(info.title) == str {
  //   info.title = info.title.split("\n")
  // }
  // // 2.2 根据 min-title-lines 填充标题
  // info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")
  // 2.3 处理提交日期
  if type(info.submit-date) == datetime {
    info.submit-date = datetime-cn-display(info.submit-date)
  }

  // 3.  内置辅助函数
  let info-key(body) = {
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(
        font: fonts.at(info-key-font, default: "楷体"),
        size: 字号.四号,
        body
      ),
    )
  }

  let info-value(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(
        font: fonts.at("宋体"),
        size: 字号.四号,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let info-title(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(
        font: fonts.at("黑体"),
        size: 字号.二号,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }
  
  let info-long-value(key, body) = {
    grid.cell(colspan: 1,
      info-value(
        key,
        if anonymous and (key in anonymous-info-keys) {
          "██████"
        } else {
          body
        }
      )
    )
  }

  // 4.  正式渲染
  
  pagebreak(weak: true, to: if twoside { "odd" })

  // 居中对齐
  set align(center)

  if anonymous {
    v(155pt)
  } else {
  text(size: 字号.四号, font: fonts.宋体,)[江苏科技大学苏州理工学院本科毕业论文]
  v(5cm)
  }

  info-title("title",info.title)
  v(1cm)
  text(font: fonts.宋体, size: 16pt, info.title-en)
  
  v(4cm)

  block(width: 4.5cm, grid(
    columns: (auto, auto),
    column-gutter: column-gutter,
    row-gutter: 1cm,
    info-key("学生姓名："),
    info-long-value("author",info.author),
    info-key("指导教师："),
    info-long-value("supervisor", info.supervisor.at(0))
  ))
  
  if anonymous {
    v(5cm)
  } else {
    v(2.5cm)
    text(size: 字号.四号, font: fonts.宋体,)[江苏科技大学苏州理工学院]
  }

  v(0.5cm)
  info-value("submit-date",info.submit-date)
}