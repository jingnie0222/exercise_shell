{
a[NR]=$0;sum+=$0
}

END{
asort(a);printf "TIME:min:%d max:%d avg:%f\n" ,a[1],a[NR],sum/NR;
while(i++<NR){
if(a[i]<=2){j["a:0-2"]++
}
                        
else if(a[i]>2 && a[i]<=5){
j["b:2-5"]++
}
                        
else if(a[i]>5 && a[i]<=10){
j["c:5-10"]++}
			
else if(a[i]>10 && a[i]<=20){j["d:10-20"]++}
                        
else if(a[i]>20 && a[i]<=50){
j["e:20-50"]++}
                        
else if(a[i]>50 && a[i]<=100){
j["f:50-100"]++}
                        
else if(a[i]>100 && a[i]<=200){j["g:100-200"]++}
                       
else if(a[i]>200 && a[i]<=500){j["h:200-500"]++
}
                        
else if(a[i]>500 && a[i]<=1000){j["i:500-1000"]++
}
                        
else if(a[i]>1000 && a[i]<=2000){
j["j:1000-2000"]++}
                       
else if(a[i]>2000 && a[i]<=5000){
j["k:2000-5000"]++
}
                        
else if(a[i]>5000 && a[i]<=10000){
j["l:5000-10000"]++
}
			
else if(a[i]>10000 && a[i]<=20000){
j["m:10000-20000"]++}
else{j["n:>20000"]++
}
        }
        
for( k in j)print k":",j[k]|"sort"
}
