#!/bin/sh

. ./debug.sh
export DEBUG="true"
echo ${!#}
echo "args[13]:${13}"
args1=($*)
#DEBUG set -x
#for((i=0;i<${#args1[@]};i++)); do
for((i=0;i<$#;i++)); do
	echo "for for for ${args1[i]}"
done
echo "args nums:"$#
#DEBUG set +x
while [[ $1 != "" ]]; do
	echo $1
	shift
done
