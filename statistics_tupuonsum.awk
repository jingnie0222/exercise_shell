BEGIN{
	firstline = 1;
        split("<200us;200-500us;500-1,000us;1,000-2,000us;2,000-5,000us;5,000-10,000us;10,000-20,000us;20,000-50,000us;50,000-80,000us;80,000-100,000us;100,000-200,000us;>200,000us", arrTimeScope, ";");
        split("PreProcess,LoadPage,fillPageData,MakeSummary,Reply",arrPipeline,",");
}
function getmax(arg1,arg2)
{
	if((arg1+0)>(arg2+0))
	{
		return arg1;
	}
	else
		return arg2;
}
function getmin(arg1,arg2)
{
	if((arg1+0)<(arg2+0))
		return arg1;
	else
		return arg2;
}
{	
	if(match($5,/\[Sogou-Observer/)==1 && $1=="[summary_kernel:LM_INFO]")
	{
		currentline ++;		
		if(int(currentline)%5000 == 0)
			printf("%d lines completed.\n", currentline);
		split($5, temp, ",");
		gsub(/cost=/, "", temp[2]);
		#gsub(/ret=/, "", temp[3]);
		if(firstline == 1)
		{
			max = temp[2];
			min = max;				
			firstline = 0;
		}
		else
		{
			max = getmax(temp[2],max);
			min = getmin(temp[2],min);
		}	
		temp[2]=temp[2]+0;		
		if(temp[2]<200)
			strDesc = 1;
		else if(temp[2]<500)
			strDesc = 2;
		else if(temp[2]<1000)
			strDesc = 3;
		else if(temp[2]<2000)
			strDesc = 4;
		else if(temp[2]<5000)
			strDesc = 5;
		else if(temp[2]<10000)
			strDesc = 6;
		else if(temp[2]<20000)
			strDesc = 7;	
		else if(temp[2]<50000)
			strDesc = 8;	
		else if(temp[2]<80000)
			strDesc = 9;	
		else if(temp[2]<100000)
                        strDesc = 10;
                else if(temp[2]<200000)
                        strDesc = 11;
		else
			strDesc = 12;
			
		countScope[strDesc]++;
		count++;
		total += temp[2];
		#if(temp[3] == 0)
			#countRet0 ++;

	}
	#if(match($7,"hit")==1 && match($5,"-Statistics-"))
	#{
		#temp[4]=$7;
		#gsub(/hit\(/, "", temp[4]);
		#gsub(/\):/, "", temp[4]);
		#hit[temp[4]]++;
	#}
        if(match($7,"hit")==1 && match($5,"-Statistics-"))
        {
                gsub(/\([[:space:]]/,"(",$0);
                gsub(/\(/,"",$8);
                gsub(/\)/,"",$10);
                gsub(/\(/,"",$11);
                gsub(/\)</,"",$13)
                gsub(/\(/,"",$17);
                gsub(/\),/,"",$18);

                countPipeline[1]+=$8;
                countPipeline[2]+=($10-$9);
                countPipeline[3]+=($11-$10);
                countPipeline[4]+=($13-$12);
                countPipeline[5]+=($18-$17);
        }
}
END{
	print "===========response time===========";
	print "avg\tmax\tmin";
	printf("%2.3fus\t%dus\t%dus\n", total/count, max, min);
	
	print "\n=====response time percentage====="
	for(i=1; i<=12; i++)
		printf("%s:\t%2.4f%(%d/%d)\n",arrTimeScope[i], countScope[i]/count*100, countScope[i], count);
	
        print "\n===========Pipeline time==========="
        for(i=1;i<=5;i++)
                printf("%s:\t%2.4f\n",arrPipeline[i],countPipeline[i]/count);

	#print "\n========Ret=0 percentage========"
	#printf("%2.4f\%(%d/%d)\n", countRet0*100/count, countRet0, count);

	#print "\n========hit=1 percentage========"
	#printf("%2.4f\%(%d/%d)\n", hit[1]*100/count,hit[1],count);
	

}
