#!/bin/bash

SRC="$1"
DEST="$2"

cat "$SRC" |\
sed -e 's/\\label[{][^}]\+[}]//g; s/\\pageref[{][^}]\+[}]/FIXME:pageref/g' |\
sed 's/\\verseref[{]\([^}]\+\)[}]/\1.\\\\/g' |\
pandoc --smart --normalize --from=latex --to=markdown |\
sed 's/\([^\\]\)\\$/\1\\\\/' > "$DEST"

