#!/bin/sh

#trap 'echo -e "line $LINENO j=$j\ti=$i"' DEBUG

PARAM_ERROR=11
export PS4="+${LINENO} ${FUNCNAME[0]}"

function log() {
	fn=$1
	log_str="$2"
	date_str=`date +%Y%m%d" "%T`
	echo -e "[$fn] [$date_str] $log_str\n"
}

function usage() {
	echo -e "$1 param_1 param_2"
	exit $PARAM_ERROR
}

function multi() {
	let sum=$1*$2
	echo -en "$1*$2=$sum\t"
	#log $FUNCNAME "in multi func, testing i=$i,j=$j"
}

set -x
for((i=1;i<=9;i++));do
	for((j=1;j<=$i;j++));do
		multi $j $i
		echo "debug"
	done
	echo
done
set +x
