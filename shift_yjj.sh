#!/bin/bash
# test for shift

#while [ $# -ne 0 ]
#do
    #echo "$1"
    #shift
#done

# use "eval" print the last parameter
eval echo "the last parameter is:" \$$#

while [ $# -ne 0 ]
do
    echo "$@"
    shift
done
