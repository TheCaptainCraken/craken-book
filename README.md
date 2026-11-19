# Captain Craken: Typst book template

One source, three editions of the same book, all in the Captain Craken design system:

- **PDF (default):** A4 pages made for reading on a screen. It's one-sided with the margin column always on the right, slightly larger type, and no blank pages. Cross-references are clickable and coloured. Answers to questions move to the chapter's solutions, with links there and back.
- **Print:** the ready-to-print book. It uses a 189 × 246 mm page and is two-sided, with the margin column on the outer edge. Chapters open on right-hand pages, and answers are printed upside-down under their questions.
- **Web:** a static site. It has a home page, one page per chapter, margin notes, answers and solutions that stay hidden until the reader opens them, browser equations, and a Paper/Lantern switch.

Any PDF can also use the dark Lantern theme. Tested with Typst 0.15.1.

## Install

Unzip, then run the install script once:

```sh
unzip craken-typst-template.zip && cd craken
./install.sh
```

The script does two things:

- **The package:** it copies the template to `~/.local/share/typst/packages/local/craken/0.2.0/` (on macOS, `~/Library/Application Support/typst/packages/local/craken/0.2.0/`).
- **The fonts:** it installs them for your user, so you never need `--font-path`.

Run it again whenever you update the template.

On Windows, copy the folder to `%APPDATA%\typst\packages\local\craken\0.2.0\` and install the `.ttf` files in `fonts\` by double-clicking them.

## Start a book

```sh
typst init @local/craken:0.2.0 my-book
cd my-book
```

This gives you `book.typ`, a `chapters/` folder with two sample chapters, and `assets/` with the logo. Every file starts with `#import "@local/craken:0.2.0": *`.

## Build

From inside your book's folder:

```sh
# A4 PDF for reading
typst compile book.typ

# ready-to-print book
typst compile --input edition=print book.typ book-print.pdf

# either one in the dark theme
typst compile --input theme=lantern book.typ book-dark.pdf

# the website, into site/, with the PDF its "Download" tab points to
typst compile --features bundle,html --format bundle book.typ site
typst compile book.typ site/book.pdf

# write with a live preview of the site at http://localhost:3000
typst watch --features bundle,html --format bundle book.typ site
```

To publish, upload the `site/` folder to any static host: GitHub Pages, Netlify, Cloudflare Pages, or a folder under your own domain.

Website output is still experimental in Typst, and the Typst web app can't build the site or pass `--input`. To make the web app produce the print edition, change `default: "pdf"` to `default: "print"` on the `edition` line near the top of `craken.typ`.

## Write a book

`book.typ` holds the settings and lists the chapters. Each chapter lives in its own file under `chapters/`.

```typst
#show: book.with(
  title: [...], subtitle: [...], author: "...",
  logo: read("assets/captain-craken.png", encoding: none),   // read here, so the package can use it
  cover: read("assets/cover.jpg", encoding: none),   // title page picture (leave out: the logo; none: no picture)
  cover-alt: "...",              // site: what the cover shows, for screen readers
  cover-width: 80mm,             // PDF: the cover's width (default 54mm, print 44mm)
  pdf: "book.pdf",               // site: the "Download the PDF" tab
  description: [...],            // site: opens the letter to the reader
  homepage: "https://...",       // site: imprint line and footer
  series: [A Captain Craken book],   // site: a line above the title
  frontispiece: [...],           // site: caption under the cover
  note: auto,                    // site: the letter (auto, your own content, or none)
)

#chapter("recursion", include "chapters/recursion.typ")   // → recursion.html
```

A longer book can be divided into parts. Put `#part[…]` before the first chapter of each part; chapters keep their numbers across parts:

```typst
#part[Foundations]
#chapter("recursion", include "chapters/recursion.typ")
#chapter("divide-and-conquer", include "chapters/divide-and-conquer.typ")

#part(intro: [A few words that open the part.])[Going further]
#chapter("dynamic-programming", include "chapters/dynamic-programming.typ")
```

