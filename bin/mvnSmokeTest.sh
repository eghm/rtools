# remote.public.url remote.driver.saucelabs.user remote.driver.saucelabs.key remote.driver.saucelabs.version remote.driver.saucelabs.platform remote.driver.saucelabs.browser it.test remote.public.user rice.version 
cd ~/$9
export M2_HOME=~/apache-maven-3.0.4/
export PATH=$PATH:$M2_HOME/bin:~/rtools/bin
export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

if [ ! -e sampleapp/src/it/java/edu/samplu/common/SauceLabsWebDriverHelper.java ]
then
	echo "Patching for Sauce Labs"
	log-command.sh saucelabs.patch patch -p0 < ../rtools/etc/SauceLabs.patch
fi

export TEST=$7
export TEST_USER=$8
export TEST_PARAMS=""
while [ -s ../LegacyITsUsers.txt ] 
do
#if [ -s ../LegacyITsUsers.txt ] 
#then
	export TEST=$(tail -n 1 ../LegacyITsUsers.txt | cut -d : -f 1)
	export TEST_USER=$(tail -n 1 ../LegacyITsUsers.txt | cut -d : -f 2)
	TEST_PARAM=$(tail -n 1 ../LegacyITsUsers.txt | cut -d : -f 3-)
    TEST_PARAMS=`${TEST_PARAM/:/ }`
	sed '$d' ../LegacyITsUsers.txt > ../LegacyITsUsers.cut.txt
	mv ../LegacyITsUsers.cut.txt ../LegacyITsUsers.txt
#fi # if changed to while loop the done needs to be at the end of the file

export logname=$TEST-$TEST_USER-$4-$5-$6-$9-$DTS

touch ../logs/$9/$logname.test-compile.out 
ln -s ../logs/$9/$logname.test-compile.out $logname.test-compile.out
mvn -version  >> $logname.test-compile.out
echo "mvn -f sampleapp/pom.xml test-compile" >> $logname.test-compile.out
mvn -f sampleapp/pom.xml test-compile >> $logname.test-compile.out

touch ../logs/$9/$logname.out 
ln -s ../logs/$9/$logname.out $logname.out
mvn -version  >> $logname.out

echo "mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs=defined -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$4 -Dremote.driver.saucelabs.platform=$5 -Dremote.driver.saucelabs.browser=$6 -Dit.test=$TEST -Dremote.public.user=$$TEST_USER -Drice.version=$9 $TEST_PARAMS" >> $logname.out
mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs=defined -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$4 -Dremote.driver.saucelabs.platform=$5 -Dremote.driver.saucelabs.browser=$6 -Dit.test=$TEST -Dremote.public.user=$TEST_USER -Drice.version=$9 $TEST_PARAMS >> $logname.out
done