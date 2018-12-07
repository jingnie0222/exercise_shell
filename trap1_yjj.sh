#!/bin/bash
#test for trap
#要注意脚本顺序，否则trap不生效

trap 'my_exit' 2   #先定义trap

LOOP=0

function my_exit()  #再定义my_exit,即trap捕捉到信号后的具体操作
{
    echo "you just hit <CTRL-C>,at number $LOOP"
    echo "I will now exit"
    exit 1
}

while :  #脚本执行流程
do
   LOOP=`expr $LOOP + 1`
   echo $LOOP
done

