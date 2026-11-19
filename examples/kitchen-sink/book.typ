// A stress test for the template: every feature, plus the ordinary Typst
// content a real book uses. Build it the same way as a book:
//   typst compile book.typ
//   typst compile --features bundle,html --format bundle book.typ site
#import "@local/craken:0.1.0": *

#show: book.with(
  title: [The Kitchen Sink],
  subtitle: [Everything the template can do, on one shelf],
  author: "Captain Craken",
  logo: read("assets/captain-craken.png", encoding: none),
  pdf: "book.pdf",
  description: [
    This book exists to break things. Every chapter puts the template's pieces next to each other, so the web and PDF editions can be compared side by side.
  ],
  homepage: "https://example.com",
  series: [A Captain Craken test book],
)

#chapter("graphs", include "chapters/graphs.typ")
#chapter("sorting", include "chapters/sorting.typ")
#chapter("probability", include "chapters/probability.typ")
