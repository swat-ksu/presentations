#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "@preview/conch:0.1.0" as conch: system, terminal-block, terminal-frame, terminal-frames
#import "@preview/pinit:0.2.2": *

#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#let fletcher-diagram = touying-reduce.with(fletcher)

#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.10": codly-languages

#import "util.typ": command-diagram, encode-ansi, pinit-label, terms-right-align

#show: codly.theme(
  "clean",
  fill: swat-colors.neutral-lightest.darken(5%),
  header: (text: (fill: swat-colors.neutral-lightest)),
  header-fill: rgb("#1f2328"),
  radius: 5pt,
)
#show: codly.lang-set_(
  languages: codly-languages.map(
    c => (name: "" + h(-0.2em), icon: c.icon),
  ),
  fill: swat-colors.neutral-lightest,
  radius: 0.4em,
)

#show raw.where(block: false): set text(size: 1.2em)

#show: swat-doc.with(
  title: [Intro to Your Shell],
  authors: (
    author("Adrian Valcarcel-Schott", gh: "avalsch"),
    author("Brendan Moore", gh: "Mere-Solace"),
  ),
  config-common(
    show-hide-set-list-marker-none: false,
  ),
)

#let system = system.with(hostname: "ksu")

#let practice-system = system(files: (
  "README.md": "Shell practice repo\nWork in data/; keep originals unchanged.\nSee tasks.md for activities.\n",
  "data/ideas.txt": read("practice-repo/data/ideas.txt"),
  "data/meeting notes.txt": read("practice-repo/data/meeting notes.txt"),
  "data/project.txt": read("practice-repo/data/project.txt"),
  "starter/summary.txt": read("practice-repo/starter/summary.txt"),
))

#let system-ex01 = system(
  files: (
    "ideas.txt": read("ex01/ideas.txt"),
    "meeting.txt": read("ex01/meeting.txt"),
    "project.txt": read("ex01/project.txt"),
  ),
)

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

#let term-style = (
  font: (font: "Fira Mono", size: 1em, weight: "regular"),
  chrome: (title, t, f) => block(fill: t.title-bg, width: 100%, inset: 8pt, {
    align(center, text(..f, fill: t.title-fg)[Terminal --- #title])
  }),
  theme: terminal-theme,
)

#let term-config = (
  system: system(),
  user: "swat",
  show-cursor: false,
  ..term-style,
)

#let terminal-block = terminal-block.with(
  style: (inset: (top: -0.4em, rest: 0.8em)),
  ..term-config,
)

#let terminal-frames = terminal-frames.with(
  style: (inset: (rest: 0.8em)),
  ..term-config,
)

#let terminal-frame(..args, body) = terminal-frames(
  style: (inset: (top: -0.4em, rest: 0.8em)),
  commands: (body.text.trim(),),
  ..args,
).first()

#let term-center(height: auto, it) = align(center, block(
  height: height,
  align(top + left, it),
))

// kinda hacky, overrides conch's "bold" font weight to be
// a more reasonable "medium" so that bolded content doesn't
// look horribly large and out of place
#show text.where(weight: "bold"): set text(weight: "medium")

#let ar = sym.arrow.r

= Let's Use The Shell

#align(center)[
  #text(size: 1.3em)[A few commands can save you a lot of clicking.]

  #pause-gap(gap: 1.5em)

  #rect(
    width: 92%,
    radius: 1em,
    stroke: swat-colors.secondary,
    inset: 1.2em,
  )[
    *We’ll:* find our way around #ar look at files #ar search #ar save the results
  ]

  #pause-gap(gap: 1.5em)

  #text(size: 1.1em)[
    Let’s find the TODOs in a small project and save the results.
  ]
]

== What we’ll do

#align(center)[
  #set text(size: 1.2em)

  #show grid.cell: strong

  #grid(
    columns: (1fr, 1fr),
    gutter: 2.8em,
    [Find your place], [Look through a project],
    [Search for text], [Save what you found],
  )

  #pause-gap(gap: 1.6em)

  We’ll use the same small project for all of it.
]

