#!/bin/bash

tupuqo_dir=/search/yinjingjing/lizhi_tupuqo/QueryOptimizer

cd $tupuqo_dir/data
rm ./* -rf

rsync -vazP rsync.cache01.tupu.djt.ted::search/odin/daemon/tupuqo/data/* .

cd base
rm qo_blacklist -rf
rsync -vazP rsync.cache01.tupu.djt.ted::search/odin/daemon/black_agent/data/service/blacklist.lst qo_blacklist

cd ../service
rm mirror -rf
rm qomd5.* -rf

cd online
rsync -vazP 10.141.148.34::search/zhangk/Ontology/OnlineDataFinal/QO/* .

echo "===tupuqo data is ready==="
ls -l

#restart tupuqo
cd $tupuqo_dir
sh run.sh
