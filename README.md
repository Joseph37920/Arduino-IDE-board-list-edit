# Arduino-IDE-board-list-edit
Select boards to be displayed by the drop down "boards" list.
This is three Linux shell scripts. It has been tested on 18.04 Bionic Beaver.

find-boards.sh - uses the "locate" to get all 'boards.txt' files on your machine and a sorted list of all the boards defined.

Edit the boards-keep-file using the boards.defined.file as a crib sheet, adding the boards you want to keep.

hide-boards.sh - use to append the string '<board>.hide=' to a boards.txt file to hide all the boards in the file except those that are listed in the 'boards-keep-file'. Then write the modified 'boards.txt' file back to its original location.
  
restore.sh - if something goes wrong this will restore all the 'boards.txt' files to their original state. It uses a 'backup.boards.list and N backup-board-# files having the original contents of the boards.txt files from the last use of 'hide-boards.sh.

Place all the code into a folder, add the execute bit to the shell scripts,start a terminal, cd to the folder.
The backup files for the restore are placed into this folder along with a 'backup.board.list' pointing to the boards.tst locations.

Good luck.

