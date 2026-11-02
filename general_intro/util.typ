#import "../swat-doc.typ": swat-colors

#let flow(..steps) = {
  let items = steps.pos()
  set text(
    0.8em,
    fill: swat-colors.secondary,
  )
  grid(
    columns: (1fr,) * items.len(),
    column-gutter: 0.7em,
    align: horizon,
    ..items.map(s => block(
      width: 103%,
      inset: 12pt,
      radius: 3pt,
      fill: swat-colors.neutral-dark.lighten(90%),
      stroke: 0.6pt + swat-colors.neutral-darkest.lighten(40%),
      align(center, strong(s)),
    )),
  )
}