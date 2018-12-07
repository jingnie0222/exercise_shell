#!/bin/sh

set -E
trap 'echo -e "[line: $LINENO] [function: $FUNCNAME] [errno: $?] run failed "' ERR
trap 'echo -e "line $LINENO var1=$var1" ' DEBUG

declare var1=10
function func_err() {
	dddddd
	let var1=12
}

let var1=20

func_err
ls aaa
