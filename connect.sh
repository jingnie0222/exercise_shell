#!/bin/bash

rm con_text

for ((;;))
do
   netstat -nal > con_tmpfile
   total_num=`wc -l con_tmpfile |awk '{print $1}'`

   echo "=================================================" >> con_text
   date >> con_text
   echo "total connection num is $total_num" >> con_text
   echo ":::TIME_WAIT:::" >> con_text
   cat con_tmpfile | grep TIME_WAIT |awk '{a[$5]++}'END'{for (i in a) print i" : "a[i]}' >> con_text
   echo "=================================================" >> con_text
   >con_tmpfile
   sleep 10
done
