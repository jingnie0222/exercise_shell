cat record_top | grep "java-1.6.0-sun-1.6.0.95.x86_64" | awk '{print $5,$6,$9}' > searchhub_jiankong.csv
cat record_top | grep lizhi_tupuqo | awk '{print $5,$6,$9}' > qo_jiankong.csv
cat record_top | grep 6_fast_tupuqo | awk '{print $5,$6,$9}' > fastqo_jiankong.csv
cat record_top | grep 6_tupucache | awk '{print $5,$6,$9}' > cache_jiankong.csv
cat record_top | grep 6_fast_tupucache | awk '{print $5,$6,$9}' > fastcache_jiankong.csv
cat record_top | grep alias_tupu_recommender | awk '{print $5,$6,$9}' > recommender_jiankong.csv
cat record_top | grep tightness_tupu_hint | awk '{print $5,$6,$9}' > hint_jiankong.csv

sed -i  -e 's/g//'g -e 's/m//'  searchhub_jiankong.csv
sed -i  's/g//'g qo_jiankong.csv
sed -i  's/m//'g fastqo_jiankong.csv 
sed -i  's/g//'g cache_jiankong.csv
sed -i  's/g//'g fastcache_jiankong.csv 
sed -i  's/g//'g recommender_jiankong.csv
sed -i  's/g//'g hint_jiankong.csv

sz searchhub_jiankong.csv  qo_jiankong.csv  fastqo_jiankong.csv  cache_jiankong.csv  fastcache_jiankong.csv  recommender_jiankong.csv  hint_jiankong.csv
