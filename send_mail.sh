#! /bin/env bash

# 线上searchhub异常报警

SENDMAIL='/search/odin/daemon/sendmail/sendmailhtml.php'

IP=`hostname -i`

#线上searchhub异常报警

title="线上log分析:wapsearchhub pcsearchhub webcache "
#maillist="chenzhige@sogou-inc.com;feixiao@sogou-inc.com;wangmeiyan@sogou-inc.com;bianyuteng@sogou-inc.com;liangguangyu@sogou-inc.com;chenchen@sogou-inc.com"
maillist="feixiao@sogou-inc.com;wangmeiyan@sogou-inc.com;bianyuteng@sogou-inc.com;lubaoting@sogou-inc.com;chenchen@sogou-inc.com;fengkai@sogou-inc.com;songnan@sogou-inc.com;zhongshanghua@sogou-inc.com;lihaoransi3663@sogou-inc.com"
body_file="statistic"
sh bin/sync_log.sh
time=`date +"%Y-%m-%d_%H" -d "1 hour ago"`
#有换行问题的原格式
#echo "<br /><h4 style=\"font-family:verdana\">tc01 Cache, PC Searchhub, Wap Searchhub线上log分析, log时间: ${time}<h4>" > ${body_file}
#echo "<br /><h3 style=\"font-family:verdana\">====Wap Searchhub====<h3>" >> ${body_file}
#python ${body_file}_all.py searchhub wapsearchhub_log >> ${body_file}
#echo "<br /><h3 style=\"font-family:verdana\">====PC Searchhub====<h3>" >> ${body_file}
#python ${body_file}_all.py searchhub pcsearchhub_log >> ${body_file}
#echo "<br /><h3 style=\"font-family:verdana\">====Cache====<h3>" >> ${body_file}
#python ${body_file}_all.py cache cache_log >> ${body_file}

echo "<br /><h4 style=\"font-family:verdana\">djt_01 wapSearchhub,djt_01 pcSearchhub ,tc_01 Cache 线上log分析, log时间: ${time}<h4>" > ${body_file}
echo "<br /><h3 style=\"font-family:verdana\">====Wap Searchhub====<h3><pre>" >> ${body_file}
#cat wapsearchhub_log |python statistic_all.py_byt searchhub java >> ${body_file}
cat wapsearchhub_log |python statistic_all.py_0821 searchhub java >> ${body_file}
#python ${body_file}_all.py searchhub wapsearchhub_log >> ${body_file}
echo "</pre><br /><h3 style=\"font-family:verdana\">====PC Searchhub====<h3><pre>" >> ${body_file}
#cat pcsearchhub_log |python statistic_all.py_byt searchhub java >> ${body_file}
cat pcsearchhub_log |python statistic_all.py_0821 searchhub java >> ${body_file}
#python ${body_file}_all.py searchhub pcsearchhub_log >> ${body_file}
echo "</pre><br /><h3 style=\"font-family:verdana\">====MetaXmlCache====<h3><pre>" >> ${body_file}
python ${body_file}_all.py cache cache_log >> ${body_file}
echo "</pre>" >> ${body_file}


if [[ -s ${body_file} ]]; then
	echo "send mail"
	#$SENDMAIL "chenzhige@sogou-inc.com" "chenzhige@sogou-inc.com;zhoulinlin@sogou-inc.com;bianyuteng@sogou-inc.com;wangmeiyan@sogou-inc.com" 'searchhub exception' exceptions
	#$SENDMAIL "chenzhige@sogou-inc.com" "chenzhige@sogou-inc.com;feixiao@sogou-inc.com;wangmeiyan@sogou-inc.com;bianyuteng@sogou-inc.com;liangguangyu@sogou-inc.com;wangxiaofeisi2886@sogou-inc.com;chenchen@sogou-inc.com" '线上log分析' ${body_file}
	curl -d "uid=bianyuteng@sogou-inc.com&fr_name=Auto&&fr_addr=bianyuteng@sogou-inc.com&title=${title}&body=`cat ${body_file}`&mode=html&maillist=${maillist}" "http://mail.portal.sogou/portal/tools/send_mail.php"
fi
echo ""


##TODO
##1. gc分布一周统计两次
##2. qps情况可以统计下
##3. 线上随机取某机房统计意义大还是选择某一台统计意义大？
##4. 数据不够直观可否转换为图形或者曲线形式呢？？
