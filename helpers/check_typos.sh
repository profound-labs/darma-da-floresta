#!/bin/sh
# check for typical typos in the body text

# find un-accented spelling of Pali
grep -iE -f pali_typos ./*.tex

# find - instead of -- in mid-sentence
grep -E '[^[:alpha:]0-9-]-[^[:alpha:]0-9-]' ./*.tex
# %s/\([^[:alpha:]-]\)-\([^[:alpha:]-]\)/\1--\2/gc

# find - as speech mark instead of --
grep -E '^\s*- ' ./*.tex
# sed -i 's/^\s*- /-- /g' ./*.tex

# find ... instead of \ldots{}
grep -E '\.\.\.' ./*.tex

# find un-smart single and double quotes
grep -E " '{1,2}\w" ./*.tex
grep -E "\w'{1,2}" ./*.tex
grep -E ' "{1,2}\w' ./*.tex
grep -E '\w"{1,2}' ./*.tex
grep -E "’’" ./*.tex
# %s/ '\{1,2\}\(\w\)/ `\1/gc
# sed -i 's/ '"'"'\(\w\)/ `\1/g' ./*.tex

# \textit{sati –}
# \textit{sati,}
grep -E '[,–-][}]' ./*.tex
# sed -i 's/\( *[,–-]\+\)[}]/}\1/g' ./*.tex

# "\textit{word"} -- may be correct in footnote
# (\textit{mettā)} -- may be correct in footnote
# fix manually
grep -E '[\)'"'"'’"”][}]' ./*.tex

# find quote marks in front of puctuation, word".
grep -E '[^[:punct:]]['"'"'’"”][[:punct:]]' ./*.tex
# sed -i 's/\([^[:punct:]]\)\(['"'"'’"”]\+\)\([[:punct:]]\)/\1\3\2/g' ./*.tex
#
# Should you bother? Yes. It can put holes in the color of a text block.
# To appriciate the uneven negative space, look at it in large size. If
# you feel the large size is unbalanced, the small size is unbalanced
# too.

# as above, but with ): “yáng)”. -- may be correct
# fix manually
grep -E '\)['"'"'’"”][[:punct:]]' ./*.tex

# find escaped spaces at beginning of lines (conversion artefact)
grep -E '^\s\\ ' ./*.tex

# find trailing spaces in brackets (conversion artefact)
grep -E ' [}]' ./*.tex
# It is safe to fix the type of '\textit{pāramī }que', use manual check
# for others.
# sed -i 's/\(\w\) [}]\(\w\)/\1} \2/g' ./*.tex

# find weird spaces (coversion artefacts)
# FIXME: this isn't the syntax
#grep -E "[\x{200B}\x{000A}]" ./*.tex

# will not match a footnote w/ {} inside
grep -E '\\footnote\{[^}]+\}[,;:.?!]' ./*.tex
# TODO: use a multiline regex and match three nested manually
#grep -E '\\footnote\{[^}]+\}[,;:.?!]' ./*.tex | grep -E '\\footnote\{[^}]+[{}[^}]+\}[^}]+[\},;:.?!]'

