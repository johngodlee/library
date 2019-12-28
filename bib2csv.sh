#!/bin/bash

bibtex_san () {
	grep -E "^\s+$1" books.bib | sed "s/\(\s*$1\s=\s\|{\|},\|}\)//g" | sed 's/\\\&/\&/g' | sed 's/\\.//g' | sed 's/,$//g' | while read -r line ; do if [ -z "$line" ]; then echo '"NA"' ; else echo "\"$line\"" ; fi ; done
}

SAVEIFS=$IFS
IFS=$'\n'
editor=($(bibtex_san "editor"))
author=($(bibtex_san "author"))
title=($(bibtex_san "title"))
year=($(bibtex_san "year"))
publisher=($(bibtex_san "publisher"))
address=($(bibtex_san "address"))
isbn=($(bibtex_san "isbn"))
lc=($(bibtex_san "lc"))
IFS=$SAVEIFS

rows=$(echo $(seq 0 $((${#editor[@]}-1)))) 

> books.csv

echo "editor,author,title,year,publisher,address,isbn,lc" >> books.csv

for i in $rows; do
	echo "${editor[$i]},${author[$i]},${title[$i]},${year[$i]},${publisher[$i]},${address[$i]},${isbn[$i]},${lc[$i]}" >> books.csv
done
