#!/bin/sh
if test $# = 0
then
	cat=$(pwd)
else
	oldcat=$(pwd)
	cd $1
	cat=$(pwd)
	cd $oldcat
fi
echo "List from $cat:"
echo "Files: $(ls $cat | wc -l)"
echo "Directories: "
find $cat -mindepth 1 -maxdepth 1 -type d
echo
ls $cat | \
while read i
do
	if test -d $cat/$i
	then
		sh lsdir $cat/$i
	fi
done
