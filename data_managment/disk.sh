#!/bin/bash
[[ $EUID -ne 0 ]] && { echo "Run script as root"; exit; }
[[ ( -z $1) || ( -z $2) || (-z $3) || (-z $4) ]] && echo "No parameters" && exit
umount /dev/sdb 2>/dev/null
mkfs -t ext2 -b $1 -i $2 -L $3 /dev/sdb
[[ $? -ne 0 ]] && echo "Filesystem hasn't been created" && exit
badblocks -sb $1 /dev/sdb
mkdir "/mnt/$4"
mount -t ext2 /dev/sdb "/mnt/$4"