== Terminal, shell, program: which is which?

#align(center, fletcher-diagram(
  node-inset: 1.2em,
  node-outset: 0.8em,
  node-corner-radius: 0.8em,
  node-stroke: 0.1em,
  edge-stroke: 0.1em,
  spacing: 4em,
  {
    node((0, 0))[*You*]
    edge("-|>")
    node((1, 0))[*Terminal* window]
    edge("-|>")
    node((2, 0))[*Shell* reads commands]
  },
))

#pause-gap(gap: 2em)

The *terminal* is the app or window; the *shell* is the program interpreting what you type.

#pause-gap()

A terminal can run different shells, and a shell can run inside different terminal apps.

#pause-gap()

#align(center)[*Examples today use Bash:* Git Bash / WSL / macOS Terminal / Linux terminal.]

== The question we'll work on

#align(center)[

  #text(size: 1.35em)[Where are the TODOs in these project notes?]

  #pause-gap()

  #rect(
    width: 75%,
    radius: 0.8em,
    stroke: swat-colors.secondary,
    inset: 1em,
  )[
    #let ar = h(0.4em) + ar + h(0.4em)

    Make a guess #ar run a command #ar see what happens
  ]

  #pause-gap()

  We’ll build up to a short report. Hints are there if you get stuck.
]

== First, get the practice files

Clone the workshop repo from the link, then enter its folder:

#v(1em)

#align(center, codly.new(
  width: 80%,
  header: [clone the repo],
  ```bash
  git clone https://github.com/swat-ksu/shell-practice
  cd shell-practice
  ```,
))

#pause-gap()

`git clone` gets the files. `cd` changes the shell’s current directory.

== Where am I?

#term-center(terminal-block(width: 80%)[
  ```bash
  pwd
  ```
])

#align(center)[
  `pwd` prints the current directory -- your shell's "you are here."
]

#pause-gap(gap: 0.4em)

#align(center)[Run `pwd`. Does the path end in `shell-practice`?]

#pause-gap(gap: 0.4em)

#align(
  center,
  text(fill: swat-colors.tertiary)[
    If not, check the folder you cloned into.
  ],
)

== What’s around me?

#term-center(terminal-block(
  width: 85%,
  system: practice-system,
)[
  ```bash
  ls
  ```
])

#pause-gap()

#align(center)[
  `ls` lists the current directory. Think “open the folder view.”
]

#pause-gap()

#align(center)[Which entry has the notes?]

#pause-gap()

#align(center)[Run `ls`, then `cd data` and `ls` again.]

== Find your way back

#align(center)[
  #set text(size: 1.4em)

  #block(align(left, stack(
    spacing: 0.25em,
    [`data/`],
    [#h(-1.2em) #sym.arrow.t `cd ..`],
    [project root],
  )))
]

#pause-gap()

#align(center, text(size: 1.2em)[
  `cd folder` goes in. `cd ..` goes to the parent. `cd ~` goes home.
])

#pause-gap()

#align(center, text(size: 1.2em)[
  Go back to the project folder with `cd ..`. Use `pwd` to check.
])

== Read before you change

#term-center(terminal-block(width: 88%, system: practice-system)[
  ```bash
  cat data/project.txt
  ```
])

#pause-gap(gap: 0.6em)

#align(center)[
  `cat` prints a short file. For a long one, use `less`; press `q` to quit.
]

#pause-gap(gap: 0.6em)

#align(center)[
  Now show just the first three lines: `head -n 3 data/project.txt`.
]

= Read the command

== Who handles what?

#align(center)[
  #fletcher-diagram(
    node-inset: 1.2em,
    node-outset: 0.8em,
    node-corner-radius: 0.8em,
    node-stroke: 0.1em,
    edge-stroke: 0.1em,
    spacing: 4em,
    {
      node((0, 0))[*Shell* prepares the request]
      edge("-|>")
      node((1, 0))[*Program* does the task]
    },
  )

  #pause-gap(gap: 1.6em)

  Consider `head -n 3 data/project.txt`.

  The shell starts `head` and passes it the other pieces.

  Then `head` has to decide what `-n 3` means.

  #pause-gap()

  #let d = strong(text(size: 1.4em, sym.dot))

  A common shape is: #h(0.2em) `program` #d `options` #d `file/input`
]

