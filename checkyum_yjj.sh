#!/bin/bash

#yumlist="ace561-devel sasn1b-devel sohudb2-devel sohumisc-devel ssplatform2 ssplatform2-devel lzo-devel xerces-c-devel fb303-devel thrift-lib-cpp-devel libevent-devel qdb qdb-devel"

#ʹ�������ļ��ķ�ʽ
current_path=`pwd`
source $current_path/yum_test   #yum_test���ļ�����yumlist

echo "" > std

for i in $yumlist  #ע����yumlist
do
    echo "$i:-------------------------------" >> std
    yum list | grep "$i" >> std
    yum list installed | grep "$i" >> std
    echo "-----------------------------------" >> std
done
