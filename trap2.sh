#!/bin/sh

tmp_file=$$.tmp

trap "[[ -f $tmp_file ]] && rm -f $tmp_file && exit 0" USR1 INT TERM

touch $tmp_file						#touch 一个空文件
echo "Fist line ..." >>$tmp_file	#向文件中写入一行
sleep 60 &							#sleep 60s，模拟正在执行各种操作
wait `jobs -p`
echo "Second line ..." >>$tmp_file	#向文件中写入另一行
