#import "../template.typ": *

#import touying: *
#import theme: *

#import "util.typ": ilink

#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.10": codly-languages

#show: codly.theme("github-light")
#show: codly.lang-set_(
  languages: (
    // icon-only language display by overwriting the name with ""
    codly-languages.pairs().map(((lang, config)) => (lang, (..config, name: ""))).to-dict()
  ),
  fill: _ => none,
  stroke: _ => none,
)
#show raw.where(block: true): codly.new

#show: swat-doc.with(
  title: [Example / Documentation],
  subtitle: [How to use _The Template_],
  authors: author(
    "Adrian Valcarcel-Schott",
    gh: "avalsch",
  ),
)

= Getting Started

```typ
#import "../template.typ": *

#show: swat-doc.with(
  title: [My Presentation],
  authors: author("Your-Name Here")
)

= Getting Started

Write some content, you got this!

#pause

Believe in yourself!

```

= A Small Sample Deck

== A slide with a list

Metropolis keeps content slides clean and gives the title room to breathe.

- Use a short, descriptive slide title
- Keep each point focused on one idea
- Use *bold* text to make the key takeaway easy to scan

#pause

- Add detail progressively when presenting live

== Two-column layout

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    === The problem

    Important information is often spread across too many places.

    #v(0.5em)

    *Finding the signal takes time.*
  ],
  [
    === The approach

    Bring the relevant information together, then make the next step clear.

    #v(0.5em)

    *Make the useful action obvious.*
  ],
)

== A little data

#align(center)[
  #text(1.2em)[A simple relationship]

  #v(1em)

  $ y = beta_0 + beta_1 x + epsilon $

  #v(1em)

  #table(
    columns: 3,
    align: center,
    fill: (x, y) => if y == 0 { swat-colors.primary.lighten(95%) },
    stroke: none,
    inset: 0.4em,
    table.header([*Group*], [*Before*], [*After*]),
    table.hline(),
    [A], [42], [68],
    [B], [37], [59],
    [C], [51], [74],
  )
]

== Displaying code

This example template also loads Codly, so you get prettier code.

```typ
#let greet(name) = [Hello, #name!]

// fun fact, these are all programming languages too!
#for person in ("Ada", "Julia", "Alice") {
  greet(person)
}
```

You can use lots of languages! For example, Python and Assembly

```py
name = input('What is your name?\n')
print (f'Hi, {name}.')
```

#v(0.6em)

```asm
mov rax, 60    ; sys_exit
mov rdi, 0     ; exit code 0 (success)
syscall
```

== One key takeaway

#align(center + horizon)[
  #utils.fit-to-width[*Good slides make the main idea unmistakable.*]

  #v(1em)

  Start with the message. Add only the detail that helps your audience act on it.
]

= Useful Components

== Outline slide

The Metropolis theme provides an outline slide that picks up the presentation's headings. It can be placed wherever an agenda or recap is useful.

#outline-slide(title: [Today's Outline], level: 1, numbered: (false,))

== Focus slide

#focus-slide[
  A high-impact message for a transition or key result.
]

== Explicit slide

Most slides here are made from `==` headings. The lower-level `slide` function is useful when you want explicit control of the title or layout.

#codly.new(
  ```typ
  #slide(title: [== Created with `#slide`], composer: (1fr, 1fr))[
    Left-hand content.
  ][
    Right-hand content.
  ]
  ```,
)

#slide(title: [== Created with `#slide`], composer: (1fr, 1fr))[
  Left-hand content.
][
  Right-hand content.
]

== Slide layout components

#cols(columns: (1fr, 1fr), gutter: 1.5em)[
  *`cols`*

  A Touying wrapper for arranging slide content in columns.
][
  *`side-by-side`*

  An alias for `cols`, handy when comparing two things.
]

== Adaptive columns and alignment

/ Adaptive columns: lays out content in columns that adapt to the available space.

#v(0.4em)

#components.adaptive-columns(components.progressive-outline(title: none))

*Left and right*

#components.left-and-right([Label on the left], [A value on the right])

== More reveal patterns

Touying has more reveal controls than `#pause`:

- #uncover("2-")[`uncover`: reveal from step 2]
- #only("1")[`only`: show only on step 1]
- #alternatives[First alternative][Second alternative]

#v(1em)

#item-by-item[
  - `item-by-item` reveals these lines in sequence.

  - A second item appears on the next step.
]

#meanwhile

This appears on the parallel reveal track after the prior items.

== Speaker notes

Notes are hidden from the audience's slide and can be displayed in a presenter view when notes output is enabled.

#speaker-note[
  Example note: pause here, ask for questions, then move on to the demo.
]

== Article-only content

Touying can export this presentation as an article with `--input export=article`. Content marked `article-only` is intended for the article output rather than the slide deck.

#article-only[
  This paragraph is supplemental article text. It will not appear in normal slide export.
]

== Using an appendix

The appendix helper marks the following material as appendix content.

#v(2em)

Slide numbering is frozen there.

#v(2em)

See the #link(<appendix>, underline[*Appendix*#sym.arrow.tr]) section for an example.

= References

There are many great references that can help you when you're making your own Typst documents.

#appendix[
  = Appendix <appendix>

  This is an example appendix slide, included to show the `appendix` helper.

  #v(1.5em)

  #lorem(42)

  #v(1.5em)

  #lorem(4)
]
