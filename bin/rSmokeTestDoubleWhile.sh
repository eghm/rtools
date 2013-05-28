# remote.public.url remote.driver.saucelabs.user remote.driver.saucelabs.key remote.driver.saucelabs.version remote.driver.saucelabs.platform remote.driver.saucelabs.browser it.test remote.public.user rice.version 
cd $R_HOME/$9
export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

#if [ ! -e sampleapp/src/it/java/edu/samplu/common/SauceLabsWebDriverHelper.java ]
#then
#	echo "Patching for Sauce Labs"
#	log-command.sh saucelabs.patch patch -p0 < ../rtools/etc/SauceLabs.patch
#fi

export SAUCE_VERSION=$4;
export SAUCE_OS=$5;
export SAUCE_BROWSER=$6

export TEST=$7
export TEST_USER=$8
export TEST_PARAMS2=""
while [ -s ../SauceSmokeTests.csv ] 
do
##if [ -s ../SmokeTestsUsers.csv ] 
##then
	export TEST=$(tail -n 1 ../SauceSmokeTests.csv | cut -d : -f 1)
	export TEST_USER=$(tail -n 1 ../SauceSmokeTests.csv | cut -d : -f 2)
#	export TEST_PARAM=$(tail -n 1 SauceSmokeTests.csv | cut -d : -f 3-)
#    export TEST_PARAMS=${TEST_PARAM//:/ }
#    export TEST_PARAMS2=${TEST_PARAMS//:/ }
##fi # if changed to while loop the done needs to be at the end of the file
    cp targets.txt ../targets.2.txt
    while [ -s ../targets.2.txt ] 
    do
        export SAUCE_VERSION=$(tail -n 1 ../targets.2.txt | cut -d : -f 2);
        export SAUCE_OS=$(tail -n 1 ../targets.2.txt | cut -d : -f 3);
        export SAUCE_BROWSER=$(tail -n 1 ../targets.2.txt | cut -d : -f 1);	
		
export logname=$TEST-$TEST_USER-$SAUCE_OS-$SAUCE_BROWSER-$SAUCE_VERSION-$9-$DTS

#touch ../logs/$9/$logname.test-compile.out 
#ln -s ../logs/$9/$logname.test-compile.out $logname.test-compile.out
#mvn -version  >> $logname.test-compile.out
#echo "mvn -f sampleapp/pom.xml test-compile" >> $logname.test-compile.out
#mvn -f sampleapp/pom.xml test-compile >> $logname.test-compile.out

touch ../logs/$9/$logname.out 
ln -s ../logs/$9/$logname.out $logname.out
mvn -version  >> $logname.out

echo "mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$SAUCE_VERSION -Dremote.driver.saucelabs.platform=$SAUCE_OS -Dremote.driver.saucelabs.browser=$SAUCE_BROWSER -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Drice.version=$9 -Dremote.jgrowl.enabled=false $TEST_PARAMS2" >> $logname.out
bash mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$SAUCE_VERSION -Dremote.driver.saucelabs.platform=$SAUCE_OS -Dremote.driver.saucelabs.browser=$SAUCE_BROWSER -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Drice.version=$9 -Dremote.jgrowl.enabled=false $TEST_PARAMS2 >> $logname.out 2>&1 &

wait  ${!}

		sed '$d' ../targets.2.txt > ../targets.cut.txt
		mv ../targets.cut.txt ../targets.2.txt

    done
	sed '$d' ../SauceSmokeTest.csv > ../SauceSmokeTests.cut.csv
	mv ../SauceSmokeTests.cut.csv ../SauceSmokeTests.csv


done
