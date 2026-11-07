#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0" as conch: system, terminal-block
#import "@preview/pinit:0.2.2": *

#show: swat-doc.with(
  title: [Intro to Your Shell],
  authors: (
    author("Adrian Valcarcel-Schott", gh: "avalsch"),
    author("Brendan Moore", gh: "Mere-Solace"),
  ),
)

#let system = system.with(hostname: "ksu")

#let terminal-ansi = (
  black: rgb("#24292f"),
  red: rgb("#cf222e"),
  green: rgb("#116329"),
  yellow: rgb("#4d2d00"),
  blue: rgb("#0969da"),
  magenta: rgb("#8250df"),
  cyan: rgb("#1b7c83"),
  white: rgb("#6e7781"),
  bright-black: rgb("#57606a"),
  bright-red: rgb("#a40e26"),
  bright-green: rgb("#1a7f37"),
  bright-yellow: rgb("#633c01"),
  bright-blue: rgb("#218bff"),
  bright-magenta: rgb("#a475f9"),
  bright-cyan: rgb("#3192aa"),
  bright-white: rgb("#8c959f"),
)

#let terminal-theme = (
  title-fg: swat-colors.neutral-lightest,
  title-bg: swat-colors.secondary,

  cursor: rgb("#f6f8fa"),
  bg: rgb("#f6f8fa"),
  fg: rgb("#1f2328"),

  prompt-user: terminal-ansi.blue,
  prompt-path: terminal-ansi.magenta,
  prompt-sym: terminal-ansi.cyan,
  error: terminal-ansi.bright-red,
  ansi: terminal-ansi,
)

#let terminal(..args) = align(
  center,
  block(
    align(
      top + left,
      terminal-block(
        system: system(),
        user: "swat",
        font: (font: "Fira Mono", size: 1.4em),
        chrome: (title, t, f) => block(fill: t.title-bg, width: 100%, inset: 8pt, {
          align(center, text(..f, fill: t.title-fg)[Terminal --- #title])
        }),
        style: (inset: (top: -0.4em, rest: 0.8em)),
        theme: terminal-theme,
        ..args,
      ),
    ),
  ),
)

= Getting Started

== Installing a Shell

#cols(align: top)[
  #align(center)[*Windows*]

  #link("https://git-scm.com/install/windows")

  Select the latest *Git for Windows*.

  Follow the installer instructions.

  Open the Start Menu, search for *Git Bash*.

  // TODO(@avalsch): detailed git install instructions:
  // - git bash installer link (above)
  // - winget install Git.Git (alt)
  // - or use WSL for a full linux environment
][
  #align(center)[*Mac / Linux*]

  You should already have a shell installed out of the box.

  #side-by-side[/ Linux: `bash`][/ Mac: `zsh`]

  Open your terminal/console application.
]

== Many Shells

There are many shells available for you to choose from.

#pause

#v(1em)

#side-by-side(align: top)[
  #align(center)[*POSIX-Like*]

  / `bash`: // TODO

  / `zsh`: // TODO
][
  #align(center)[*Other*]

  / `fish`: friendly, interactive shell with slightly simpler syntax
  / `pwsh`: cross-platform shell often used on Windows
  / `nushell`: structured-data-focused shell
]


== Terminals

The *terminal* is the app or window; the *shell* is the program interpreting what you type.

#v(2em)
#pause

A terminal can run different shells, and a shell can run inside different terminal apps.

#v(2em)
#pause

// TODO: analogy
meaningful analogy here


= The Shell is an Interface

== A Simple Hello

A *shell* is an interface that allows access to OS functionality and other programs.

#v(2em)
#pause

#terminal[
  ```
  echo hello
  ```
]

== Command Anatomy

#align(center)[
  #show raw: set text(size: 2.8em)

  #pin(1)`ls `#pin(2)`-a`#pin(3)

  #context {
    pinit-point-from(
      (2, 1, 1),
      offset-dx: -20pt,
      body-dx: -std.measure([Command]).width,
    )[Command]
  }

  #pinit-point-from(
    (3, 2),
  )[Argument]
]

#v(4em)

#terminal(
  system: system(
    files: (:
      ..("foo.txt", "bar.py", "baz.typ").map(k => (k, "")).to-dict(),
    ),
  ),
  width: 100%,
)[
  ```
  ls

  ls -a
  ```
]

---

#align(center)[
  #set text(size: 1.5em)
  #show raw: set text(size: 1.4em)
  #show raw: it => {
    show regex("\d"): it => pin(eval(it.text.slice(0)))
    it
  }

  `1git2 3-c "John Doe"4 5commit6 7-m 'My message'8`

  #let pinit-highlight = pinit-highlight.with(dy: -1.4em, extended-height: 1.8em)

  #let label(it, color: black) = block(outset: 0.5em, stroke: 3pt + color, radius: 10pt, it)

  #context {
    let (width, height) = std.measure([command])

    pinit-highlight(1, 2, fill: black.transparentize(80%))

    pinit-point-from(
      (1, 2),
      pin-dy: -50pt,
      offset-dx: 5pt,
      offset-dy: -100pt,
      body-dx: -5pt,
      body-dy: -height - 15pt,
      label(color: black)[command],
    )
  }

  #context {
    let red = red.darken(20%)

    let (width, height) = std.measure([command argument])

    pinit-highlight(3, 4, fill: red.transparentize(80%).saturate(120%))

    pinit-point-from(
      (3, 4),
      offset-dx: 5pt,
      offset-dy: 60pt,
      body-dx: -width / 2,
      body-dy: 15pt,
      fill: red,
      label(color: red)[command argument],
    )
  }


  #context {
    let blue = blue.darken(20%)

    let (width, height) = std.measure([subcommand])

    pinit-highlight(5, 6, fill: blue.transparentize(80%).saturate(120%))

    pinit-point-from(
      (5, 6),
      pin-dy: -50pt,
      offset-dx: 5pt,
      offset-dy: -100pt,
      body-dx: -2 * width / 3,
      body-dy: -height - 15pt,
      fill: blue,
      label(color: blue)[subcommand],
    )
  }

  // #context {
  //   pinit-point-from(
  //     (2, 1, 1),
  //     offset-dx: -20pt,
  //     body-dx: -std.measure([Command]).width,
  //   )[Command]
  // }

  // #pinit-point-from(
  //   (3, 2),
  // )[Argument]
]


// motivation?
// simulate actual program execution
// explain command line args

= Standard Input, Output, & Error

// explain stdin/out/err

= Scripting

// interpolation/subshells
// variables
// control flow (conditionals, loops, functions)
// composability

= Advanced Features

// environment variables
// PATH
// signals
// unix permissions

= Tips & Best Practices

// tips (e.g., ctrl+R to search history)
// --help
// don't run `curl ... | sh`

= Helpful Resources

// tldr.sh
// cheat.sh (down?)
// man pages / help / info
