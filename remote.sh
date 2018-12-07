#!/bin/bash
cmd="cat /search/odin/daemon/wisdsugg/log/history/wisdsugg.err.log.2018-08-14_14|grep ³µÖÇ»ã"
for((i=1;i<13;i++));do
remote_index=`echo ${i}|awk '{printf("%02d\n",$0)}'`
remote_host=idxsugg$remote_index.web.zw.ted
echo ========== $remote_host =========
ssh -l guest $remote_host $cmd
done

#for((i=1;i<3;i++));do
#remote_host=idxsugg1$i.web.zw.ted
#echo ========== $remote_host =========
#ssh -l guest $remote_host $cmd
#done

echo ========= DONE =======
