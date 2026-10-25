#import "../swat-doc.typ": *

#import touying: *
#import theme: *

= Sample Deck: The Birthday Paradox

#let birthday-prob(n, days: 365) = {
  let no-match = 1.0
  for k in range(n) {
    no-match *= (days - k) / days
  }
  1 - no-match
}

== How many people for a shared birthday?

In a room of 23 people, what is the chance that *at least two* share a birthday?

#align(center + horizon)[
  #text(size: 1.6em, weight: "bold", fill: swat-colors.primary)[23 people]

  #pause

  #text(size: 1.6em, weight: "bold", fill: swat-colors.tertiary)[About 50%]
]

Assume 365 equally likely birthdays and ignore leap years.

== Count the easier event

It is easier to compute the chance that *nobody* shares a birthday.

#v(1em)

- First person: any day works → `365/365`

- Second: must avoid the first → `364/365`

- Third: must avoid two used days → `363/365`

#pause

Then subtract from 1:

$ P("collision") = 1 - product_(k=0)^(n-1) (365-k)/365 $

== The probability climbs quickly

#let chart-col(people) = {
  let probability = birthday-prob(people)

  let fill = if people == 23 { swat-colors.primary } else { swat-colors.tertiary }

  let bar = block(
    width: 80%,
    height: probability * 70%,
    fill: fill,
    inset: 0.5em,
    text(
      size: 0.8em,
      weight: 500,
    )[
      #calc.round(probability * 100)%
    ],
  )

  stack(
    dir: ttb,
    spacing: 0.35em,
    bar,
    text(size: 0.8em)[#people people],
  )
}

#figure(
  grid(
    align: bottom,
    columns: (1fr,) * 4,
    ..(10, 23, 30, 50).map(people => chart-col(people)),
  ),
  caption: [Collision probability, computed from the exact birthday model.],
  gap: 1.4em,
)

#figure(
  table(
    columns: (1fr,) * 3,
    align: center,
    stroke: none,
    inset: 0.7em,
    fill: (x, y) => if y == 0 { swat-colors.primary.lighten(95%) },
    table.header(
      [*People*], [*Chance of a match*], [*Intuition*],
      table.hline(),
    ),
    [10], [12%], [Unlikely],
    [23], [51%], [About even],
    [30], [71%], [Likely],
    [50], [97%], [Almost certain],
  ),
  caption: [The number of *pairs* grows much faster than the number of *people*.],
  gap: 2em,
)

== Why pairs change the odds

With 23 people, there are already 253 distinct pairs that could match:

#v(1em)

$ binom(23, 2) = (23 times 22) / 2 = 253 $

#v(1em)

Each pair is another opportunity for a collision.

We do not need 183 people to “fill half the calendar.”

== The same math appears in computing

A hash function maps many possible inputs into a fixed-size space of outputs.

#align(center)[
  #table(
    columns: 3,
    align: center,
    stroke: none,
    inset: 0.65em,
    table.header([*Input*], [*Hash slot*], [*Outcome*], table.hline()),
    [file A], [42], [first occupant],
    [file B], [42], [collision],
  )
]

For a space of *N* outputs, collisions become likely after roughly $sqrt(N)$ random inputs.

== Why use a long hash?

A 256-bit hash has $2^256$ possible outputs.

#v(1em)

#pause

The birthday bound puts the collision scale near $2^128$ inputs -- still enormous.

#v(1em)

#pause

The key idea is not “half the bins are full,” but “many pairs can match.”

#focus-slide[
  Count the pairs, not just the people.
]
