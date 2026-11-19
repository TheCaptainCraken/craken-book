#import "@local/craken:0.2.0": *

#show: book.with(
  title: [Recursion for Humans],
  subtitle: [A friendly walk through functions that call themselves],
  author: "Pietro Agnoli",
  logo: read("assets/captain-craken.png", encoding: none),
  pdf: "book.pdf",   // site only: copy book.pdf into the site folder
  description: [
    Recursion is the idea that a problem can be solved by trusting a smaller copy of itself. It shows up everywhere in computer science, and it feels like magic until it suddenly doesn't.

    This book builds that intuition slowly, with tiny examples, pictures and plenty of chances to try things yourself. You'll need a little Python and no fear of a few equations.
  ],
  homepage: "https://pietroagnoli.com",
  series: [A Captain Craken book],
)

// One line per chapter: the name of its web page, then its file.
#chapter("recursion", include "chapters/recursion.typ")
#chapter("divide-and-conquer", include "chapters/divide-and-conquer.typ")
