#!/bin/sh
#test shell's parameters

echo "PID of the script is $$"
echo "name of the script is $0"
echo "the first paremeter is $1"

if [ $# -eq 0 ]
then
    echo -e "No parameters~"
else
    echo -e "There are $# parameters"
    echo -e "the \$* is:$*"
    echo -e "the \$@ is:$@"
fi

#use $*
for i in $*
do
    echo $i
done

#use $@
for i in $@
do
    echo $i
done

#use $#

for((i=0; i<$#; i++))
do
    echo "$i"
done
