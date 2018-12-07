#!/bin/bash
#use trap ignore signals
#�ű�����ͨ�����Դ��ϵ��µ�˳�����ִ�еģ����Ա��������뱣�����ǲ��ִ�����ǰָ��trap���
#trap "commands" signal-list    ���ű��յ�signal-list�嵥���г����ź�ʱ��trap����ִ��˫�����е�����(Ҳ����ʹ�õ�����)��
#trap signal-list    trap��ָ���κ���������źŵ�Ĭ�ϲ�����Ĭ�ϲ����ǽ������̵����С�
#trap " " signal-list     trap����ָ��һ�����������������ź�(Ҳ����ʹ�õ�����)��


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


