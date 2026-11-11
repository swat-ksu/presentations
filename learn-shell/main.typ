#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0" as conch: system, terminal-block, terminal-frames
#import "@preview/pinit:0.2.2": *

#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#let fletcher-diagram = touying-reduce.with(fletcher)

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
  font: (font: "Fira Mono", size: 1em, weight: "regular"),
  chrome: (title, t, f) => block(fill: t.title-bg, width: 100%, inset: 8pt, {
    align(center, text(..f, fill: t.title-fg)[Terminal --- #title])
  }),
  theme: terminal-theme,
  show-cursor: false,
)

#let terminal-block = terminal-block.with(
  style: (inset: (top: -0.4em, rest: 0.8em)),
  ..term-config,
)

#let terminal-frames = terminal-frames.with(
  ..term-config,
)

#let term-center(it) = align(center, block(align(top + left, it)))

// kinda hacky, overrides conch's "bold" font weight to be
// a more reasonable "medium" so that bolded content doesn't
// look horribly large and out of place
#show text.where(weight: "bold"): set text(weight: "medium")


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

== A Simple Task

Suppose you have a folder of notes, and you want to find every line that mentions `TODO`.

#v(1em)
#pause

You could open files one by one, checking manually. Or, you could ask the computer:

#v(1em)
#pause

#term-center(terminal-block(
  system: system(
    files: (
      "ideas.txt": read("ex01/ideas.txt"),
      "meeting.txt": read("ex01/meeting.txt"),
      "project.txt": read("ex01/project.txt"),
    ),
  ),
  width: 95%,
)[
  ```bash
  grep TODO *.txt
  ```
])

#v(1em)
#pause

The shell lets you give instructions to your computer and showing you what they return.

#speaker-notes[
  - grep is a program that searches text.

  - the shell is not doing the search itself; it starts grep and passes it information.

  - don't explain `*.txt` yet. revisit it with arguments and shell syntax.
]

== Shell Interaction Flow

// TODO: make the diagram look prettier

#align(center)[
  #set text(size: 1.2em, weight: "medium")

  #fletcher-diagram(
    node-stroke: .2em,
    node-inset: 1em,
    node-corner-radius: 1em,
    edge-stroke: 0.1em,
    spacing: 8em,
    {
      node((0, 0))[You]
      edge("-|>")[`command`]
      node((1, 0))[Shell]
      edge("-|>")[`executes`]
      node((2, 0))[Program]
      edge((2, 0), (2, 0.6), (0, 0.6), (0, 0), "-|>")[`result`]
    },
  )
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
