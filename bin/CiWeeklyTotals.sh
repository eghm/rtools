CiJenkinsJobsBuilds.sh "$@"

# RESULTS_DIR created in CiJenkinsJobsBuilds.sh
cd $3 

# $4 is the jenkins job arguments (rice-2.4-test-unit:120:134,rice-2.4-smoke-test:134:178)
# useful for figuring out which files to subtract from one another. split , split :

for f in *.json
do
	groovy $R_HOME/rtools/bin/CiCounts.groovy $(pwd)/$f > $(pwd)/$f.failCount.txt		
done

#rm -rf jobs.txt
#echo TEST=$(echo $4 | tr ',' '\n' | cut -d: -f1)

for i in $(echo $4 | tr "," "\n" | cut -d: -f1)
do
#	 echo $i
#    echo "find . -name '$i-*.failCount.txt' > $i.failCountFiles.txt"
    find . -name '$i-*.failCount.txt' > $i.failCountFiles.txt
done

for g in *.failCountFiles.txt
do
	FIRST=$(head -n 1 $g)
	SECOND=$(tail -n 1 $g)
#    echo "awk '{print $FIRST - $SECOND}' > $g.fail.diff"
    awk '{print $FIRST - $SECOND }' > $g.fail.diff
done


