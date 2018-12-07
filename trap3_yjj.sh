#!/bin/bash
#use trap ignore signals
#脚本程序通常是以从上到下的顺序解释执行的，所以必须在你想保护的那部分代码以前指定trap命令。
#trap "commands" signal-list    当脚本收到signal-list清单内列出的信号时，trap命令执行双引号中的命令(也可以使用单引号)。
#trap signal-list    trap不指定任何命令，接受信号的默认操作，默认操作是结束进程的运行。
#trap " " signal-list     trap命令指定一个空命令串，允许忽视信号(也可以使用单引号)。


#trap  1 2 3 15
trap '' 1 2 3 15

LOOP=0
while :
do
   LOOP=`expr $LOOP + 1`
   echo "critical processing..$LOOP..you cannot interupt me"
   sleep 1
   [[ "$LOOP" -eq 6 ]] && break
done

LOOP=0
trap 'myexit' 1 2 3 15

function myexit()
{
    echo "Received interupy on count $LOOP"
    echo "Now exiting..."
    exit 1
}

while :
do 
   LOOP=`expr $LOOP + 1`
   echo "Non-critical processing..$LOOP..interupt me now if you want"
   sleep 1
   [[ "$LOOP" -eq 6 ]] && break
done