== Take this command apart

#term-center(terminal-frame(
  width: 95%,
  ```bash
  grep -n TODO data/project.txt
  ```,
))

#pause-gap(gap: 3.6em)

#command-diagram(
  (`grep`, `-n`, `TODO`, `data/project.txt`),

  piece-spacing: 2,
  raw-text-size: 1.4em,

  pinit-label(
    swat-colors.secondary,
    top,
    dx: 70%,
  )[search],

  pinit-label(
    swat-colors.tertiary,
    bottom,
    dx: 60%,
  )[include line numbers],

  pinit-label(
    swat-colors.primary-light,
    top,
    // dx: 100%,
    fill: swat-colors.primary-light.transparentize(80%).saturate(40%),
  )[search text],

  pinit-label(
    swat-colors.primary,
    top,
    dx: -30%,
    fill: swat-colors.primary.lighten(10%).transparentize(70%).saturate(100%),
  )[file path],
)

#pause-gap(gap: 3em)

#align(center)[
  Options like `-n` are common, but each program has its own rules.
]

== Some programs have subcommands

#term-center(terminal-frame(
  ```bash
  git status
  ```,
))

#pause-gap()

#align(center)[
  #set text(size: 1.1em)

  Here `git` is the program and `status` tells it what to do.

  #pause

  You’ll see the same pattern in `git log` and `git diff`.
]

== Spaces need quotes

A filename with a space is still *one path*.

#let commands = ("grep TODO data/meeting notes.txt", "grep TODO \"data/meeting notes.txt\"", "")

#let frames(i) = layout(
  size => terminal-frames(
    width: size.width * 95%,
    height: 100%,
    commands: commands,
    system: practice-system,
    mode: "key-frames",
  )
    .map(term-center.with(height: 50%))
    .at(i),
)

// garbage code to work around a touying `alternatives-fn` bug
#alternatives-match(
  ("1": hide(frames(0)), ..range(4).map(i => (str(i + 2), frames(i))).to-dict(), "5": frames(4)),
)

#uncover("4-")[
  The quotes tell the shell to pass `"meeting notes.txt"` as *one* argument.
]

// TODO: drop last slide?

== One pattern, several files

#term-center(terminal-frame(
  width: 90%,
  system: practice-system,
  ```bash
  grep -n TODO data/*.txt
  ```,
))

#pause-gap()

#align(center)[
  Here `*.txt` matches all the files ending in `.txt`.

  #pause-gap(gap: 0.4em)

  The shell turns that pattern into a list of paths before `grep` runs.

  #pause-gap(gap: 0.4em)

  The `*` is a pattern, not a search for a literal asterisk.
]

== Try it yourself: search the notes

#align(center)[
  #rect(
    width: 75%,
    radius: 0.8em,
    stroke: swat-colors.tertiary,
    inset: 1.2em,
  )[
    #set text(size: 1.2em)

    Find every TODO line, with its line number.
  ]

  #pause-gap()

  Hint: start with `grep -n`, then add the word and the file paths.
]

= Make a useful result

== Save the result

#term-center(
  terminal-frames(
    system: practice-system,
    width: 95%,
    style: (inset: (top: -0.4em, rest: 0.8em)),
    commands: ("grep -n TODO data/*.txt > todos.txt", "cat todos.txt"),
  ).last(),
)

#pause-gap()

#align(center)[
  `>` sends the regular output to a file. If that file already exists, it replaces its contents.
]

== Passing results with pipes

#align(center)[
  #set text(size: 1.1em)

  #fletcher-diagram(
    node-stroke: .1em,
    node-inset: 0.8em,
    node-corner-radius: 1em,
    node-outset: 1em,
    edge-stroke: 0.1em,
    spacing: 5em,
    {
      node((0, 0))[*`grep`* \ find matching lines]
      edge("-|>")
      node((1, 0))[*`wc`* \ count lines]
    },
  )
]

