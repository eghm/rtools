export M2_HOME=~/apache-maven-3.0.4/
export PATH=$PATH:$M2_HOME/bin:~/rtools/bin
export rDir=${PWD##*/}
export DTS=$(date +%Y%m%d%H%M)
export RUNNING_TEST=$(cat RUNNING_TEST)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

if [ ! -e sampleapp/src/it/java/edu/samplu/common/SauceLabsWebDriverHelper.java ]
then
	echo "Patching for Sauce Labs"
	patch -p0 < ../rtools/etc/SauceLabs.patch
fi

export logname=$RUNNING_TEST.$DTS

touch ../logs/$rDir/$logname.test-compile.out 
ln -s ../logs/$rDir/$logname.test-compile.out $logname.test-compile.out
mvn -version  >> $logname.test-compile.out
echo "mvn -f sampleapp/pom.xml test-compile" >> $logname.test-compile.out
mvn -f sampleapp/pom.xml test-compile >> $logname.test-compile.out

touch ../logs/$rDir/$logname.out 
ln -s ../logs/$rDir/$logname.out $logname.out
mvn -version  >> $logname.out

echo "mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs=defined -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$4 -Dremote.driver.saucelabs.platform=$5 -Dremote.driver.saucelabs.browser=$6 -Dremote.public.userpool=$7 -Dit.test=$RUNNING_TEST" >> $logname.out
mvn -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs=defined -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$4 -Dremote.driver.saucelabs.platform=$5 -Dremote.driver.saucelabs.browser=$6 -Dremote.public.userpool=$7 -Dit.test=$RUNNING_TEST >> $logname.out
