#!/bin/sh

tmp_file=$$.tmp

trap "[[ -f $tmp_file ]] && rm -f $tmp_file && exit 0" USR1 INT TERM

touch $tmp_file						#touch һ�����ļ�
echo "Fist line ..." >>$tmp_file	#���ļ���д��һ��
sleep 60 &							#sleep 60s��ģ������ִ�и��ֲ���
wait `jobs -p`
echo "Second line ..." >>$tmp_file	#���ļ���д����һ��
