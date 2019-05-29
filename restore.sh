#!/bin/bash
# Restore.sh - this will use the files:
# backup.board.list
# backup.board-#  where # is a digit or digits
# to restore the boards.txt file to their original contents

# use the "backup.board.list"
# restore the original "boards.txt" file to their 
# original locations
filename='backup.board.list'
n=1
while read line; do
# copy the file for processing
cp "backup-board-$n" temp.file
echo "backup-board-$n moved to temp.file"
# remove all the hide board command lines
# that may be lurking in the data
sed -i '/.hide=/d' temp.file
echo "will copy temp.file to $line"
cp temp.file "$line"
n=$((n+1))
done < $filename



