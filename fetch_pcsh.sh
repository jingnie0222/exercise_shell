#! /bin/bash

day=`date "+%Y%m%d"`
>body.txt

#Get dump file
rsync -vazP --bwlimit=50000 rsync.resinhub01.web.djt.ted::search/odin/daemon/searchhub/dumpReqSH .
head -200000 dumpReqSH > dumpReqSH_use


#fetch data 
file=pcsh_data_$day
tmpfile="a02.xml"
>$file

ret0=0
total=0

while read line
do
    wget --post-data="$line" --header='Content-Type: application/x-www-form-urlencoded;charset=UTF-16LE' "http://resinhub01.web.djt.ted:5555" -O $tmpfile
    ret=$(iconv -f utf16le -t gbk $tmpfile -c | fgrep "itemsOnPage")
    if [[ -z $ret ]];then
        continue
    fi
    item0=$(echo $ret | fgrep 'itemsOnPage="0"')
    if [[ -n $item0 ]];then
        ret0=$(($ret0+1))
    fi
    total=$(($total+1))
    echo "START" >> $file
    cat $tmpfile >> $file
    echo "" >> $file
    echo "END" >> $file
    rm -f $tmpfile
    sleep 0.5
done < dumpReqSH_use

echo -e "total items: $total\n" >> body.txt
echo -e "ret0 items: $ret0\n" >> body.txt

#Mock load newdata and restart
sed -i  "s/pcsh_data.*/pcsh_data_$day/" conf/httpmock.ini
sh start_pcsh01.sh

pid=`ps axu | grep pc_searchhub | grep mock | grep "grep" -v | awk '{print $2}'`
if [ -n "$pid" ];then
    echo -e "mock restart sucdessfully, pid is $pid\n" >> body.txt
    echo -e "load data is: $file\n" >> body.txt
    echo -e "请打压验证新数据正确性\n" >> body.txt
else
    echo -e "mock restart fail, check please\n" >> body.txt
fi

#Send mail
mutt -s "resin打压环境更新数据" -i body.txt -F ./mutt_config < /dev/null -- yinjingjing@sogou-inc.com zhaozhichao@sogou-inc.com panguishuang@sogou-inc.com wenyanmei@sogou-inc.com jialiang@sogou-inc.com

