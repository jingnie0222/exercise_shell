conf="interest.conf"
listenPort="2025"
startNum="10"
dir=`pwd`

rm temp_conf -rf
mkdir temp_conf

rm  start_$startNum.sh -rf 
touch start_$startNum.sh
echo "dir=`pwd`" >> start_$startNum.sh
echo "export LD_LIBRARY_PATH=lib" >> start_$startNum.sh
echo "ulimit -c unlimited" >> start_$startNum.sh

#����startNum�������ļ����˿ںŵ���1��ͬʱ����start�ű�

for i in `seq 1 $startNum`
do
   cp $conf temp_conf/$i.$conf
   newport=$((listenPort+$i-1))
   sed -i "s/$listenPort/$newport/g"  temp_conf/$i.$conf      #ע��˴���˫���ţ�������ʱ����Ч.Sed����ı��ʽһ���õ�������������'��������Ҫʹ�ñ���ʱ�ͻ���˫���ţ�"����
   echo "$dir/interestServer -f temp_conf/$i.$conf -k HTTP >std 2>err$i &" >> start_$startNum.sh
done

sh start_$startNum.sh

for i in `ls temp_conf`
do 
   port=`cat temp_conf/$i | grep ListenPort | awk -F "=" '{print $NF}' | sed 's/"//g'`
   sleep 5s
   res=`netstat -nalp | grep $port | grep LISTEN`
   if [ -n "$res" ];then
       echo "conf $i stark ok"
   else
       echo "conf $i stark failed"
  fi
done




