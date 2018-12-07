#!/bin/bash

#tupuquery data is here
cd /search/summary_o/yinjingjing
data_list=(`ls | grep '^tupuquery_data'`)  #data_list is an array

#ɾ�������һ�����ݣ�[ FILE1 -ot FILE2 ]  ��� FILE1 �� FILE2 Ҫ��, ���� FILE2 ������ FILE1 ��������Ϊ��
if [ "${data_list[0]}" -ot "${data_list[1]}" ];then
    rm -rf ${data_list[0]}
else
    rm -rf ${data_list[1]}

fi

cur_time=`date +%Y%m%d`
new_dir=tupuquery_data_$cur_time
mkdir $new_dir
cd /search/summary_o/yinjingjing/$new_dir
rsync -vazP 10.134.50.89::search/zhangk/Ontology/OnlineData/Other/* .

mv forward forwardindex
mv Inv diskdata

echo "===query data is ready==="
ls -l

#restart tupu query
sed  -i "s/tupuquery_data_.*\//$new_dir\//" /search/odin/yinjingjing/tupu_query/client_application/tupu_lquery.cfg
ps axu | grep tupu_query | grep grep -v | awk '{print $2}' | xargs kill -9
sleep 10
cd /search/odin/yinjingjing/tupu_query/server_application
sh start.sh
cd /search/odin/yinjingjing/tupu_query/client_application
sh start.sh
