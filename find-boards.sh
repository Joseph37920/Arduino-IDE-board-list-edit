#!/bin/bash
# find all "boards.txt" files in all libraries
# you may want to run "updatedb" utility before runing this script
# updatedb will make sure all "boards.txt" files are found
locate '/boards.txt' > boards.txt.file.list
filename='boards.txt.file.list'
n=1
# process the boards.txt files one at time
# cleanup the owner file
rm owner.txt
while read line; do
# reading each line
echo "File No. $n : $line"
# use captured path-and-file
# build a list of the owner of the board file and the attributes
ls -l "$line" >> owner.txt
# copy the file for processing
cp "$line" temp.file
n=$((n+1))
# process the current file
# make a list of all the boards in the temp.file
grep '.name=' temp.file  >> boards-file
# end the "do" loop
done < $filename
# now we have the names of all the boards defined in all the "boards.txt" files
# sort and remove duplicate entries
sort -u boards-file > boards.defined.file
# clean up some files
rm boards-file
rm temp.file
# end of finding boards
STR=$'\n\n\n\n\r'
echo "$STR"
echo "Boards Defined for this install of Arduino IDE are in 'boards.defined.file'"
echo "Use this file to add the named boards you wish keep to the"
echo "\"boards.keep.file\" this file should be built [or added to]"
echo " to name the boards that you"
echo "want to keep in the \"Boards\" display drop down list."
echo "The format for a line in this file is a \"[board].hide=\"."
echo "Build from the left string in the \"boards.defined.file\""
echo "before the <.name=> string. The board descriptive "
echo " name is on the right side of the line in 'boards.defined.file'."
echo "Example: 'arduino-esp8266.name=Arduino'"
echo "becomes 'arduino-esp8266.hide='- - sorry about the inverted logic."
echo " This format is a side effect of the compare routine in 'merge.awk'."
echo " The 'boards-keep-file' will allow updates after additions to the IDE by"
echo " upgrades etc. without having to build a new keep file."
