#! /bin/sh
echo Task 1
type ls cat test send open read

echo Task 2
ls -a -l 1>res 2>protocol

echo Task 3
ls -a >temp
wc -l <temp

echo Task 4
wc -l ???
wc -l a*
wc -l *file*
wc -l [!0-9]
wc -l *[0-9]*
wc -l [a-z]*[0-9]

echo Task 5
ls | pr -t3
ls -I | sort
ls | wc ??

