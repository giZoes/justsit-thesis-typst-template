#import "../utils/datetime-display.typ": datetime-cn-display
#import "../utils/style.typ": 字号, 字体

// 本科生封面
#let bachelor-cover(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 1,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-width: 72pt,
  info-key-font: "黑体",
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

  let info-value1(key, body) = {
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

  let info-value(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: (bottom: stoke-width + black),
      text(
        font: fonts.at(info-value-font, default: "宋体"),
        size: 字号.四号,
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
  

  // 4.  正式渲染
  
  pagebreak(weak: true, to: if twoside { "odd" })

  // 居中对齐
  set align(center)

  // 匿名化处理去掉封面标识
  if anonymous {
    v(7.5cm)
  } else {
    // 封面图标
    v(3cm)
    // 调整一下左边的间距
    text(size: 字号.小一, font: fonts.仿宋, spacing: 180%, weight: "bold")[江 苏 科 技 大 学 苏 州 理 工 学 院]
    v(3cm)
  }

  // 将中文之间的空格间隙从 0.25 em 调整到 0.5 em
  text(size: 字号.小初, font: fonts.宋体, spacing: 180%, weight: "bold")[本 科 毕 业 设 计（论文）]
  
  if anonymous {
    v(4cm)
  } else {
    v(4cm)
  }

  block(width: 9.5cm, grid(
    columns: (info-key-width, 1fr, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    info-key("学　　院"),
    info-long-value("department", info.department),
    info-key("专　　业"),
    info-long-value("major", info.major),
    info-key("学生姓名"),
    info-long-value("author", info.author),
    info-key("班级学号"),
    info-long-value("student-id", info.student-id),
    info-key("指导教师"),
    info-long-value("supervisor", info.supervisor.at(0)),
  ))

  v(2.5cm)

  info-value1("submit-date",info.submit-date)
}