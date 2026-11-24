#!/bin/sh
# Installs the Captain Craken template for Typst (Linux and macOS):
#   • the package, so `@preview/craken-book:0.2.0` works offline and `typst init` can start new books
#   • the fonts, so you never need --font-path
# Run it again after updating the template; it overwrites the old copy.
# It installs into the preview namespace, so the template's @preview imports
# work offline too (Typst checks this folder before downloading).
set -e
here="$(cd "$(dirname "$0")" && pwd)"

case "$(uname)" in
  Darwin) data="$HOME/Library/Application Support"; fonts="$HOME/Library/Fonts/craken" ;;
  *)      data="${XDG_DATA_HOME:-$HOME/.local/share}"; fonts="$data/fonts/craken" ;;
esac
dest="$data/typst/packages/preview/craken-book/0.2.0"

mkdir -p "$dest" "$fonts"
cp -R "$here/." "$dest/"
cp "$here"/fonts/*.ttf "$fonts/"
if command -v fc-cache >/dev/null 2>&1; then fc-cache -f "$fonts" >/dev/null; fi

echo "Captain Craken installed."
echo "  package: $dest"
echo "  fonts:   $fonts"
echo
echo "Start a new book with:"
echo "  typst init @preview/craken-book:0.2.0 my-book"
