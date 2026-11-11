#import "@preview/pinit:0.2.2": *

#let pinit-label(
  color,
  (pin1, pin2),
  pos,
  dx: 0%,
  dy: 0%,
  fill: none,
  body,
) = context {
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

