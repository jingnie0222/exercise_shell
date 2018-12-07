#! /usr/bin/env bash

function Usage()
{
	echo "sh drop_dns.sh {drop|undrop}"
}

dns_ip=`cat /etc/resolv.conf | grep -v "^#" | fgrep nameserver | awk '{print $2}'`

if [[ $1 = "drop" ]];then
	ret=0
	while [[ $ret -eq 0 ]]
	do
		iptables -t filter -D OUTPUT -d ${dns_ip} -j DROP > /dev/null 2>&1
		ret=$?
	done
	iptables -t filter -A OUTPUT -d ${dns_ip} -j DROP
elif [[ $1 = "undrop" ]];then
	iptables -t filter -D OUTPUT -d ${dns_ip} -j DROP
else
	Usage
fi
