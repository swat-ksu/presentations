#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0" as conch: system, terminal-block, terminal-frames
#import "@preview/pinit:0.2.2": *

#import "util.typ": pinit-label

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

  bg: swat-colors.neutral-lightest.darken(5%),
  fg: rgb("#1f2328"),

  prompt-user: terminal-ansi.blue,
  prompt-path: terminal-ansi.magenta,
  prompt-sym: terminal-ansi.cyan,
  error: terminal-ansi.bright-red,
  ansi: terminal-ansi,
)

#let term-config = (
  system: system(),
  user: "swat",
  font: (font: "Fira Mono", size: 1.4em),
  chrome: (title, t, f) => block(fill: t.title-bg, width: 100%, inset: 8pt, {
    align(center, text(..f, fill: t.title-fg)[Terminal --- #title])
  }),
  style: (inset: (top: -0.4em, rest: 0.8em)),
  theme: terminal-theme,
  show-cursor: false,
)

#let terminal-block = terminal-block.with(..term-config)

#let terminal-frames = terminal-frames.with(
  ..term-config,
  style: (inset: (rest: 0.8em)),
)

#let term-center(it) = align(center, block(align(top + left, it)))


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

#term-center(terminal-block[
  ```bash
  echo hello world!
  ```
])

---

#let frames = terminal-frames(
  commands: ("ls", "ls -a", "pwd", ""),
  height: 400pt,
)

#slide(
  repeat: frames.len(),
  self => term-center(frames.at(self.subslide - 1)),
)

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

#term-center(terminal-block(
  system: system(
    files: (:
      ..("foo.txt", "bar.py", "baz.typ").map(k => (k, "")).to-dict(),
    ),
  ),
  width: 100%,
)[
  ```bash
  ls

  ls -a
  ```
])

---

#align(center)[
  #set text(size: 1.2em)

  #show raw: it => {
    set text(size: 2.2em)
    show regex("\[\d*\]"): it => pin(eval(it.text.slice(1, -1)))
    it
  }

  `[1]git[2] [5]commit[6] [7]-a[8] [9]-m 'My message'[0]`

  #pinit-label(swat-colors.secondary, (1, 2), top, dx: 70%)[command]

  #pinit-label(swat-colors.tertiary, (5, 6), bottom, dx: -40%)[subcommand]

  #pinit-label(
    swat-colors.primary-light,
    (7, 8),
    bottom,
    dx: 100%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[subcommand flag]

  #pinit-label(
    swat-colors.primary,
    (9, 0),
    top,
    dx: -30%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[subcommand flag (with argument)]
]

---

#term-center(terminal-block(
  system: system(
    files: (
      "foo.txt": (content: "", mode: 644),
      "bar.py": (content: "", mode: 644),
      "baz.sh": (
        content: ```bash
        #!/usr/bin/bash

        echo "Hello, World"
        ```.text,
        mode: 755,
      ),
    ),
  ),
  font: (font: "Fira Mono", size: 1em),
  width: 100%,
)[
  ```bash
  ls

  ls -a

  ls -lah

  ./baz.sh

  ls /

  pwd
  ```
])

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
