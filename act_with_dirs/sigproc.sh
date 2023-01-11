#!/bin/sh
a=0
trap "echo SIGQIT received; mv -f temp temp0$a; echo This file created by $0 procedure >temp; continue" 3
trap 'echo SIGINT received; rm temp; exit' 2
echo This file created by $0 procedure >temp
while test $#=0
do
	a=$((a+1))
	sleep 30
done

