#! /usr/bin/env bash


if [ $# -lt 2 ];then
  echo "sh netException.sh {des_ip time_interval}"
  exit 1
fi

des_ip=$1
time_interval=$2

for ((;;))
do
    ret=0
    while [[ $ret -eq 0 ]]
	do
            iptables -t filter -D OUTPUT -d ${des_ip} -j DROP > /dev/null 2 >&1
	    ret=$?
        done
	iptables -t filter -A OUTPUT -d ${des_ip} -j DROP
    sleep $time_interval

	iptables -t filter -D OUTPUT -d ${des_ip} -j DROP
    sleep $time_interval

done
