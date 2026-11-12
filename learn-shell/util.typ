#import "@preview/pinit:0.2.2": *


#let _display-pinit-label(i, label) = context {
  let (pin1, pin2) = (2 * i, 2 * i + 1)
  let (color, pos, dx, dy, fill, body) = label

  assert(pos in (top, bottom), message: "`pos` must be `top` or `bottom`")

  let pinit-highlight = pinit-highlight.with(
    dx: -0.2em,
    dy: -1.4em,
    extended-height: 1.8em,
    extended-width: 0.3em,
  )

  let fill = if fill != none { fill } else { color.transparentize(80%) }

  let (width, height) = measure(body)

  let pinit-top = (
    pin-dy: -1.8em,
    offset-dy: -2.6em - 2em * dy,
    body-dy: -height - 0.4em,
  )

  let pinit-bot = (
    pin-dy: 0.8em,
    offset-dy: 1.6em + 2em * dy,
    body-dy: height - 0.26em,
  )

  pinit-highlight(
    pin1,
    pin2,
    fill: fill,
  )

  let args = if pos == top { pinit-top } else { pinit-bot }

  pinit-point-from(
    (pin1, pin2),
    ..args,
    body-dx: (dx * width - width) / 2,
    pin-dx: 0em,
    offset-dx: 0em,
    fill: color,
    block(
      outset: 0.4em,
      stroke: 0.1em + color,
      radius: 0.4em,
      body,
    ),
  )
}


#let command-diagram(
  pieces,
  piece-spacing: 1,
  text-size: 1.2em,
  raw-text-size: 1.1em,
  ..labels,
) = align(center, {
  set text(size: text-size)

  // this is a hacky way of doing it, but manually interpersing
  // the pins didn't display correctly, so here we are :/
  show raw: it => {
    set text(size: raw-text-size)
    show regex("\[\d*\]"): it => pin(eval(it.text.slice(1, -1)))
    it
  }

  let brace(it) = "[" + str(it) + "]"

  let pieces = pieces
    .enumerate()
    .map(((i, p)) => (2 * i, p.text))
    .map(((i, p)) => brace(i) + p + brace(i + 1))
    .join(" " * piece-spacing)

  raw(pieces)

  for (i, label) in labels.pos().enumerate() {
    _display-pinit-label(i, label)
  }
})


#let pinit-label(
  color,
  pos,
  dx: 0%,
  dy: 0%,
  fill: none,
  body,
) = (
  color: color,
  pos: pos,
  dx: dx,
  dy: dy,
  fill: fill,
  body: body,
)


#let terms-right-align(terms) = block(
  inset: (x: 2em),
  grid(
    columns: (auto, 1fr),
    row-gutter: terms.spacing,
    column-gutter: 0.6em,
    ..terms
      .children
      .map(item => (
        grid.cell(align: right, item.term),
        item.description,
      ))
      .flatten(),
  ),
)


#let encode-ansi(..segments) = {
  let esc = "\u{001b}["

  let ansi-codes = (
    blue: "34",
    magenta: "35",
    cyan: "36",
    bright-red: "91",
  )

  let to-ansi(seg) = {
    let styles = seg.at("styles", default: ())
    if type(styles) != array { styles = (styles,) }

    esc + styles.map(s => ansi-codes.at(s)).join(";") + "m" + seg.text + esc + "0m"
  }

  segments.map(seg => if type(seg) == str { (text: seg) } else { seg }).map(to-ansi).pos().join("")
}

