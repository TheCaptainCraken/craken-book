// A stress test for the template: every feature, plus the ordinary Typst
// content a real book uses. Build it the same way as a book:
//   typst compile book.typ
//   typst compile --features bundle,html --format bundle book.typ site
#import "@preview/craken-book:0.2.0": *

#show: book.with(
  title: [The Kitchen Sink],
  subtitle: [Everything the template can do, on one shelf],
  author: "Captain Craken",
  logo: read("assets/captain-craken.png", encoding: none),
  cover: read("assets/cover.png", encoding: none),   // not the logo: a wide picture
  cover-alt: "Rings and dots in coral, moss and amber",
  cover-width: 100mm,
  frontispiece: [A cover that is not the logo, to check any picture fits.],
  pdf: "book.pdf",
  description: [
    This book exists to break things. Every chapter puts the template's pieces next to each other, so the web and PDF editions can be compared side by side.
  ],
  homepage: "https://example.com",
  series: [A Captain Craken test book],
)

#part[Structures and algorithms]
#chapter("graphs", include "chapters/graphs.typ")
#chapter("sorting", include "chapters/sorting.typ")

#part(intro: [A part can open with a few words of its own, set like a lede.])[Chance]
#chapter("probability", include "chapters/probability.typ")
