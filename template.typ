#import "@preview/octique:0.1.1": octique-inline
#import "@preview/touying:0.8.0" as touying: themes.metropolis as theme

#import theme: metropolis-theme, title-slide

// old (KSU)
#let swat-colors = (
  neutral: rgb("#b0b3b2"),
  primary-light: rgb("#ffc629"),

  primary: black,

  tertiary: rgb("#00843d"),

  secondary: rgb("#1c1c1c"),
  neutral-dark: rgb("#161616"),
  neutral-darkest: rgb("#111111"),

  neutral-lightest: white,
)

// new (SwAT)
#let swat-colors = (
  neutral: rgb("#615d59"),
  neutral-dark: rgb("#2d2926"),

  neutral-darkest: rgb("#111111"),

  primary: rgb("#e8794a"),
  primary-light: rgb("#ffc629"),

  secondary: rgb("#2d2926"),

  tertiary: rgb("#00a2ac"),
  tertiary-light: rgb("#00afa9"),

  neutral-lightest: white,
)


#let _emoji(..args) = octique-inline(..args, width: 0.8em, baseline: 15%)


#let _social(ico, lnk, pfp) = {
  [
    #_emoji(ico, color: swat-colors.neutral-dark)
    #text(fill: swat-colors.primary-light, baseline: 1pt)[/]
    #link(lnk + pfp, pfp)
  ]
}


#let _socials = (
  gh: gh => _social("mark-github", "https://github.com/", gh),
  site: site => _social("globe", "https://", site),
  mail: mail => _social("mail", "mailto:", mail),
)


#let _author(name: str, ..args) = {
  name

  for (social, val) in args.named().pairs().sorted() {
    linebreak()
    _socials.at(social)(val)
  }
}


#let _authors(authors) = {
  show: set align(top + left)

  stack(
    dir: ltr,
    spacing: 1.2em,
    ..authors.map(a => _author(..a)),
  )
}

#let author(name, ..args) = (name: name, ..args.named())


#let swat-logo(color: swat-colors.primary-light, ..args) = image(
  bytes(
    read("assets/swat_logo.svg").replace("black", color.to-hex()),
  ),
  ..args,
)


#let swat-doc(
  title: none,
  subtitle: none,
  authors: (),
  ..args,
  body,
) = {
  if type(authors) != array {
    authors = (authors,)
  }

  set document(title: title, author: authors.map(a => a.name))

  show: metropolis-theme.with(
    aspect-ratio: "3-2",
    footer: self => self.info.institution,
    touying.config-info(
      title: smallcaps(title),
      subtitle: subtitle,
      author: none,
      institution: [SwAT @ Kennesaw State University],
      logo: context if here().page() == 1 {
        square(fill: swat-colors.secondary, swat-logo(height: 0.8em))
      } else {
        swat-logo(height: 0.8em)
      },
    ),
    touying.config-colors(..swat-colors),
    touying.config-methods(
      init: (self: none, body) => {
        // metropolis theme recommended styles
        set text(font: "Fira Sans", weight: "light", size: 20pt)
        show math.equation: set text(font: "Fira Math")
        show raw: set text(font: "Fira Mono")
        set strong(delta: 100)
        set par(justify: true)

        body
      },
    ),
    touying.config-common(
      // article-theme: TODO(@avalsch): add proper article export support
    ),
    ..args,
  )

  touying.slides-only(theme.title-slide(author: _authors(authors)))

  body
}
