#!/bin/bash
# test while and fd

FILENAME=file1
FILENAME_BAK=file1.bak

if [ -s $FILENAME ];then
    exec 3<$FILENAME
    exec 4>$FILENAME_BAK
    
    while :
    do
       read LINE <&3
       if [ $? -ne 0 ];then
           exec 3<&-
           exec 4<&-
           exit
      fi
      echo $LINE>&4
    done

else
    echo "`basename $0`:$FILENAME is not exist or is empty"
fi
    
