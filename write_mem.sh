sysctl -w vm.drop_caches=1
sysctl -w vm.drop_caches=0

FreeMem=`free -g| grep Mem| awk '{print $4}'`
echo "$FreeMem G need to write,please wait"
CSUMMEM -s $FreeMem -d 200 &

for ((;;))
do 
   sleep 3
   LeftMem1=`free | grep Mem| awk '{print $4}'`
   echo "LeftMem1:$LeftMem1"
   sleep 3
   LeftMem2=`free | grep Mem| awk '{print $4}'`
   echo "LeftMem2:$LeftMem2"
   if [ $LeftMem1 -le $LeftMem2 ];then
      killall CSUMMEM
      break
  fi
done
