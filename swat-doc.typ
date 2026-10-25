#import "@preview/touying:0.8.0" as touying: themes.metropolis as theme

#import theme: metropolis-theme, title-slide

#import "@preview/octique:0.1.1": octique-inline


// TODO(@avalsch): add proper article export support
// TODO(@avalsch): add external speaker notes integration


/// SwAT color palette
#let swat-colors = (
  neutral: rgb("#615d59"),
  // neutral-dark: rgb("#111111"),
  // neutral-darkest: rgb("#111111"),
  neutral-lightest: rgb("#fafafa"),

  primary: rgb("#e8794a"),
  primary-light: rgb("#ffc629"),

  // secondary: rgb("#111111"),

  tertiary: rgb("#00a2ac"),
  tertiary-light: rgb("#00afa9"),

  neutral-dark: rgb("#2D2926"),
  neutral-darkest: rgb("#2D2926"),
  secondary: rgb("#2D2926"),
)


/// create an emoji inline
#let _emoji(..args) = octique-inline(
  width: 0.8em,
  baseline: 15%,
  ..args,
)

/// create a social tag: <emoji> "/" <[display](link)>
#let _social(ico, lnk, pfp) = {
  _emoji(ico, color: swat-colors.neutral-dark)
  h(0.2em)
  text(fill: swat-colors.neutral, baseline: 0.1em)[/]
  h(0.2em)
  link(lnk + pfp, pfp)
}

/// known socials/links
#let _socials = (
  gh: gh => _social("mark-github", "https://github.com/", gh),
  site: site => _social("globe", "https://", site),
  mail: mail => _social("mail", "mailto:", mail),
)

/// single author in the list. name + any socials
#let _author(name: str, ..args) = {
  name

  for (social, val) in args.named().pairs().sorted() {
    linebreak()
    _socials.at(social)(val)
  }
}

/// multiple authors, left to right
#let _authors(authors) = {
  show: set align(top + left)

  stack(
    dir: ltr,
    spacing: 1.2em,
    ..authors.map(a => _author(..a)),
  )
}


/// creates an author dict from a name and any links.
#let author(name, ..args) = (name: name, ..args.named())


/// show the swat logo. you can provide a primary and secondary color;
/// any other arguments will be forwarded to `image`
#let swat-logo(primary: swat-colors.primary, secondary: swat-colors.primary-light, ..args) = {
  image(
    bytes(
      read("assets/swat-logo.svg").replace("black", primary.to-hex()).replace("white", secondary.to-hex()),
    ),
    ..args,
  )
}


/// swat logo, with a square background if
/// we're on the title slide (first page)
#let _swat-logo = context if here().page() == 1 {
  square(
    fill: swat-colors.neutral-darkest,
    swat-logo(height: 0.8em),
  )
} else {
  swat-logo(height: 0.8em)
}


/// SwAT presentation theme.
/// 
/// Example:
///
/// ```typst
/// #show: swat-doc.with(title: [...], authors: author("First Last-Name"))
/// ```
///
/// - title (content): The presentation title
///
/// - subtitle (content): The presentation subtitle (if any)
///
/// Any other arguments will be forwarded to the Metropolis theme.
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
      institution: [SwAT #text(baseline: -0.1em)[@] Kennesaw State University],
      logo: _swat-logo,
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
    ..args,
  )

  touying.slides-only(theme.title-slide(author: _authors(authors)))

  body
}
