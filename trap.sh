#!/bin/sh

trap 'echo -e "line $LINENO\ti=$i\tj=$j\tsum=$sum"' DEBUG
i=0; j=0
while true; do
	let i=$i+1
	let j=$j+1
	[[ $i -eq 2 ]] && continue
	[[ $i -gt 3 ]] && break
	let sum=$i+$j
	echo "sum="$sum
done
