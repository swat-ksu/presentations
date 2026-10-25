#import "../swat-doc.typ": *

#import touying: *
#import theme: *

#import "util.typ": ilink

#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.10": codly-languages

#show: codly.theme(
  "clean",
  fill: swat-colors.neutral-lightest.darken(2%),
  radius: 5pt,
)
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
  title: [Example Presentation & Documentation],
  subtitle: [How to make your own slides, with _Typst_],
  authors: author(
    "Adrian Valcarcel-Schott",
    gh: "avalsch",
  ),
)

= Getting Started

Here's how to get started:

#v(0.5em)

#codly.new(
  ```sh
  # 1. clone the repo.
  git clone https://github.com/swat-ksu/presentations

  # 2. change directories into the repo you just cloned.
  cd presentations/

  # 3. make a copy of the template folder for your presentation.
  #    (replace <YOUR_PRES_NAME> with a name for your presentation)
  cp template/ <YOUR_PRES_NAME> -r

  # 4. start editing <YOUR_PRES_NAME>/main.typ in your favorite ide.
  #    make sure to update the relevant information like the title,
  #    subtitle, authors, etc.
  ```,
  number-enabled: false,
)

== Starter template content

#v(0.5em)

#raw(read("../template/main.typ"), lang: "typst", block: true)

= Helpful References

#set terms(spacing: 2.6em)

/ Typst Tutorial: the best place to start if you're new to Typst. #ilink("https://typst.app/docs/tutorial/")[link]

/ Typst Documentation: language, syntax, and standard library. #ilink("https://typst.app/docs/")[link]

/ Typst Universe: discover packages for any use case. #ilink("https://typst.app/universe/")[link]

/ Touying Documentation: presentation concepts, functions, and examples. #ilink("https://touying-typ.github.io/")[link]

= Useful Components

== Structure a presentation

Use heading-based slides for most content. Touying turns each `==` heading into a slide, so the source stays easy to scan and reorder.

When a slide needs a custom title or layout, use `#slide` directly:

#v(1em)

```typ
#slide(title: [A custom slide], composer: (1fr, 1fr))[
  First content area.
][
  Second content area.
]
```

#slide(title: [A custom slide], composer: (1fr, 1fr))[
  First content area.
][
  Second content area.
]

== Outline slide

An outline slide helps orient the audience at the start of a section or recap its structure:

#outline-slide(
  title: [Today's Outline],
  level: 1,
  numbered: (false,),
)

== Arrange content

Use columns to compare ideas or pair text with an image. Keep both sides concise.

#v(2em)

#cols(columns: (1fr, 1fr), gutter: 1.5em)[
  *Before*

  Details are spread across many sources.

  Finding the full picture takes time.
][
  *After*

  Key details are together in one place.

  The next step is easy to identify.
]

== Reveal information progressively

Keep both headings visible; reveal one item left, then one right:

#v(1em)

// you can also do this with a grid and #pause

#cols(columns: (1fr, 1fr), gutter: 1.5em)[
  *First: identify the problem*

  #uncover("2-")[- Information is scattered.]

  #uncover("4-")[- Important details are easy to miss.]

  #uncover("6-")[- Updates are hard to track.]
][
  *Then: show the response*

  #uncover("3-")[- Bring the details together.]

  #uncover("5-")[- Make the next step clear.]

  #uncover("7-")[- Keep everyone on the same page.]
]

#v(3em)

Use `#pause` to reveal content step by step.

#v(1em)

For more control over when individual items appear, use `#uncover`.

== Replace content with alternatives

Use `alternatives` to choose one version instead of calling `only` repeatedly:

#v(1em)

#alternatives[Call `#only` multiple times #sym.crossmark][Use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.

#v(1em)

See #ilink("https://touying-typ.github.io/docs/tutorials/dynamic/complex#alternatives")[Touying's alternatives documentation] for more options.

== A proof by contradiction

#v(2fr)

Pauses can build an argument or a calculation:

#v(4fr)

Assume, for contradiction, that $sqrt(2) = frac(style: "skewed", p, q)$ in lowest terms.

#pause

Then, squaring both sides gives $p^2 = 2q^2$, so $p$ is even.

#pause

Let $p = 2k$.

#pause

Substituting $p = 2k$ gives:

$ 4k^2 = 2q^2 quad ==> quad q^2 = 2k^2 $

#pause

Thus $q$ is even as well.

#pause

Now both $p$ and $q$ are even, contradicting that $frac(style: "skewed", p, q)$ was in lowest terms.

#pause

Therefore, $sqrt(2)$ is irrational. #h(1fr) #text(font: "New Computer Modern Math", sym.qed)

#v(3fr)

== Euler's formula

Expand the exponential, then collect its real and imaginary terms:

$
  e^(i x) & = sum_(n=0)^infinity frac((i x)^n, n!) \
    pause & = 1 + i x - frac(x^2, 2!) - i frac(x^3, 3!) + frac(x^4, 4!) + dots.c \
    pause & = (1 - frac(x^2, 2!) + frac(x^4, 4!) - dots.c) + i (x - frac(x^3, 3!) + dots.c) \
    pause & = cos x + i sin x
$

#pause

Set $x = pi$. Since $cos pi = -1$ and $sin pi = 0$:

$ e^(i pi) = -1 + i dot 0 = -1 $

#pause

Therefore, $ e^(i pi) + 1 = 0 $

== Emphasize a message

Use a focus slide to give an important takeaway room to stand out.

#focus-slide[
  Make the next step obvious.
]

== Add appendix material

Put supporting details after the main presentation with `#appendix`.

This marks the material as appendix content and freezes slide numbering.

See the #ilink(<appendix>)[Appendix] for examples.

#appendix[= Appendix <appendix>]
