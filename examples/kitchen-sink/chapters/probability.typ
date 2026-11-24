#import "@preview/craken-book:0.2.0": *

= A short chapter on chance

== No lede here

This chapter has no lede, no exercises and no solutions, to check the pieces that are optional.#footnote[A plain Typst footnote, which is not part of the design system.] It links to #link("https://typst.app")[Typst's website] and back to @tbl:sorts.

#heading(level: 2, numbering: none)[An unnumbered section]

The probability that two dice add up to seven is $6 / 36 = 1 / 6$. Written as a display:

$ P(X + Y = 7) = sum_(k=1)^6 P(X = k) P(Y = 7 - k) = 6 dot 1/36 = 1/6. $ <eq:dice>

A short paragraph with *bold*, _italic_, `code`, a #dfn[random variable] and a long word like antidisestablishmentarianism, to check hyphenation.

#tip(label: [Remember])[A callout with a custom label.]
