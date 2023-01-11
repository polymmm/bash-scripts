#!/bin/sh
until false 
do
	touch ./lastwatch
	if find ~/mydir -cnewer ./lastwatch -type f
	then
		exit
	fi
done
