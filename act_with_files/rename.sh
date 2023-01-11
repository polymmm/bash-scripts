#!/bin/sh
select i in * ; do break; done
mv "$i" "01$i";
