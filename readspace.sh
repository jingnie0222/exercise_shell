#!/bin/bash
#test read discard space

ifs=$IFS
IFS=

value_IFS=`echo "$IFS" | od -b`
echo $value_IFS

while read line
do
    echo $line
done<readspace_text

IFS=$ifs
