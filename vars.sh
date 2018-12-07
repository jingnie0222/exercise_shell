#!/bin/sh

. ./debug.sh
#export DEBUG="false"
export DEBUG="true"

declare money=100
declare -r pid=$$

function local_var() {
	local money=200
	echo -e "local money=$money"
	return 10
}

local_var
ret=$?
DEBUG echo "ret:"$ret
DEBUG echo "global money=$money"

DEBUG pid=1111
