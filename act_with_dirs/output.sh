#!/bin/sh
echo Task 1
cat /home/polym/Desktop/testfile
cat -n /home/polym/Desktop/testfile
cat /home/polym/Desktop/testfile /home/polym/Desktop/filetest

echo Task 2
pr -l 30 -2 -n: /home/polym/Desktop/testfile
pr -t -4 -n: /home/polym/Desktop/testfile

echo Task 3
more /home/polym/Desktop/testfile
more -c /home/polym/Desktop/testfile

echo Task 4
tail -30c /home/polym/Desktop/testfile
tail +25 /home/polym/Desktop/testfile

echo Task 5
cut -c2-4,7-8 /home/polym/Desktop/testfile
cut -d” ” -f2 /home/polym/Desktop/testfile

echo Task 6
sort +1 -1 /home/polym/Desktop/testfile

echo Task 7
cmp /home/polym/Desktop/testfile /home/polym/Desktop/filetest
diff /home/polym/Desktop/testfile /home/polym/Desktop/filetest

echo Task 8
du -s -b /home/

echo Task 9
wc -l -w -c /home/polym/Desktop/testfile

echo Task 10
find /home/polym/Desktop -type f -size -15c -and -size +1c -exec cat {} \;


