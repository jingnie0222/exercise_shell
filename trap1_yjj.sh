#!/bin/bash
#test for trap
#Ҫע��ű�˳�򣬷���trap����Ч

trap 'my_exit' 2   #�ȶ���trap

LOOP=0

function my_exit()  #�ٶ���my_exit,��trap��׽���źź�ľ������
{
    echo "you just hit <CTRL-C>,at number $LOOP"
    echo "I will now exit"
    exit 1
}

while :  #�ű�ִ������
do
   LOOP=`expr $LOOP + 1`
   echo $LOOP
done

