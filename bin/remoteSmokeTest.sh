# rice.version remote.public.url remote.driver.saucelabs.version remote.driver.saucelabs.platform remote.driver.saucelabs.browser 
source ~/.bash_profile
cd ~/$1

export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

if [ ! -e sampleapp/src/it/java/edu/samplu/common/SauceLabsWebDriverHelper.java ]
then
	echo "Patching for Sauce Labs"
	log-command.sh saucelabs.patch patch -p0 < ../rtools/etc/SauceLabs.patch
	
    touch ../logs/$1/SauceLabs.patch-compile-$DTS.out 
    ln -s ../logs/$1/SauceLabs.patch-compile-$DTS.out SauceLabs.patch-compile-$DTS.out
    mvn -version  >> SauceLabs.patch-compile-$DTS.out
    echo "mvn -f sampleapp/pom.xml compile test-compile" >> SauceLabs.patch-compile-$DTS.out
    mvn -f sampleapp/pom.xml compile test-compile >> SauceLabs.patch-compile-$DTS.out	
fi

while [ -s ../smokeTestList.txt ] 
do
	export TEST=$(tail -n 1 ../smokeTestList.txt | cut -d , -f 1)
	export TEST_USER=$(tail -n 1 ../smokeTestList.txt | cut -d , -f 2)
	export SAUCE_USER=$(tail -n 1 ../smokeTestList.txt | cut -d , -f 3)
	export SAUCE_KEY=$(tail -n 1 ../smokeTestList.txt | cut -d , -f 4)

	export TEST_PARAM=$(tail -n 1 ../smokeTestList.txt | cut -d , -f 5-)
    export TEST_PARAMS=${TEST_PARAM//:/ }
    export TEST_PARAMS2=${TEST_PARAMS//:/ }
	sed '$d' ../smokeTestList.txt > ../smokeTestList.cut.txt
	mv ../smokeTestList.cut.txt ../smokeTestList.txt

    export logname=$TEST-$TEST_USER-$SAUCE_USER-$DTS
	touch ../logs/$1/$logname.out 
	ln -s ../logs/$1/$logname.out $logname.out
	mvn -version  >> $logname.out

    echo "mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.driver.saucelabs=defined -Drice.version=$1 -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Dremote.public.url=$2 -Dremote.driver.saucelabs.version=$3 -Dremote.driver.saucelabs.platform=$4 -Dremote.driver.saucelabs.browser=$5 -Dremote.driver.saucelabs.user=$SAUCE_USER -Dremote.driver.saucelabs.key=$SAUCE_KEY    $TEST_PARAMS2" >> $logname.out
    mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.driver.saucelabs=defined -Drice.version=$1 -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Dremote.public.url=$2 -Dremote.driver.saucelabs.version=$3 -Dremote.driver.saucelabs.platform=$4 -Dremote.driver.saucelabs.browser=$5 -Dremote.driver.saucelabs.user=$SAUCE_USER -Dremote.driver.saucelabs.key=$SAUCE_KEY    $TEST_PARAMS2 >> $logname.out

done