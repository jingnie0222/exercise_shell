#!/bin/sh
cd `dirname $0`

date >>load.log
top -n 1 -b | grep "load average" -A5 >>load.log
