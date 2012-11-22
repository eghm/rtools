# remote.public.url remote.driver.saucelabs.user remote.driver.saucelabs.key remote.driver.saucelabs.version remote.driver.saucelabs.platform remote.driver.saucelabs.browser it.test remote.public.user rice.version 
cd ~/$9
export M2_HOME=~/apache-maven-3.0.4/
export PATH=$PATH:$M2_HOME/bin:~/rtools/bin
export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

export TEST=$1
export TEST_PARAMS2=""
while [ -s ../iTests.txt ] 
do
	export TEST=$(tail -n 1 ../iTests.txt)
	export TEST_PARAM=$(tail -n 1 ../iTests.txt | cut -d : -f 2-)
    export TEST_PARAMS=${TEST_PARAM//:/ }
    export TEST_PARAMS2=${TEST_PARAMS//:/ }
	sed '$d' ..iTests.txt > ../iTests.cut.txt
	mv ../iTests.cut.txt ../iTests.txt

    export logname=$TEST-$DTS

    touch ../logs/$9/$logname.test-compile.out 
    ln -s ../logs/$9/$logname.test-compile.out $logname.test-compile.out
    mvn -version  >> $logname.test-compile.out

    echo "" >> $logname.out
    mvn-itests.sh -Dit.test=$TEST $TEST_PARAMS2 >> $logname.out
done
