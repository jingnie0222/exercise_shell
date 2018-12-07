#!/bin/bash
#test elif

echo "enter your logname:"
read LOGNMAE

if [ -z "$LOGNMAE" ];then
   echo "you don't enter logname"
elif [ "$LOGNMAE" == "root" ];then
   echo "your logname is $LOGNMAE"
elif [ "$LOGNMAE" == "guest" ];then
   echo "your logname is $LOGNMAE"
else
   echo "your logname is neither root nor guest"
fi

exit 0
