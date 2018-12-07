#!/bin/bash

test_tupuonsum_dir=/search/odin/yinjingjing/formula_tupusonsum/WebSummary

#tupuonsum DB is here
cd /search/summary_o/yinjingjing
data_list=(`ls | grep '^tupudb_'`)  #data_list is an array

#删除较早的一版数据，[ FILE1 -ot FILE2 ]  如果 FILE1 比 FILE2 要老, 或者 FILE2 存在且 FILE1 不存在则为真
if [ "${data_list[0]}" -ot "${data_list[1]}" ];then
    rm -rf ${data_list[0]}
else
    rm -rf ${data_list[1]}

fi

cur_time=`date +%Y%m%d`
new_dir=tupudb_$cur_time
mkdir $new_dir
cd /search/summary_o/yinjingjing/$new_dir
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/baike_content.lqdb .
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/summary.lqdb .

cp /search/summary_o/yinjingjing/start.sh  /search/summary_o/yinjingjing/$new_dir
cp /search/summary_o/yinjingjing/start2.sh  /search/summary_o/yinjingjing/$new_dir

ps axu | grep lqdb | grep 9011 | grep grep -v | awk '{print $2}' | xargs kill -9
ps axu | grep lqdb | grep 9012 | grep grep -v | awk '{print $2}' | xargs kill -9

sh start.sh
sleep 5
sh start2.sh

echo "=== tupuonsum DB is ready==="

#update data dir
cd $test_tupuonsum_dir/data
rm ./* -rf 

rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/kball.ntriple.name.bin .
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/owl.data .
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/query.id .
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/wordlist.square .
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/Other/all_property .
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/Summary/* .

rsync -vazP rsync.onsum01.tupu.djt.ted::search/odin/daemon/tupu_onsum/data/base/* .

echo "=== tupuonsum data is ready==="
 

#restart tupu query
ps axu | grep summary | grep $test_tupuonsum_dir | grep grep -v | awk '{print $2}' | xargs kill -9
sleep 10
cd $test_tupuonsum_dir
sh start.sh
