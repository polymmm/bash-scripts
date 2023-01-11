#!/bin/sh
counter=4+$(($#*2))
for i
do
	echo "echo $i>&2"
	res="$res\n$(cat $i)\n"
	lines=$(wc -l < $i)
	echo "head -n $(($counter-2+$lines)) \$0 | tail -n $lines > $i"
	counter=$(($counter+$lines+1))
done
echo "exit"
echo "$res"

