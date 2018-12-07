#!/bin/sh
moudle=(fast_filter wzy_docdis wzy_producer wzy_idx1_producer wzy_collector isnews_xiaocan isnews_allnews isnews_notnews isnews spider_node WebClient selector dispatcher docdis producer collector newindexserv newindexclie instant_inde inst_index_a vertical_dum qdb_daemon python lt-xp java lt-qdb_daemon lt-webpad lt-pagedispatch lt-newspad lt-reader lt-reader db_proxy lt-antispam lt-pa_server lt-pa_client emu_la lt-producer.key lt-docdispatch. docdis_addterm producer_addter producer_addter docdis_base_add producer_base_a producer_base_a collector_addte fast_producer1 fast_docdis )
jmoudle=(bigmap-dpserver)

#home_dir="/search/mem"

cd `dirname $0`
. script/functions.sh
cd $home_dir
echo $home_dir
top_file=$home_dir/top.tmp
psaux_file=$home_dir/psaux.tmp
jstat_psaux_file=$home_dir/jstat_psaux.tmp
jstat_top_file=$home_dir/jstat_top.tmp
timestamp=`date +%Y-%m-%d"|"%H:%M:%S`

top -b -n 1 | sed 's/[[:space:]]*$//g' >$top_file
ps aux | grep -v grep >$psaux_file
top -n 1 -b >$jstat_top_file
ps aux | grep -v grep | grep -e "\/java .*\-jar " >$jstat_psaux_file

for i in ${moudle[@]}; do
	awk	-v ts=$timestamp \
		-v cnt=`grep $i $home_dir/top.tmp -c` \
		-v mode=$i \
	'BEGIN{printf "\n%s\tdaemon=%s\tcount=%d\n",ts,mode,cnt}
	{if($0~mode) print ts,$0}
	' $top_file >>$home_dir/top.$i

	awk	-v ts=$timestamp \
		-v cnt=`grep $i $home_dir/psaux.tmp -c` \
		-v mode=$i \
	'BEGIN{printf "\n%s\tdaemon=%s\tcount=%d\n",ts,mode,cnt}
	{if($0~mode) print ts,$0}
	' $psaux_file >>$home_dir/psaux.$i
done

for i in ${jmoudle[@]}; do
    #ps aux | grep -v grep | grep -e "java .*\-jar .*$i" 
	awk	-v ts=$timestamp \
		-v cnt=`grep -e "\/java .*\-jar .*$i" $jstat_psaux_file -c` \
		-v mode=$i \
        -v patten="/java .*-jar .*$i" \
	'BEGIN{printf "\n%s\tdaemon=%s\tcount=%d\n",ts,mode,cnt}
	{if($0~patten) print ts,$0}
	' $jstat_psaux_file >>$home_dir/jstat.psaux.$i
    for pid in `grep -e "\/java .*\-jar .*$i" $jstat_psaux_file | awk '{print $2}'`; do
        echo -en "$timestamp " >>gc.$i.$pid
        jstat -gc -h 10 $pid 1000 1 | tail -n 1 >>gc.$i.$pid
    done
done
./top.sh
