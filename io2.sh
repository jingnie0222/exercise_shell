#!/bin/sh
#### restart io.sh if io.sh is down
cd `dirname $0`
. script/functions.sh

#home_dir=$PWD #"/search/monitor"
#echo $home_dir
FILE_MAX_NUM=10

ts=`date +%s`
for ((i=$FILE_MAX_NUM;i>=0;i=$i-1)); do 
    let ts_tmp=$ts-$i*60
    #io_dir_path=$diskio_path/`date -d @"${ts_tmp}" +%Y%m%d%H`  
    io_file_path=$diskio_path/`date -d @"${ts_tmp}" +%Y%m%d%H`/`date -d @"${ts_tmp}" +%Y%m%d%H%M`
    echo $io_file_path
    #expect $home_dir/upload.exp $SERVER_PASSWD $io_file_path $SERVER_PATH
    [ -d $source_path/$LOCAL_IPADDR/ ] || mkdir $source_path/$LOCAL_IPADDR/
    [ -f $source_path/$LOCAL_IPADDR/`date -d @"${ts_tmp}" +%Y%m%d%H%M` ] && continue
    [ -f $io_file_path ] && cp $io_file_path $source_path/$LOCAL_IPADDR/
done

disks=`iostat -d -x 1 1 | grep -v -e "^$" -e "Device" -e "Linux" | awk '{print $1}'`
#sda sdc sdd sdb dm-0 dm-1 dm-2 dm-3 dm-4
echo $disks >$diskio_path/disks

old_dir=`date -d "1 month ago" +%Y%m%d%H`
echo $old_dir
for tmp_dir in `ls data/io/ | egrep "[0-9]{10}"` ; do
    echo $tmp_dir
    [ $old_dir -ge $tmp_dir ] && rm -rf data/io/$tmp_dir
done

INPUT_FILE_LIST=$source_path/$LOCAL_IPADDR/disk.inputfile.lst
ls $source_path/$LOCAL_IPADDR/`date +%Y`* >$INPUT_FILE_LIST
while read line; do
    for disk in `cat $diskio_path/disks`; do
        $script_path/diskio.create.sh $LOCAL_IPADDR $disk
        $script_path/diskio.update.sh $LOCAL_IPADDR $disk $line
    done

    onehourago=`date -d "$FILE_MAX_NUM mins ago" +%Y%m%d%H%M`
    input_file_ts=`basename $line`
    [ $input_file_ts -ge $onehourago ] || rm -f $line
done <$INPUT_FILE_LIST

ps aux | grep -v grep | grep -e "$home_dir/io.sh" >/dev/null 2>&1
[ $? -eq 0 ] && exit 0
$home_dir/io.sh &
