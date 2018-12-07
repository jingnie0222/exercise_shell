#!/bin/sh

var1="this					is	the	value	of	var1	!"
echo $var1
echo "$var1"

list1=("$@")
list2=("$*")
echo ${#list1[@]}
echo ${#list2[@]}
echo "\$-: $-"

export bbbbb="variable bbbbb"
./variable2.sh

echo "variable aaaaa:$aaaaa"
echo "variable bbbbb:$bbbbb"
echo "variable ccccc:$ccccc"

