# downloading saucelabs results using the scripts created at the end of the test run

#while :
while [ -s saucelabtargets.csv ]
do
	
	cd $1/$2
	for f in SauceLabsResources*.sh 
	do
		
		sleep 2
		chmod 755 $f
		./$f
		sleep 2
		mv $f Downloaded-$f
		chmod 644 Downloaded-$f
		
	done
	cd $1	
done
