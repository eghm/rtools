# rice.version 
source ~/.bash_profile
cd ~/$1
export DTS=$(date +%Y%m%d%H%M)
export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

export TEST=""
while [ -s ../iTests.txt ] 
do
	export TEST=$(tail -n 1 ../iTests.txt)
	sed '$d' ../iTests.txt > ../iTests.cut.txt
	mv ../iTests.cut.txt ../iTests.txt

    export logname=$TEST-itest-$DTS

    touch ../logs/$1/$logname.out 
    ln -s ../logs/$1/$logname.out $logname.out
    mvn -version  >> $logname.out

    echo "mvn -Pitests verify -Ddts.log.filename=itests-log.log -Dit.test=$TEST $2 $3 $4 $5 $6 $7 $8 $9" >> $logname.out
    mvn -Pitests verify -Ddts.log.filename=itests-log.log -Dit.test=$TEST $2 $3 $4 $5 $6 $7 $8 $9 >> $logname.out
done