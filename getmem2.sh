#!/bin/bash
cd `dirname $0`
if [ $# -ne 2 ]; then
    echo -en "Usage:$0 <DAEMON_NAME> <DAEMON_PID>\n"
    exit 1
else
    daemon_name=$1
    daemon_pid=$2
fi
if [ ! -e "output" ]; then
	mkdir output
fi

server_ip="10.11.196.205"
server_passwd="Sogou-RD@2008"

#echo ",,PID,USER,PR,NI,VIRT,RES,SHR,S,%CPU,%MEM,TIME+,COMMAND" >output/top.$daemon_name.$daemon_pid.csv
#awk -v daemon_pid=$daemon_pid -v daemon_pid=$daemon_pid '{if($0~daemon_pid".*"daemon_name) print $0}' top.$daemon_name | sed -e 's/|/ /g' -e 's/[[:space:]]\{1,\}/,/g' >>output/top.$daemon_name.$daemon_pid.csv
awk -v daemon_pid=$daemon_pid -v daemon_pid=$daemon_pid '{if($2~daemon_pid && $(NF-1)~daemon_name) print $0}' top.$daemon_name | sed -e 's/|/ /g' -e 's/[[:space:]]\{1,\}/,/g' >>output/top.$daemon_name.$daemon_pid.csv

#echo ",,USER,PID,%CPU,%MEM,VSZ,RSS,TTY,STAT,START,TIME,COMMAND" >output/psaux.$daemon_name.$daemon_pid.csv
#awk -v daemon_pid=$daemon_pid -v daemon_pid=$daemon_pid '{if($0~daemon_pid".*"daemon_name) print $0}' psaux.$daemon_name | sed -e 's/|/ /g' -e 's/[[:space:]]\{1,\}/,/g' >>output/psaux.$daemon_name.$daemon_pid.csv
awk -v daemon_pid=$daemon_pid -v daemon_pid=$daemon_pid '{if($3~daemon_pid && $NF~daemon_name) print $0}' psaux.$daemon_name | sed -e 's/|/ /g' -e 's/[[:space:]]\{1,\}/,/g' >>output/psaux.$daemon_name.$daemon_pid.csv

#sz output/top.$daemon_name.$daemon_pid.csv output/psaux.$daemon_name.$daemon_pid.csv

awk -F, '{OFS=","}{print $11}' output/top.$daemon_name.$daemon_pid.csv >output/top.$daemon_name.$daemon_pid.csv.tmp
awk -F, '{OFS=","}{print $1" "$2,$7,$8}' output/psaux.$daemon_name.$daemon_pid.csv >output/psaux.$daemon_name.$daemon_pid.csv.tmp
paste -d "," output/psaux.$daemon_name.$daemon_pid.csv.tmp output/top.$daemon_name.$daemon_pid.csv.tmp >output/$daemon_name.$daemon_pid.timestamp.vsz.rss.cpu.csv

#scp output/$daemon_name.$daemon_pid.timestamp.vsz.rss.cpu.csv $server_ip:/search/oneway/source/10.10.122.126/
