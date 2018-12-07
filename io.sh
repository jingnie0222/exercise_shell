#!/bin/sh
cd `dirname $0`
home_dir=$PWD #"/search/mem"
data_dir=$home_dir/data

io_dir=$data_dir/io
io_tmp_file=$io_dir/io.tmp
[ -d $io_dir ] || mkdir -p $io_dir

#[@zw_122_62 monitor]# date +%Y%m%d%H%M
#201305031134

let cnt=`iostat -d -k -tx 1 1 | wc -l`-2
let cnt2=$cnt-2

while true; do

	iostat -d -k -tx 1 2 >$io_tmp_file
	sleep 1
	#date -d "`cat $io_tmp_file | tail -n $cnt | awk '{if($0~/[AP]M/) print $0}'`" +%s \
	#date -d "`cat $io_tmp_file | tail -n $cnt | awk '{if($0~/[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]/) print $0}'`" +%s \
	date -d "`cat $io_tmp_file | tail -n $cnt | head -n 1`" +%s \
		>$io_dir/timestamp
	timestamp=`awk '{print $1}' $io_dir/timestamp`
	timestamp_str=`date -d @"${timestamp}" +%Y-%m-%d" "%H:%M:%S`
	dir_path=$io_dir/`date -d @"${timestamp}" +%Y%m%d%H`
	file_path=$dir_path/`date -d @"${timestamp}" +%Y%m%d%H%M`
	[ -d $dir_path ] || mkdir $dir_path


	#echo ${timestamp_str}
	cat $io_tmp_file | tail -n ${cnt2} | \
	awk -v ts=${timestamp} \
	'BEGIN{OFS=":"}
	{ if($0!~/^$/)
		print $1" "ts,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12
	}' >>$file_path

	sleep 3
done


#cmd="echo "info[2]","info[3]","info[4]","info[5]","info[6]","info[7]","info[8]","info[9]","info[10]","info[11]","info[12]" >>"info[1]
