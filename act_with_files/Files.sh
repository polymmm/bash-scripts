#!/bin/sh
echo Part 1
ls -l 
ls -l /home/polym/Desktop
ls -i
ls -l /usr/bin/passwd
ls -t
echo Part 2
umask
umask 22
ls -l
echo Part 3
chmod 0 /home/polym/Desktop/testfile
chmod a+rw /home/polym/Desktop/testfile
chmod u+x /home/polym/Desktop/testfile
chmod +s /home/polym/Desktop/testfile
