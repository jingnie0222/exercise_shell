#!/bin/bash
#testfor

#set -x

list1="a b c d"
list2="1 2 3 4"

for i in $list1
do
    for j in $list2
    do
       echo -ne "$i:$j "
    done
done

#set +x
echo

