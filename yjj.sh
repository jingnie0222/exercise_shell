#!/bin/bash

inputfile=$1
outpufile=$2

if [ -e $outpufile ];then
  rm  $outpufile -f
fi

#weewang��Ч�ʸߣ���cat�ܵ���awk��awkֻ����һ�Σ������������
cat $inputfile | awk '/\[Url\]/ || /\[Title\]/ || /\[Summary\]/ || /\[Extra\]/ || /\[tuwen-Summary\]/;/WAPCONTENT/ || /LIGLOG_EXTQUERY/ || /CWebSummary::GenerateSummaryContent.*DocID/ || /CWebSummary::NewGetXmlResultFromXsltXml.*DocID/ || /CWebSummary::GetXmlResultFromXsltXml.*DocID/{print $5,$6,$7}' > $outpufile 

#yjj��Ч�ʵͣ�ÿ��readһ�У�echo 1�и��ܵ���Ȼ��echo���˳��ˣ��ܵ�֮���awkҲ�ͽ����ˡ��൱�ڵ�����������awk
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
