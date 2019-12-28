#!/bin/bash

latexmk -pdf books.tex
# latexmk -C

pandoc --filter pandoc-citeproc --csl /Users/johngodlee/.texmf/apa.csl --standalone books.md -o books.html

sed -n "20,860p" books.html | pandoc -f html -t markdown_strict -o index.md

pandoc -f html -t plain --columns=68 -o books.txt books.html

