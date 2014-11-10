#!/bin/bash

USAGE="Usage:
tex2html.sh SRC_DIR DEST_DIR"

if [ ! -d "$1" -o ! -d "$2" ]; then
    echo $USAGE
    exit 2
fi

SRC_DIR="$1"
DEST_DIR="$2"

for i in "$SRC_DIR"/*.tex
do
    echo "$i"
    outname=$(echo `basename "$i"` | sed 's/\.tex$/.html/')
    cat "$i" |\
    ruby -e 's ||= "";
while gets
    s += $_
end
s.gsub!(/\\begin[{]quotepage[}][{][^}]+[}][{]([^}]+)[}](.*)\\end[{]quotepage[}]/m, "\\begin{quote} \\2 \\par \\1\n\\end{quote}")
s.gsub!(/\\chapterNote[{]([^}]+)[}](.*\\chapter[{][^}]+[}])/m, "\\2 \\par \\emph{\\1}")
s.gsub!(/\\chapterAuthor[{]([^}]+)[}](.*\\chapter[{][^}]+[}])/m, "\\2 \\par \\emph{\\1}")
s.gsub!(/\\speaker[{]([^}]+)[}]/, "\\emph{\\1}")
s.gsub!(/\\thai[{]([^}]+)[}]/, "\\1")
s.gsub!(/\\mbox[{]([^}]+)[}]/, "\\1")
s.gsub!(/\\newline */, "\\\\ ")
s.gsub!(/\\enlargethispage[{][^}]+[}]/, "")
s.gsub!(/\\begin[{]glossarydescription[}]/, "\\begin{description}")
s.gsub!(/\\end[{]glossarydescription[}]/, "\\end{description}")
s.gsub!(/\\item\[[{][{]([^}]+)[}][{]([^}]+)[}][}]\]/, "\\item[\\1, \\2]")
puts s' |\
    pandoc -f latex -t html --smart --parse-raw > "$DEST_DIR/$outname"
done

