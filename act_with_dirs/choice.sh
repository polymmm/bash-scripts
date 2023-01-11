#!/bin/sh
[[ $# -eq 0 ]] && { echo "Add argument with the directory to copy to"; exit;}
[[ -f "$1" ]] && { echo "$1 is not a directory"; exit;}
[[ -d "$1" ]] || mkdir $1
pick() {
	for i in $(find . -maxdepth 1 -type f)
	do
		echo -n "$i ?">/dev/tty
		read response
		case Sresponse in
			Y*|y*) cat $i > "$1/$i";;
			Q*|q*) break;;
		esac
	done
}
a=`ls`
b=`pick $a`
$b
