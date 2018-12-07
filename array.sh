#!/bin/bash

#tupuquery data is here
cd /search/summary_o/yinjingjing


data_date_list=(`stat tupuquery_data_* | grep Modify | awk '{print $2}'`)  #data_date_list是一个数组，加括号表示是数组
#echo ${data_date_list[*]}

for ((i=0;i<${#data_date_list[*]};i++));
do
    timestamp_list[i]=`date -d ${data_date_list[i]} +%s` 
done

echo ${#timestamp_list[*]}
echo ${timestamp_list[*]}
