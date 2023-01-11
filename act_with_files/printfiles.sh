#!/bin/sh
res=""

for i in $(find . maxdepth 1 -name "а*[0-9]")
do
	echo File "$i"
	pr "$i" --omit-header --columns=3
done

