#by chenchen 20150508

conf="normA02.cfg"
listenPort="19001"
startNum="32"
special="special"
bin="./websummarydAbb"

#gen conf file
rm -rf multiConf
mkdir multiConf
echo "ulimit -c unlimited ">start_$startNum.sh
for i in `seq -f "%01g" 1 $startNum`
do
	cp $conf multiConf/$i.$conf.$special
        echo "nohup $bin -etf multiConf/$i.$conf.$special -n 5 -m 200 -k Summary 1>/dev/null 2>err"$i"&" >>start_$startNum.sh
done

origenString=`cat $conf|grep ListenAddress|awk '{print $1}'`
for i in `seq -f "%01g" 1 $startNum`
do
	let "end=$listenPort+$i-1"
	replaceString="\"ListenAddress\"=\":"$end"\""
	mv multiConf/$i.$conf.$special multiConf/$i.$conf.$special.bak
	cat multiConf/$i.$conf.$special.bak|sed s"/$origenString/$replaceString/"g >multiConf/$i.$conf.$special
done
rm -f multiConf/*bak

echo "Plase use start_$startNum.sh"

echo "ps -ef|grep $special |grep -v grep |awk '{print $2}'>$special.PID" >>start_$startNum.sh
echo "you can find start sum ProcessID at $special.PID