#pause-gap(gap: 0.4em)

#term-center(terminal-block(width: 74%, system: practice-system)[
  ```bash
  grep TODO data/*.txt | wc -l
  ```
])

#pause-gap(gap: 0.4em)

#align(center)[
  `grep` prints the matching lines; `|` passes them to `wc` to count.

  #pause

  This counts *matching lines*, not the number of TODO words.
]

== Your safe workspace

#align(center)[
  Create and inspect a practice folder:
]

#term-center(terminal-block(width: 90%, system: practice-system)[
  ```bash
  mkdir practice
  ls
  ```
])

#pause-gap(gap: 1.2em)

#align(center)[
  _Before changing files, check where you are and what the command will touch._
]

== Common file actions

#align(center)[
  #let d = strong(text(size: 1.4em, sym.dot))

  #block(
    width: 80%,
    grid(
      columns: (1fr, 1fr),
      // gutter: 1em,
      row-gutter: 0.8em,
      [`mkdir` #d create a folder], [`touch` #d create an empty file],
      [`cp` #d copy], [`mv` #d move or rename],
    ),
  )

  #pause-gap(gap: 1.8em)

  `rm` deletes. There's no undo. We won’t need it for today’s tasks.

  #pause-gap()

  Read the command first. Check the target.

  Then make sure it did what you expected.
]

== Your turn: make a small report

#align(center)[
  Copy a starter note into `practice/`, then save its TODO lines.

  #let ar = h(0.4em) + strong(text(fill: swat-colors.tertiary.darken(30%), ar)) + h(0.4em)

  `cp` copies #ar `grep` searches #ar `>` saves #ar `cat` verifies

  #v(1em)

  #rect(
    width: 78%,
    radius: 0.8em,
    stroke: swat-colors.tertiary,
    inset: 1em,
  )[
    #set text(size: 1.05em)

    Take a few minutes. Work with a neighbor if you like.
  ]

  #v(1em)

  You’re done when `practice/report.txt` contains the matching lines.
]

== What if there are no matches?

#align(center)[
  #stack(
    dir: ltr,
    spacing: 2em,
    rect(width: 32%, radius: 0.8em, stroke: swat-colors.secondary, inset: 1em)[
      `grep TODO file` \ found a match
    ],
    text(size: 1.5em)[or],
    rect(width: 32%, radius: 0.8em, stroke: swat-colors.tertiary, inset: 1em)[`grep TODO file` \ no match],
  )

  #pause-gap()

  That’s a normal result, not necessarily an error.

  A command can also signal success or failure to the shell.

  #pause-gap()

  Try searching for a word you know isn’t there.
]

== Put commands in a file

#align(center)[
  #set text(size: 1.1em)

  A shell script is just commands saved in a file. Bash can run the file for you.

  #pause-gap(gap: 0.4em)

  #codly.new(
    header: [report.sh],
    width: 80%,
    ```bash
    grep -n TODO data/*.txt > todos.txt
    cat todos.txt
    ```,
  )

  #pause-gap(gap: 0.4em)

  Run it from the project root with `bash report.sh`.

  You can write or edit it in any text editor.
]

= More Shell Features

There are a few more shell features worth knowing by name.

#pause-gap()

We'll go through them quickly here; you can come back to the examples later.

== Variables hold on to a value

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [Search a chosen file],
    ```bash
    search=TODO
    file="data/meeting notes.txt"
    grep "$search" "$file"
    ```,
  )

  #v(1.4em)

  Before `grep` runs, the shell substitutes the values of `search` and `file`. Keep the quotes, especially when a value may contain spaces.
]

== Quotes do different things

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [Single quotes and double quotes],
    ```bash
    name="Sam"
    echo "$name"
    echo '$name'
    ```,
  )

  #v(0.8em)

  Double quotes still allow `$name` to expand. Single quotes keep the text literal. Quote variable expansions unless you have a reason not to.
]

