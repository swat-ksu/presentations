#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0" as conch: system, terminal-block, terminal-frame, terminal-frames
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

#show raw.where(block: false): set text(size: 1.2em)

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

#let terminal-frame(..args, body) = terminal-frames(
  style: (inset: (top: -0.4em, rest: 0.8em)),
  commands: (body.text.trim(),),
  ..args,
).first()

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
  grep -n TODO ideas.txt meeting.txt project.txt
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

== What Actually Happens?

The shell starts a program called `grep`, which finds the matching lines

#v(2em)
#pause

But the command we typed (`grep TODO *.txt`) has several pieces.

#v(2em)
#pause

What parts did the shell interpret, and which parts did `grep` recieve?


= Command Anatomy

== The Program Receives Arguments

#term-center(
  terminal-frame(
    width: 95%,
    ```bash
      grep TODO ideas.txt project.txt
    ```,
  ),
)

#v(1em)
#pause

The shell starts `grep` and gives it these arguments:

- `TODO`
- `ideas.txt`
- `project.txt`

#v(1em)
#pause

Then, `grep` gets to decides what those strings mean.

In this case, "search for `TODO` in `ideas.txt` and `project.txt`."

== Common Argument Conventions

Programs often follow similar conventions when assigning meaning to their arguments.


#v(1em)
#pause

For example, `grep` uses `-n` as an option:

#term-center(terminal-frame(
  width: 95%,
  ```bash
  grep -n TODO ideas.txt
  ```,
))

#v(1em)
#pause

`grep` receives the arguments: #h(1em) `["-n", "TODO", "ideas.txt"]`


#v(1em)
#pause

#[
  `grep` interprets them as:

  #set terms(indent: 3em)

  / `-n`: an _option_ -- include line numbers.

  / `TODO`: an _argument_ --  the text to search for.

  / `ideas.txt`: an _argument_ -- the file to search.
]

---

#align(center)[
  #set text(size: 1.6em)

  #show raw: it => {
    set text(size: 1.2em)
    show regex("\[\d*\]"): it => pin(eval(it.text.slice(1, -1)))
    it
  }

  `[1]grep[2]   [5]-n[6]   [7]TODO[8]   [9]ideas.txt[0]`

  #pinit-label(swat-colors.secondary, (1, 2), top, dx: 70%)[program]

  #pinit-label(swat-colors.tertiary, (5, 6), bottom, dx: -40%)[option]

  #pinit-label(
    swat-colors.primary-light,
    (7, 8),
    bottom,
    dx: 100%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[search text]

  #pinit-label(
    swat-colors.primary,
    (9, 0),
    top,
    dx: -30%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[file]
]

== Options Can Take Values

Some options take another argument as their value.

Here, `head` uses `-n` to specify how many lines to show.

#v(1em)
#pause

#term-center(terminal-frame(
  width: 95%,
  ```bash
  head -n 5 notes.txt
  ```,
))


#v(1em)
#pause

Here, `-n` is an *option*, and `5` is its *option value*.

#v(1em)
#pause

The exact convention depends on the program.

---


#align(center)[
  #set text(size: 1.6em)

  #show raw: it => {
    set text(size: 1.2em)
    show regex("\[\d*\]"): it => pin(eval(it.text.slice(1, -1)))
    it
  }

  `[1]head[2]   [5]-n[6]   [7]5[8]   [9]notes.txt[0]`

  #pinit-label(swat-colors.secondary, (1, 2), top, dx: 70%)[program]

  #pinit-label(swat-colors.tertiary, (5, 6), bottom, dx: -70%)[option]

  #pinit-label(
    swat-colors.primary-light,
    (7, 8),
    bottom,
    dx: 100%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[option value]

  #pinit-label(
    swat-colors.primary,
    (9, 0),
    top,
    dx: -50%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[positional argument]
]

== Programs Can Have Subcommands

Some programs use a *subcommand* to choose what action to perform.

#v(1em)
#pause

#term-center(terminal-frame(
  width: 95%,
  ```bash
  git status
  ```,
))

#v(1em)
#pause

The shell starts the `git` program.

`git` interprets `status` as a subcommand: show the current state of the repository.

#v(1em)
#pause

Other examples include `git log` and `git diff`.

== Not Every Program Uses The Same Conventions

Many programs use options like `-v` or `--help`.

But argument conventions are not universal.

#v(2em)
#pause

For example, `dd` uses `name=value` arguments:

#v(0.4em)

#term-center(terminal-frame(
  width: 95%,
  ```bash
  dd if=input.txt of=copy.txt
  ```,
))

#v(0.6em)
#pause

Here, `if=input.txt` and `of=copy.txt` are arguments interpreted by `dd`'s rules.

#v(1.5em)
#pause

When in doubt, check the program's help or documentation.

#v(1.5em)

== A Few Useful Terms

#[
  #set terms(indent: 0.6em, spacing: 2.4em)

  / Command: what the user types, such as `grep -n TODO ideas.txt`.

  / Program: the executable the shell starts, here `grep`.

  / Argument: a string the shell passes to the program.

  / Subcommand: an argument the program interprets as an action.

  / Option: an argument the program interprets as a setting, often starting with `-` or `--`.

  / Option value: an argument that supplies a value for an option.

  / Positional argument: an argument the program interprets by its position.
]

== Some Annotated Examples

#align(center)[
  #set text(size: 1.2em)

  #show raw: it => {
    set text(size: 1.1em)
    show regex("\[\d*\]"): it => pin(eval(it.text.slice(1, -1)))
    it
  }

  `[0]git[1] [2]clone[3] [4]--branch[5] [6]main[7] [8]git@github.com:swat-ksu/org[9]`

  #pinit-label(swat-colors.secondary, (0, 1), top, dx: 100%)[program]

  #pinit-label(swat-colors.tertiary, (2, 3), bottom, dx: 30%)[subcommand]

  #pinit-label(
    swat-colors.primary-light,
    (4, 5),
    top,
    dx: 20%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[option]

  #pinit-label(
    swat-colors.primary,
    (6, 7),
    bottom,
    dx: 90%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[option value: the target branch]

  #pinit-label(
    green,
    (8, 9),
    top,
    dx: -30%,
  )[positional argument: the target repo]
]

---

#align(center)[
  #set text(size: 1.2em)

  #show raw: it => {
    set text(size: 1.2em)
    show regex("\[\d*\]"): it => pin(eval(it.text.slice(1, -1)))
    it
  }

  `[0]curl[1] [2]--output[3] [4]page.html[5] [6]https://example.com[7]`

  #pinit-label(swat-colors.secondary, (0, 1), top, dx: 100%)[program]

  #pinit-label(swat-colors.tertiary, (2, 3), bottom, dx: 30%)[option]

  #pinit-label(
    swat-colors.primary-light,
    (4, 5),
    top,
    dx: 20%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[option value]

  #pinit-label(
    swat-colors.primary,
    (6, 7),
    bottom,
    dx: -50%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[positional argument]
]

---


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
