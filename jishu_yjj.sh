#!/bin/bash
#testjishu

count=0

for i in `ls`
do
    count=$count+1
done
echo $count

count=0
for i in `ls`
do
    count=`expr $count + 1`
done
echo $count

count=0
for i in `ls`
do
    count=$((count+1))
done
echo $count

count=0
for i in `ls`
do
    ((count=$count+1))
done
echo $count
