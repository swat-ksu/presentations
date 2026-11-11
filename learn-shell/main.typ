#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0" as conch: system, terminal-block, terminal-frame, terminal-frames
#import "@preview/pinit:0.2.2": *

#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#let fletcher-diagram = touying-reduce.with(fletcher)

#import "util.typ": command-diagram, pinit-label

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

#pause-gap()

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

#pause-gap(gap: 2em)

A terminal can run different shells, and a shell can run inside different terminal apps.

#pause-gap(gap: 2em)

// TODO: analogy
meaningful analogy here


= The Shell Runs Programs

== A simple task

Suppose you have a folder of notes, and you want to find every line that mentions `TODO`.

#pause-gap()

You could open files one by one, checking manually. Or, you could ask the computer:

#pause-gap()

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
  grep -n TODO *.txt
  ```
])

#pause-gap()

The shell lets you give instructions to your computer and showing you what they return.

#speaker-notes[
  - grep is a program that searches text.

  - the shell is not doing the search itself; it starts grep and passes it information.

  - don't explain `*.txt` yet. revisit it with arguments and shell syntax.
]

== Shell interaction flow

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

== What actually happens?

The shell starts a program called `grep`, which finds the matching lines

#pause-gap(gap: 2em)

But the command we typed (`grep -n TODO *.txt`) has several pieces.

#pause-gap(gap: 2em)

What parts did the shell interpret, and which parts did `grep` recieve?


= From Command Text to Arguments

== The program receives arguments

Let's look at a slightly simpler example:

#pause-gap()

#term-center(
  terminal-frame(
    width: 95%,
    ```bash
      grep TODO ideas.txt project.txt
    ```,
  ),
)

#pause-gap()

The shell starts `grep` and gives it these arguments:

- `TODO`
- `ideas.txt`
- `project.txt`

#pause-gap()

Then, `grep` gets to decides what those strings mean.

In this case, "search for `TODO` in `ideas.txt` and `project.txt`."

= How Programs Interpret Arguments

== Options and positional arguments

Programs often follow similar conventions when assigning meaning to their arguments.

#pause-gap()

For example, `grep` uses `-n` as an option:

#term-center(terminal-frame(
  width: 95%,
  ```bash
  grep -n TODO ideas.txt
  ```,
))

#pause-gap()

`grep` receives the arguments: #h(1em) `["-n", "TODO", "ideas.txt"]`

#pause-gap()

#[
  `grep` interprets them as:

  #set terms(indent: 3em)

  / `-n`: an _option_ -- include line numbers.

  / `TODO`: an _argument_ --  the text to search for.

  / `ideas.txt`: an _argument_ -- the file to search.
]

---

#command-diagram(
  (`grep`, `-n`, `TODO`, `ideas.txt`),

  piece-spacing: 2,
  text-size: 1.4em,
  raw-text-size: 1.4em,

  pinit-label(
    swat-colors.secondary,
    top,
    dx: 70%,
  )[program],

  pinit-label(
    swat-colors.tertiary,
    bottom,
    dx: -40%,
  )[option],

  pinit-label(
    swat-colors.primary-light,
    bottom,
    dx: 100%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[search text],

  pinit-label(
    swat-colors.primary,
    top,
    dx: -30%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[file],
)

== Options with values

Some options take another argument as their value.

Here, `head` uses `-n` to specify how many lines to show.

#pause-gap()

#term-center(terminal-frame(
  width: 95%,
  ```bash
  head -n 5 notes.txt
  ```,
))

#pause-gap()

Here, `-n` is an *option*, and `5` is its *option value*.

#pause-gap()

The exact convention depends on the program.

---

#command-diagram(
  (`head`, `-n`, `5`, `notes.txt`),

  piece-spacing: 2,
  text-size: 1.4em,
  raw-text-size: 1.4em,

  pinit-label(
    swat-colors.secondary,
    top,
    dx: 70%,
  )[program],

  pinit-label(
    swat-colors.tertiary,
    bottom,
    dx: -70%,
  )[option],

  pinit-label(
    swat-colors.primary-light,
    bottom,
    dx: 100%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[option value],

  pinit-label(
    swat-colors.primary,
    top,
    dx: -50%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[positional argument],
)

== Subcommands

Some programs use a *subcommand* to choose what action to perform.

#pause-gap()

#term-center(terminal-frame(
  width: 95%,
  ```bash
  git status
  ```,
))

#pause-gap()

The shell starts the `git` program.

`git` interprets `status` as a subcommand: show the current state of the repository.

#pause-gap()

Other examples include `git log` and `git diff`.

== Different conventions

Many programs use options like `-v` or `--help`.

But argument conventions are not universal.

#pause-gap(gap: 2em)

For example, `dd` uses `name=value` arguments:

#v(0.4em)

#term-center(terminal-frame(
  width: 95%,
  ```bash
  dd if=input.txt of=copy.txt
  ```,
))

#pause-gap(gap: 0.6em)

Here, `if=input.txt` and `of=copy.txt` are arguments interpreted by `dd`'s rules.

#pause-gap(gap: 1.5em)

When in doubt, check the program's help or documentation.

#v(1.5em)

== Vocabulary recap

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

== Annotated examples

#command-diagram(
  (`git`, `clone`, `--branch`, `main`, `git@github.com:swat-ksu/org`),

  pinit-label(
    swat-colors.secondary,
    top,
    dx: 100%,
  )[command],

  pinit-label(
    swat-colors.tertiary,
    bottom,
    dx: 30%,
  )[subcommand],

  pinit-label(
    swat-colors.primary-light,
    top,
    dx: 20%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[option],

  pinit-label(
    swat-colors.primary,
    bottom,
    dx: 90%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[option value: the target branch],

  pinit-label(
    green,
    top,
    dx: -30%,
  )[positional argument: the target repo],
)

---

#command-diagram(
  (`curl`, `--output`, `page.html`, `https://example.com`),

  pinit-label(
    swat-colors.secondary,
    top,
    dx: 100%,
  )[program],

  pinit-label(
    swat-colors.tertiary,
    bottom,
    dx: 30%,
  )[option],

  pinit-label(
    swat-colors.primary-light,
    top,
    dx: 20%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[option value],

  pinit-label(
    swat-colors.primary,
    bottom,
    dx: -50%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[positional argument],
)

= How Programs Communicate

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
