#!/bin/sh -x

function function_x() {
	a=$1; b=$2
	if [[ $a -ge $b ]]; then 
		echo "max=$a"
		return
	fi
	echo "max=$b"
}

if [[ "x$#" != "x2" ]]; then
	echo "args error"
	exit 1
fi
function_x $1 $2
