#! /bin/env bash

# ����searchhub�쳣����

SENDMAIL='/search/odin/daemon/sendmail/sendmailhtml.php'

IP=`hostname -i`

#����searchhub�쳣����

title="����log����:wapsearchhub pcsearchhub webcache "
#maillist="chenzhige@sogou-inc.com;feixiao@sogou-inc.com;wangmeiyan@sogou-inc.com;bianyuteng@sogou-inc.com;liangguangyu@sogou-inc.com;chenchen@sogou-inc.com"
maillist="feixiao@sogou-inc.com;wangmeiyan@sogou-inc.com;bianyuteng@sogou-inc.com;lubaoting@sogou-inc.com;chenchen@sogou-inc.com;fengkai@sogou-inc.com;songnan@sogou-inc.com;zhongshanghua@sogou-inc.com;lihaoransi3663@sogou-inc.com"
body_file="statistic"
sh bin/sync_log.sh
time=`date +"%Y-%m-%d_%H" -d "1 hour ago"`
#�л��������ԭ��ʽ
#echo "<br /><h4 style=\"font-family:verdana\">tc01 Cache, PC Searchhub, Wap Searchhub����log����, logʱ��: ${time}<h4>" > ${body_file}
#echo "<br /><h3 style=\"font-family:verdana\">====Wap Searchhub====<h3>" >> ${body_file}
#python ${body_file}_all.py searchhub wapsearchhub_log >> ${body_file}
#echo "<br /><h3 style=\"font-family:verdana\">====PC Searchhub====<h3>" >> ${body_file}
#python ${body_file}_all.py searchhub pcsearchhub_log >> ${body_file}
#echo "<br /><h3 style=\"font-family:verdana\">====Cache====<h3>" >> ${body_file}
#python ${body_file}_all.py cache cache_log >> ${body_file}

echo "<br /><h4 style=\"font-family:verdana\">djt_01 wapSearchhub,djt_01 pcSearchhub ,tc_01 Cache ����log����, logʱ��: ${time}<h4>" > ${body_file}
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
	#$SENDMAIL "chenzhige@sogou-inc.com" "chenzhige@sogou-inc.com;feixiao@sogou-inc.com;wangmeiyan@sogou-inc.com;bianyuteng@sogou-inc.com;liangguangyu@sogou-inc.com;wangxiaofeisi2886@sogou-inc.com;chenchen@sogou-inc.com" '����log����' ${body_file}
	curl -d "uid=bianyuteng@sogou-inc.com&fr_name=Auto&&fr_addr=bianyuteng@sogou-inc.com&title=${title}&body=`cat ${body_file}`&mode=html&maillist=${maillist}" "http://mail.portal.sogou/portal/tools/send_mail.php"
fi
echo ""


##TODO
##1. gc�ֲ�һ��ͳ������
##2. qps�������ͳ����
##3. �������ȡĳ����ͳ���������ѡ��ĳһ̨ͳ�������
##4. ���ݲ���ֱ�ۿɷ�ת��Ϊͼ�λ���������ʽ�أ���
