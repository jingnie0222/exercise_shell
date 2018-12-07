#!/bin/bash
rm job.ini 

pid=`ps axu | grep codecover_tupuonsum | grep grep -v | awk '{print $2}'`

rsync -vazP rsync.onsum01.tupu.djt.ted::search/odin/daemon/tupu_onsum/info/job.ini .
src_online_tupu_summary=`grep summary_new job.ini  | awk -F "=" '{print $2}'`
src_online_tupu_kernel=`grep summary_kernel_new job.ini  | awk -F "=" '{print $2}'`
src_test_tupu_summary="http://svn.sogou-inc.com/svn/websearch4/web/knowledge/summary_new/trunk"
src_test_tupu_kernel="http://svn.sogou-inc.com/svn/websearch4/web/knowledge/summary_kernel_new/trunk"
svndiff_tupu_summmary_out=""
svndiff_tupu_kernel_out=""

#run makegcda-gcov.sh
echo "=====run makegcda-gcov.sh begin====="
cd codecover_tupuonsum
sh makegcda-gcov.sh $pid

ls -l  WebSummary/ | grep gcda
if  [[ $? -eq 0 ]];then
    echo "generate gcda file in WebSummary"
else
    echo "not gcda file in WebSummary,please check..."
    exit
fi

ls -l summary_kernel/Kernel/.libs | grep gcda
if  [[ $? -eq 0 ]];then
    echo "generate gcda file in Kernel/.libs"
else
    echo "not gcda file in Kernel/.libs,please check..."
    exit
fi

echo "=====run makegcda-gcov.sh end====="

#run collect-gcov.sh
echo "=====run collect-gcov.sh begin====="
sh collect-gcov.sh
echo "=====run collect-gcov.sh end====="

#run genhtml-gcov.sh
echo "=====run genhtml-gcov.sh begin====="
sh genhtml-gcov.sh /search/odin/nginx/html/web/gcov
echo "=====run genhtml-gcov.sh end====="

#run svndiff-gcov.sh
echo "=====run svndiff-gcov.sh begin====="
sh svndiff-gcov.sh $src_online_tupu_summary $src_test_tupu_summary svndiff_tupu_summmary_out
sh svndiff-gcov.sh $src_online_tupu_kernel $src_test_tupu_kernel svndiff_tupu_kernel_out

if [ -f "svndiff_tupu_summmary_out" -a -f "svndiff_tupu_kernel_out" ];then
     echo "svndiff_tupu_summmary_out and svndiff_tupu_kernel_out are generated"
else
     echo "svndiff_tupu_summmary_out or svndiff_tupu_kernel_out not generated,please check..."
     exit
fi
echo "=====run svndiff-gcov.sh end====="

#run  diffviewer.php
echo "=====run diffviewer.php begin====="
php diffviewer.php svndiff_tupu_summmary_out /search/odin/nginx/html/web/ gcov
php diffviewer.php svndiff_tupu_kernel_out /search/odin/nginx/html/web/ gcov summary_kernel

if [ ! -f "/search/odin/nginx/html/web/gcov/append.html" ];then 
     echo "/search/odin/nginx/html/web/gcov/append.html not generated,please check..."
     exit
fi
echo "=====run diffviewer.php end====="

echo "===GCOV RESULT GENERATED.==="