== A backslash can protect one character

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [Escape a space],
    ```bash
    grep TODO data/meeting\ notes.txt
    ```,
  )

  #v(0.8em)

  The backslash tells the shell to treat the space as part of the filename.

  Quoting the whole path is usually simpler, but you may see this form too.
]

== Run the next command conditionally

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [Command separators],
    ```bash
    grep TODO data/project.txt && echo "found TODOs"
    grep ABSENT data/project.txt || echo "no match"
    ```,
  )

  #v(0.8em)

  `;` runs commands one after another. `&&` runs the next command only if the first succeeds; `||` runs it if the first fails. The example’s message is intentionally broad: a failed `grep` could mean no match or a missing file.
]

== Commands report success or failure

#[
  #set text(size: 1.2em)
  #codly.new(
    header: [Exit status],
    ```bash
    grep -q TODO data/project.txt
    echo "$?"
    ```,
  )

  #v(0.8em)

  `$?` is the exit status of the command just run.

  By convention, `0` means success and a nonzero value means failure.

  `grep` uses this to distinguish "found" from "not found."
]

== A script can take an argument

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [search-file.sh],
    raw(
      block: true,
      lang: "bash",
      ```bash
      grep -n "$1" "$2"
      ```.text,
    ),
  )

  #v(1.4em)

  // TODO: put in term

  Run it as `bash search-file.sh TODO "data/meeting notes.txt"`.

  `$1` and `$2` are the first and second arguments after the script name.

  Quote them just like other variable values.
]

== Make a choice based on a command

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [has-todos.sh],
    ```bash
    if grep -q TODO "$1"; then
      echo "Found TODOs"
    else
      echo "No TODOs found"
    fi
    ```,
  )

  #v(0.6em)

  `if` branches on whether `grep` found a match.

  The `-q` option keeps `grep` quiet; the script prints the message instead.
]

== Repeat a command for several files

#align(center)[
  #set text(size: 1.2em)

  #codly.new(
    width: 86%,
    header: [count-todos.sh],
    ```bash
    for file in data/*.txt; do
      printf '%s: ' "$file"
      grep -c TODO "$file"
    done
    ```,
  )

  #v(0.6em)

  The loop runs once for each path matched by `data/*.txt`.

  On each pass, `file` holds that path.
]

== Give a group of commands a name

#[
  #set text(size: 1.2em)

  #codly.new(
    header: [A small function],
    ```bash
    show-todos() {
      grep -n TODO "$1"
    }

    show-todos "data/meeting notes.txt"
    ```,
  )

  #v(0.6em)

  If a script uses the same group of commands many times, it can be useful to give them a name.  Here, `$1` is the filename passed to the function.
]


== Three streams in and out

#align(center)[
  #set text(size: 1.2em)

  #cols(
    gutter: 0.8em,
    [*`stdin`* \ input],
    [*`stdout`* \ usual output],
    [*`stderr`* \ errors and messages],
  )

  #v(2em)

  They often appear together in the terminal, but they’re separate.

  That’s why redirecting regular output doesn’t hide error messages.
]

== Redirect output -- or input

#align(center)[
  #set text(size: 1.2em)

  #codly.new(
    width: 90%,
    header: [Redirection],
    ```bash
    echo "first line" > notes.txt
    echo "another line" >> notes.txt
    wc -l < notes.txt
    ```,
  )

  #v(0.6em)

  `>` creates or replaces a file; `>>` adds to the end.

  `<` passes the contents of a file to a program's input.

  #pause-gap(gap: 0.2em)

  Be careful with `>`: it overwrites the destination before the command runs.
]

== Errors have their own stream

#align(center)[
  #set text(size: 1.2em)

  #codly.new(
    width: 80%,
    header: [Redirect just the error],
    ```bash
    ls missing-file 2> errors.txt
    cat errors.txt
    ```,
  )

  #v(1em)

  `2>` redirects standard error. The `2` is the file descriptor number.
]

== Put both streams in one log

