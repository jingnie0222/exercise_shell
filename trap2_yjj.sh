#!/bin/bash
# test for trap

trap 'my_exit' INT

FILE=tmp.$$

function my_exit()
{
    echo "Received interupt..."
    echo "Do you really wihs to exit?"
    echo "y:yes"
    echo "n:no"
    
    read -p "your choice is:" ANS
    case $ANS in
    y|Y|yes|YES) rm $FILE && exit 1 ;;
    n|N|no|NO) ;;
    *);;
    esac
}

echo "processing....."

while :
do 
    df >>$FILE
done
