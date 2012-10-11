#export DTS=$(date +%Y%m%d%H%M)
#export MAVEN_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"

if [ ! -e sampleapp/src/it/java/edu/samplu/common/SauceLabsWebDriverHelper.java ]
then
	echo "Patching for Sauce Labs"
	patch -p0 < ../rtools/etc/SauceLabs.patch
fi

~/rtools/bin/mvn-log.sh -f sampleapp/pom.xml test-compile
~/rtools/bin/mvn-log.sh -f sampleapp/pom.xml failsafe:integration-test -Pstests -Dremote.public.url=$1 -Dremote.driver.saucelabs=defined -Dremote.driver.saucelabs.user=$2 -Dremote.driver.saucelabs.key=$3 -Dremote.driver.saucelabs.version=$4 -Dremote.driver.saucelabs.platform=$5 -Dremote.driver.saucelabs.browser=$6 -Dremote.public.userpool=$7 -Dit.test=$RUNNING_TEST
