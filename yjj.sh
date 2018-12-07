#!/bin/bash

inputfile=$1
outpufile=$2

if [ -e $outpufile ];then
  rm  $outpufile -f
fi

#weewang，效率高，是cat管道给awk，awk只调用一次，处理所有输出
cat $inputfile | awk '/\[Url\]/ || /\[Title\]/ || /\[Summary\]/ || /\[Extra\]/ || /\[tuwen-Summary\]/;/WAPCONTENT/ || /LIGLOG_EXTQUERY/ || /CWebSummary::GenerateSummaryContent.*DocID/ || /CWebSummary::NewGetXmlResultFromXsltXml.*DocID/ || /CWebSummary::GetXmlResultFromXsltXml.*DocID/{print $5,$6,$7}' > $outpufile 

#yjj，效率低，每次read一行，echo 1行给管道，然后echo就退出了，管道之后的awk也就结束了。相当于调用了行数次awk
#while read LINE
#do
  #echo $LINE  | awk '/\[Url\]/ || /\[Title\]/ || /\[Summary\]/ || /\[Extra\]/ || /\[tuwen-Summary\]/;/WAPCONTENT/ || /LIGLOG_EXTQUERY/ || /CWebSummary::GenerateSummaryContent.*DocID/ || /CWebSummary::NewGetXmlResultFromXsltXml.*DocID/ || /CWebSummary::GetXmlResultFromXsltXml.*DocID/{print $5,$6,$7}' >> $outpufile 
#done<$inputfile





#while read LINE
#do  
 #if [ -n "$docid" ];then
  #   echo `echo "$docid" | awk '{print $5,$6,$7}'` >> $outpufile
 # fi

#  echo `echo "$LINE" | awk '/\[Url\]/ || /\[Title\]/ || /\[Summary\]/ || /\[Extra\]/ || /\[tuwen-Summary\]/'` >> $outpufile
  
#  extquery=`echo "$LINE" | awk '/LIGLOG_EXTQUERY/'`
#  if [ -n "$extquery" ];then
#     echo `echo "$LINE" | awk '{print $5,$6,$7}'` >> $outpufile
#  fi
  
#  bianliaobiansou=`echo "$LINE" | awk '/WAPCONTENT/'`
#  if [ -n "$bianliaobiansou" ];then
#     echo `echo "$LINE" | awk '{print $5,$6}'` >> $outpufile
#  fi
#done<$inputfile
#wait
#sed -i '/^$/d' $outpufile