#[
  #set text(size: 1.2em)

  #term-center(terminal-frame(
    width: 90%,
    ```bash
    some-command > run.log 2>&1
    ```,
  ))

  This sends standard output to `run.log`, then sends standard error to the same place. The order matters: `2>&1` means "send errors wherever output is going now."
]

== Substitute a command’s result

#align(center)[
  #set text(size: 1.2em)

  #term-center(terminal-block(width: 90%)[
    ```bash
    echo "Today is $(date +%F)"
    ```
  ])

  #v(1em)

  `$(...)` runs the command in the parentheses and puts its output here.

  This is called *command substitution*.
]

== Values the shell inherits

#align(center)[
  #set text(size: 1.2em)

  #term-center(terminal-block(width: 100%)[
    ```bash
    echo "$HOME"
    echo "$PATH"
    ```,
  ])

  #v(0.6em)

  `HOME` is your home folder. `PATH` lists where the shell looks for programs.

  Both are *environment variables*: settings passed to launched programs.
]

== Some commands live inside the shell

#[
  #set text(size: 1.1em)

  #term-center(terminal-block(width: 90%)[
    ```bash
    type cd
    ```,
  ])

  #v(0.6em)

  `type` can identify a builtin, alias, function, or executable.

  `cd` must be a builtin: a separate program can't change the current directory of the shell that launched it. Other useful builtins include `read` and `export`.

  `type` is Bash-specific; other shells have their own ways to inspect commands.
]

== Find files by name

#[
  #set text(size: 1.1em)

  #term-center(terminal-frame(
    width: 80%,
    ```bash
    find data -type f -name '*.txt'
    ```,
  ))

  #v(0.6em)

  `find` walks through directories and prints paths that match. The quotes keep `*.txt` for `find` to interpret, rather than letting the shell expand it first.
]

== Run something in the background

#term-center(
  terminal-frames(
    system: practice-system,
    width: 95%,
    style: (inset: (top: -0.4em, rest: 0.8em)),
    commands: ("grep -n TODO data/*.txt > todos.txt", "cat todos.txt"),
  ).last(),
)

#v(0.4em)

An `&` at the end starts a command in the background, so you get the prompt back. `jobs` lists background jobs in this shell; `fg` brings one to the front.

`Ctrl+C` interrupts a foreground command. For a background job, bring it forward with `fg` first, or use `kill` carefully.

== Scripts can be run directly, too

#[
  #set text(size: 1.2em)

  A script can start with a *shebang*, such as `#!/bin/bash`, and be marked executable with `chmod +x script.sh`.

  #v(1em)

  Then run it with `./script.sh`.

  For a first script, `bash script.sh` is simpler and needs no extra setup.
]

== If a command won’t stop

#align(center, text(size: 1.4em)[
  Press *`Ctrl+C`* to interrupt the currently running program.

  #v(0.6em)

  It stops that program; it doesn’t close the terminal.
])

== Find help when you forget

#align(center)[
  #set text(size: 1.2em)

  #term-center(terminal-frame(
    width: 100%,
    ```bash
    grep --help
    ```,
  ))

  #v(1em)

  #let d = strong(text(size: 1.4em, sym.dot))

  Use `--help` for options. Manuals (`man`) and `tldr` are other routes.

  #v(0.6em)

  `Tab` completes names #d `Ctrl+R` searches history.
]

== So what does the shell do?

#align(center)[
  #fletcher-diagram(
    node-stroke: .1em,
    node-inset: 0.6em,
    node-corner-radius: 1em,
    node-outset: 1em,
    edge-stroke: 0.1em,
    spacing: 6em,
    {
      node(
        (0, 0),
        stroke: swat-colors.secondary,
      )[*You* \ ask a question]
      edge("-|>")[`command`]
      node(
        (1, 0),
        stroke: swat-colors.tertiary,
      )[*Shell* \ prepares arguments]

      edge("-|>")[`executes`]

      node(
        (2, 0),
        stroke: swat-colors.primary-light,
      )[*Programs* \ do small jobs]

      edge(
        (2, 0),
        (2, 0.6),
        (0, 0.6),
        (0, 0),
        "-|>",
      )[`result`]
    },
  )
]
