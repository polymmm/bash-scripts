#!/bin/bash
declare -a arr
is_header=1
while read -r line; 
do
	time=$(echo "$line" | tr -s ' ' | cut -f1 -d ' ')
	if [[ $(expr length "$time" ) -gt 5 ]] || [[ $(printf "%.0f\n" "$(echo $time | cut -f1 -d ':')") -ge 2 ]]; 
	then
 		echo "$line" ;
		if [[ $is_header -eq 1 ]]; then is_header=0; continue; 
		fi
		arr+=($(echo $line | tr -s ' ' | cut -f2 -d ' '))
	fi
done < <( ps -eo etime, pid,user,command )
echo "$(whoami)"  "$$" "$0"
for i in "${arr[@]}"; 
do
	echo "Process:" "$(ps -p $i -o comm=)"
	echo "1. Set process priority"
	echo "2. Kill process"
	echo "3. Dont change anything"
	read -p ">" x
	case $x in
		1)y=20; echo "Priority must be between -20 and 19"
		while  [[ $y -lt -20 ]] || [[ $y -gt 19 ]]; do read -p ">" y; done
		renice $y $i;;
		2)kill -9 $(echo $line | tr -s ' ' | cut -f2 -d ' '); echo 'Process killed';;
		*)echo "Process hasn't been changed"; continue;:
	esac
done
