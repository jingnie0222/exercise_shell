rm codecover_tupuonsum -rf
echo "enter username"
read username
echo "enter password"
read -s password
test_code_path=$1

svn co http://svn.sogou-inc.com/svn/websearch4/web/knowledge/summary_new/trunk  codecover_tupuonsum  --username=$username  --password=$password
cd codecover_tupuonsum
svn co http://svn.sogou-inc.com/svn/websearch4/web/knowledge/summary_kernel_new/trunk  summary_kernel --username=$username  --password=$password
svn co http://svn.sogou-inc.com/svn/websearch4/web/web_base/tags/knowledge.base.20121116.a  web_base  --username=$username  --password=$password
svn co http://svn.sogou-inc.com/svn/websearch4/web/web_tpage/tags/knowledge.xpage.20121116.a  web_tpage   --username=$username  --password=$password
svn co http://svn.sogou-inc.com/svn/rd_modules/encoding/tags/web.ssplatform-encoding.20120405.a   ssplatform-encoding  --username=$username  --password=$password
cp /search/odin/yinjingjing/gcov/trunk/*.sh  .
cp /search/odin/yinjingjing/gcov/trunk/*.php .
sh make-gcov.sh

cd  WebSummary
mv data data_bak
rm start.sh
ln -s /search/odin/yinjingjing/$1/WebSummary/data 
ln -s /search/odin/yinjingjing/$1/WebSummary/tupu_onsum.cfg 
ln -s /search/odin/yinjingjing/$1/WebSummary/start.sh 

echo "===test env is ready==="

