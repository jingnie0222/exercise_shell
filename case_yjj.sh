#!/bin/bash
# test case

echo "enter an number:"
read NUM

case $NUM in
1)
echo "you input 1"
;;
2)
echo "you input 2"
;;
3)
echo "you input 3"
;;
4)
echo "you input 4"
;;
5)
echo "you input 5"
;;
*)
echo "`basename $0`: your input is not between 1 and 5"
;;
esac


echo "do you wish to process [y..n]"
read ANS

case $ANS in
y|Y|yes|YES)
echo "yes is selected"
;;
n|N|no|NO)
echo "no is selected"
;;
*)
echo "`basename $0`:unknown response"
;;
esac



