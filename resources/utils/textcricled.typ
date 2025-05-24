#let onum(num) = {
  set text(size: 0.625em)
  h(-4em)
  num = str(num)
  box(
    circle(
      radius: 0.5em,
      stroke: 0.5pt,
      inset: 0pt,
      outset: 1pt,
      move(
        dx: 1pt - 1.5pt * (num.len() - 1),
        dy: 0.1pt,
        num,
      ),
    ),
  )
  [　]
}
