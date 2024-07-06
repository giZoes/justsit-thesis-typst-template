#import "@preview/a2c-nums:0.0.1": int-to-cn-num, int-to-cn-ancient-num, int-to-cn-simple-num, num-to-cn-currency

// 显示中文日期
#let datetime-display(date) = {
  date.display("[year] 年 [month] 月 [day] 日")
}

// 显示英文日期
#let datetime-en-display(date) = {
  date.display("[month repr:short] [day], [year]")
}

// 显示汉字日期
#let datetime-cn-display(date) = {
  int-to-cn-simple-num(date.year())
  text[年]
  int-to-cn-simple-num(date.month())
  text[月]
}