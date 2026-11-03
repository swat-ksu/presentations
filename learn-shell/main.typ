#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0": 

#show: swat-doc.with(
  title: [Intro to Your Shell],
  authors: (
    author("Adrian Valcarcel-Schott", gh: "avalsch"),
    author("Brendan Moore", gh: "Mere-Solace"),
  ),
)

= Getting Started

== Installing a Shell

#cols(align: top)[
  #align(center)[*Windows*]

  #link("https://git-scm.com/install/windows")

  Select the latest *Git for Windows*.

  // flesh out installation instructions
  // winget?
  // WSL alternative
][
  #align(center)[*Mac / Linux*]

  You should already have a shell installed out of the box.

  #cols[/ Linux: `bash`][/ Mac: `zsh`]

  Open your terminal/console application.
]

== Many Shells

There are many shells available for you to choose from.

`bash` is not the only shell.

- `zsh`
- `fish`
- `pwsh`
- `nushell`

== Terminals

A *terminal* is a program that runs a shell.

To start interacting with your shell, you open your terminal (e.g., Windows Terminal).

= The Shell is an Interface

A *shell* is an interface that allows access to OS functionality and other programs.

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
