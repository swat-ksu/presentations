#import "template.typ": *
#import touying: *
#import theme: *

#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.10": codly-languages

#show: codly.theme("github-light")
#show: codly.lang-set_(
  languages: codly-languages,
  display-icon: true,
  fill: lang => none,
  stroke: lang => none,
)

#show: swat-doc.with(
  title: [Example Presentation Document],
  subtitle: [How to use The Template],
  authors: authors(
    author(
      "Adrian Valcarcel-Schott",
      gh: "avalsch",
      site: "avalsch.dev",
    ),
  ),
)

#title-slide()

== Getting Started

#codly.new(
  ```typ
  #import "../template.typ": *

  #show: swat-doc.with(
    title: [My Presentation],
    authors: authors(
      author(
        "My Myself",
        site: "example.com"
      )
    )
  )

  #title-slide()

  == First Slide
  ```,
  file: "document.typ",
)

== Shell Nonsense

#pause

/ My takeaway: We should all be shell masters.

== Let's do Some Math!

$
  integral_(-infinity)^infinity e^x^2 dif x
  #pause & = lim_(r -> -infinity) integral_r^infinity e^x^2 dif x \
  #pause & = lim_(s -> infinity) lim_(r -> -infinity) integral_r^s e^x^2 dif x
$

== The End

#mid[
  #strong(text(1.6em)[Thank you])

  #v(1em)

  #text(1em)[Questions, comments, suggestions, ideas, and pushback are all welcome.]
]
