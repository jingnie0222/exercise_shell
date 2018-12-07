#!/bin/bash
#testwhile

#read from keyboard

echo "enter your most liked film:"
while read FILM
do 
    echo "yeah,your most liked film is:$FILM"
    break
done


#read from file:ttt0

while read LINE
do
    echo $LINE
done<ttt0 


#read 2 records once from file:ttt0

count=1
while read REC1
do
    read REC2
    echo "this is record one of $count pair:$REC1"
    echo "this is record two of $count pair:$REC2"
    echo "---------------------------------------"
    count=`expr $count + 1`
done < ttt0
    
