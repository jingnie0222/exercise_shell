#cd /search/yinjingjing/formula_tupuqo/QueryOptimizer
cd /search/yinjingjing/lizhi_tupuqo/QueryOptimizer/
sh run.sh
echo "tupuqo restart"

cd /search/yinjingjing/6_fast_tupuqo/QueryOptimizer
sh run.sh
echo "tupu fastqo restart"

cd /search/yinjingjing/6_tupucache/WebCache
sh start.sh
echo "tupu cache restart"

cd /search/yinjingjing/6_fast_tupucache/WebCache
sh start.sh
echo "tupu fastcache restart"

cd /search/yinjingjing/alias_tupu_recommender
sh start.sh
echo "tupu recommender restart"

cd /search/yinjingjing/tightness_tupu_hint/HintQcServer/
#cd /search/yinjingjing/6_tupuhint/HintQcServer/
sh start.sh
echo "tupu hint restart"
