#!/bin/sh

function function_x() {
#set -x
	a=$1; b=$2
	if [[ $a -ge $b ]]; then 
		max=$a
		echo "max=$a"
		return
	fi
	max=$b
	echo "max=$b"
#set +x
}
echo -e "debug1 a=$a"

if [[ "x$#" != "x2" ]]; then
	echo "args error"
	exit 1
fi
function_x $1 $2
echo -e "debug2 a=$a"
echo -e "debug2 max=$max"
