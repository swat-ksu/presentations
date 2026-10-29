#import "../swat-doc.typ": swat-colors

#let ilink(dest, body) = link(
  dest,
  underline(text(fill: swat-colors.tertiary, body + sym.arrow.tr)),
)

