#!/bin/sh
read name 
echo -n "File:" "$name" "\n"
echo -n "Lines:" "$(wc -l <$name)" "\n"
echo -n "Words:" "$(wc -w <$name)" "\n"
echo -n "Symbols:" "$(wc -m <$name)" "\n"

