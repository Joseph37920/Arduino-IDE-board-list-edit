#!/bin/bash
# **************   version 2 of "hide-boards.sh ******************************
# run "find-boards.sh" before this script
# it will generate a curent "boards.txt.file.list" file
# process the boards.txt files one at time
# to produce a back file list

# boards.txt.file.list has all "boards.txt" files with a full path from root.
# some of these files are copies and others in the "trash" folder etc.
# test each of the boards.txt in the boards.txt.file.list
# and make a backup copy only of files that are to be kept. See test[0-4] for
# rejected files
filename='boards.txt.file.list'
n=1
# setup the files to be rejected based on strings in their access path
test0="txt.py"
test1="boards-cull-pgm"
test2="Trash"
test3="boot-low"
test4="boot-hold"
go=0
# make backup copies of all the files that are to be modified by adding the "hide" command
# this will make it easy to restore these files if need be
# also processing can be done using the backup file as input
rm backup.board.list
while [ $go -le 1 ] 
do
# remove any "backup-board-# file in this folder
r_file="backup-board-$n"
if [ -f "$r_file" ]; then
   echo "removed $r_file"
   rm $r_file
else
   go=2
fi
   n=$((n+1))
done
# begin the construction of the backup files in this folder
n=1
while read line; do
# reading each line
if [[ ($line =~ $test0) || ($line =~ $test1) || ($line =~ $test2) || ($line =~ $test3)|| ($line =~ $test4)  ]];
then
   echo "$line will NOT be copied"
else
   {
#   echo "$line WILL be copied"
   echo "$line" >> backup.board.list
   cp "$line" "backup-board-$n"
   n=$((n+1))
   }
fi
# $filename is the "boards.txt.file.list"
done < $filename
# use captured path-and-file
# build a list of the owner of the board file and the attributes
# this is for reference in case somebody is owned by "root" for another user
# cleanup the owner file
rm owner.txt
while read line; do
# reading each line
ls -l "$line" >> owner.txt
done < $filename
###################################################################################
####  This is the point where each of the board files are modified to have
####  the boards all the boards "hidden" except those in the "keep-board-list"
####  by adding the "hide" commands to the end of the boards.txt file 
# use the "backup.board.list" to iterate through all the "boards.txt" files
# to add the hidden.boards to each of the
# "boards.txt" files found
STR=$'\n\n\n\n\r'
echo "$STR"
filename='backup.board.list'
n=1
while read line; do
# copy the file for processing
# remove all the hide board command lines
sed -i '/.hide=/d' "$line"
# now get the boards defines in this "boards.txt file into a list
grep '.name=' "$line"  > boards-file
# remove temp.file - if it exists ( it won't first time through )
local_file="temp.file"
if [ -f "$local_file" ]
then
  {
  rm temp.file
  }
fi
# edit the "boards-file" removing ".name=" and all text to the right
sed -e 's/.name=.*//'  boards-file > temp.file
# add the ".hide=" phrase to the boards-file via the temp.file
rm boards-file
sed -e 's/$/.hide=/' temp.file > boards-file
rm temp.file
# modify the boards-file using the keep-board-file
# doing this in awk because it is simpler
awk -fmerge.awk boards-file > temp.file
rm boards-file
mv temp.file boards-file
# add the new hidden boards to the original "boards.txt" file
cat "$line" 'boards-file' >temp.file
rm "$line"
cp temp.file "$line"
echo "Replaced $line with hide board mods" 
# end the "do" loop
done < $filename
rm temp.file

###################################################################################
# if something goes wrong that can't be corrected by edits of the boards-keep-file
# all the "boards.txt" files are kept as a back the
# names and paths can be found in the "backup.board.list"
# you can use the "restore.sh" script to copy the saved "boards.txt" files back
# into the respective locations that they were taken from, PROVIDED that you
# DO NOT ALTER THE FOLLOWING FILES IN THIS FOLDER
# backup.board.list
# any file "backup-board-#" (where # is a digit, or digits)
# and the script "restore.sh in this folder


