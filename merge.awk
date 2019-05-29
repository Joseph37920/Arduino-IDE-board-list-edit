BEGIN {
l_eof=0;
board_found=0;
x=0;
file="boards-keep-file";
while(( getline line < file ) > 0 ) {
#print line
list[x]=line;
x++;
}
}


#program
{
temp = $0;
for(i in list){
  str=list[i];
  if(temp == str){board_found=1;}
} #for in list
if(board_found != 0){board_found=0;}else{print $0;}
} # program


