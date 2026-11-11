#import "../swat-doc.typ": swat-colors

#let flow(..steps) = {
  let items = steps.pos()
  set text(
    1.2em,
  )
  grid(
    columns: (1fr,) * items.len(),
    column-gutter: 0.7em,
    align: horizon,
    ..items.map(s => block(
      height: 25%,
      width: 103%,
      inset: 12pt,
      radius: 3pt,
      fill: swat-colors.neutral-dark.lighten(90%),
      stroke: 0.6pt + swat-colors.neutral-darkest.lighten(40%),
      align(center, s),
    )),
  )
}