In the PDFs a part gets its own title page (on a right-hand page in print) and a line in the contents above its chapters. On the site it heads its chapters in the home page's contents, and a part banner opens its first chapter.

The site's home page is the front of a book, built for you:

- **An open book.** On the left page is your cover picture (the logo unless you pass `cover`) as a framed frontispiece with its caption. Any shape of picture fits. On the right is the title page, set centred: series line, title, subtitle, author and imprint. Two index tabs stick up from the top edge of the right page, "Read online" and "Download the PDF".
- **A letter to the reader.** It opens with a drop cap and your `description`, then explains Tips, Questions, Try this and exercise ratings in running text, and is signed with your name. Pass `note: [...]` to write your own letter.
- **Contents,** set like a contents page. Each chapter shows its coral number, title, its `#lede` in italic, its sections and its exercise count. Parts, if the book has them, head their chapters.

| You write | PDF | Web |
| --- | --- | --- |
| `= Title` | Chapter opener on a new page (right-hand in print) | Chapter header with the coral numeral |
| `== Title`, `=== Title` | Numbered section, subsection | Same |
| `#lede[…]` | The chapter's first paragraph, larger | Same |
| `#note[…]` | Numbered margin note (A4: right; print: outer side) | Margin note; drops under its line on phones |
| `#dfn[term]` | Italic semibold new term | `<dfn>` |
| `#tip[…]`, `#try-this[…]` | Callouts in amber and moss | Same |
| `#question(answer: […])[…]` | A4: linked answer in the chapter's solutions; print: upside-down underneath | Answer behind a toggle |
| `$ … $ <eq:name>` | Numbered (chapter.n) only if labelled | MathML, same numbers |
| `#code(title: […], lang: […], numbers: true)[code block]` | Titled box, line numbers | Same, colours follow the theme |
| `#listing(caption: […], …)[code block]` | “Listing 1.2” with a caption | Same |
| `#figure(…, caption: […])` | Figure or table, numbered per chapter | Same; drawings become inline SVG |
| `#exercises[ #exercise(difficulty: 2, solution: […])[…] <ex:name> ]` | Rated 1–3, between hairlines | Solution hidden under each exercise |
| `#solutions()` | “Solutions” section for this chapter (with the A4 answers) | Nothing (they're under the exercises) |
| `- item`, `+ item` | Sucker bullets (coral, then open rings); numbers in rust | Same |
| `#sbreak()` | Three suckers | Same |
| `#part[…]` (in `book.typ`) | Part title page, listed in the contents | Heading in the home page's contents; banner on its first chapter |
| `#footnote[…]` | At the foot of the page | Listed at the end of the chapter |

`@labels` work across chapters in both editions: on the web they link to the right page.

## Files

- `craken.typ`: the template, all three editions. `typst.toml` makes the folder a Typst package.
- `template/`: what `typst init` copies into a new book.
- `examples/kitchen-sink/`: a test book that uses every feature (parts, footnotes, lists, quotes, tables, notes, answers in several chapters…), for checking that the PDF and the site still match after a change. Build it like a book, from its folder.
- `web/`: the site's stylesheet (`craken.css`, with the design system's tokens and `ck-*` components), its script (`craken.js`) and web fonts.
- `fonts/`: PDF fonts made for Typst (Fraunces Soft, Newsreader Text, DM Mono, STIX Two Math), all under the SIL Open Font License. They cover Latin, accents included.
- `themes/`: syntax colours for code in the PDFs and on the web.
- `install.sh`: installs the package and the fonts.

## Notes

- Drawings made with Typst shapes, like the call tree in chapter 1, appear on the web as SVG in Paper colours. On Lantern they sit on a paper-coloured card, like the logo.
- In the PDFs, margin notes push each other down when they would overlap, but they never move to the next page, so keep them short.
- PDF text is justified and hyphenated. Pass `justify: false` to `book.with(…)` for ragged right.
