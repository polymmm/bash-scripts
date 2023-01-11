#!/bin/sh
if test $# -gt 0
then
	case $1$2 in
		-[abc]-[123]) echo "flag $T" ;;
		-[123]-[abc]) echo "flag $T" ;;
		-*) echo "unknown flags $1 $2" ; exit ;;
		[!-]*)echo "unexpected arguments $1 $2" ; exit ;;
	esac
else
	echo testflags: flag missing ; exit
fi

