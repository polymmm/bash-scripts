#!/bin/sh
echo Task 1
mkdir -m o=rwx mydir
mkdir dirA dirA/dirB

echo Task 2
rmdir -p dirA/dirB -v
touch file
rm file
touch file
chmod 444 file
rm file
mkdir catal catal/mycatal
touch /home/polym/catal/myfile
rm -r catal -v

echo Task 3
mkdir mydir mydir/dir1 mydir/dir2
touch /home/polym/mydir/dir1/file1
cp mydir/dir1/file1 mydir/myfile
chmod 777 mydir/myfile
cp mydir/myfile mydir/dir2/file2
echo ####################
ls -l mydir/dir1/file1
ls -l mydir/dir2/file2
echo ####################
mkdir mydir/dir3
cp -r mydir/dir1 mydir/dir2
cp -r mydir/dir1 mydir/dir3
ls mydir/dir2
ls mydir/dir3

echo Task 4
mv mydir/dir3 mydir/newdir
mv mydir/newdir/dir1/file1 mydir/newdir/dir1/newfile
mv mydir/newdir/dir1/newfile mydir/dir1/newfile

echo Task 5
cd mydir/
ln -P myfile hmyfile
ln -s myfile smyfile
ln -s dir2/dir1 sdir1
ln -P dir2/file2 hfile2
ln -P dir2/file3 hfile3

